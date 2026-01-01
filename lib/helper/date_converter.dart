import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('yyyy MMM dd').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime).toLocal();
  }

  static String localDateToIsoStringAMPM(DateTime dateTime) {
    return DateFormat('h:mm a | d-MMM-yyyy ').format(dateTime.toLocal());
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('HH:mm').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    try {
      return DateFormat('dd - MM - yyyy')
          .format(isoStringToLocalDate(dateTime));
    } catch (e) {
      return "";
    }
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime.toLocal());
  }

  static String isoStringToLocalDateAndTime(String dateTime) {
    return DateFormat('dd-MMM-yyyy hh:mm a')
        .format(isoStringToLocalDate(dateTime));
  }

  static String formatDateString(String date) {
    DateTime? parsedDate = DateTime.tryParse(date);
    return parsedDate != null
        ? DateFormat.yMMMMd('ar').format(parsedDate)
        : ""; // Format in Arabic
  }


  static  String formatDateTimeBasedOnLocale(String? rawDate, BuildContext context) {
    const arabicNumbers = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];

    if(rawDate==null)
      {
        return "";
      }
    String convertToArabicNumber(String input) {
      return input.replaceAllMapped(RegExp(r'\d'), (match) {
        return arabicNumbers[int.parse(match.group(0)!)];
      });
    }

    DateTime date = DateTime.tryParse(rawDate ?? '') ?? DateTime.now();

    // Get current app locale (like: 'en' or 'ar')
    final locale = Localizations.localeOf(context).languageCode;

    if (locale == 'ar') {
      final day = convertToArabicNumber(DateFormat('d', 'ar').format(date));
      final month = DateFormat('MMMM', 'ar').format(date);
      final year = convertToArabicNumber(DateFormat('y', 'ar').format(date));
      final time = convertToArabicNumber(DateFormat('h:mm a', 'ar').format(date));
      return '$day $month $year في $time';
    } else {
      final day = DateFormat('d').format(date);
      final month = DateFormat('MMMM').format(date);
      final year = DateFormat('y').format(date);
      final time = DateFormat('h:mm a').format(date);
      return '$day $month $year at $time';
    }
  }
}
