import 'dart:convert';
import 'package:core_project/helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'View/Widget/comman/comman_Image.dart';
import 'helper/ImagesConstant.dart';

const String apiKey = 'a0e069ec6eb2a4f851c7f50b463d14a7';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool loading = true;

  double? lat;
  double? lon;

  String city = '';
  String country = '';

  double temp = 0;
  double feelsLike = 0;

  String description = '';
  String weatherMain = '';
  String iconCode = '';

  @override
  void initState() {
    super.initState();
    loadAll();
  }

  Future<void> loadAll() async {
    try {
      final position = await _getLocation();
      lat = position.latitude;
      lon = position.longitude;

      await _getPlace(lat!, lon!);
      await _getWeather(lat!, lon!);
    } catch (e) {
      debugPrint('Weather Error: $e');
    }

    setState(() => loading = false);
  }

  // 📍 Location
  Future<Position> _getLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('Location services disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permission denied forever');
    }

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // 🏙️ City
  Future<void> _getPlace(double lat, double lon) async {
    final places = await placemarkFromCoordinates(lat, lon);
    city = places.first.locality ?? '';
    country = places.first.country ?? '';
  }

  // 🌤️ Weather
  Future<void> _getWeather(double lat, double lon) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather'
        '?lat=$lat&lon=$lon&units=metric&lang=ar&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    temp = data['main']['temp'].toDouble();
    feelsLike = data['main']['feels_like'].toDouble();

    description = data['weather'][0]['description'];
    weatherMain = data['weather'][0]['main'];
    iconCode = data['weather'][0]['icon'];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: loading
          ? cachedImage(ImagesConstants.logo, width: 50, height: 50)
          : Row(
        mainAxisAlignment: MainAxisAlignment.start,
         children: [
          Icon(
            getWeatherIcon(
              main: weatherMain,
              description: description,
              iconCode: iconCode,
              temp: temp,
            ),
            color: getWeatherColor(temp, weatherMain),
            size: 22,
          ),
          const SizedBox(width: 6),
          Text(
            '${temp.toStringAsFixed(1)}°C',
            style: CustomTextStyle.regular14Gray.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '• $description',
            style: CustomTextStyle.regular14Black.copyWith(
              fontSize: 11,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

IconData getWeatherIcon({
  required String main,
  required String description,
  required String iconCode,
  required double temp,
}) {
  final desc = description.toLowerCase();

  if (temp <= 5) return Icons.ac_unit;

  if (main == 'Thunderstorm') return Icons.thunderstorm;

  if (main == 'Rain' || main == 'Drizzle') return Icons.grain;

  if (main == 'Mist' || main == 'Fog' || desc.contains('ضباب')) {
    return Icons.blur_on;
  }

  if (main == 'Clouds') return Icons.wb_cloudy;

  if (iconCode.contains('d')) return Icons.wb_sunny;

  return Icons.nightlight_round;
}
Color getWeatherColor(double temp, String main) {
  if (temp <= 5) return Colors.lightBlueAccent;
  if (temp >= 35) return Colors.orange;
  if (main == 'Clouds') return Colors.grey;
  return Colors.white;
}
