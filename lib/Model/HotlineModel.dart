import 'dart:convert';

List<HotlineData> parseHotlineData(String src)
=> List<HotlineData>.from(json.decode(src)["data"].map<HotlineData>((json) => HotlineData.fromJson(json)));

class HotlineResponse {
  final String message;
  final List<HotlineData> data;

  HotlineResponse({required this.message, required this.data});

  factory HotlineResponse.fromJson(Map<String, dynamic> json) {
    return HotlineResponse(
      message: json['message'],
      data: (json['data'] as List)
          .map((data) => HotlineData.fromJson(data))
          .toList(),
    );
  }
}

class HotlineData {
  final String hotlineNumber;
  final String internalRegulation;
  final int id;


  HotlineData({
    required this.hotlineNumber,
    required this.internalRegulation,
    required this.id,
  });

  factory HotlineData.fromJson(Map<String, dynamic> json) {
    return HotlineData(
      hotlineNumber: json['hotlineNumber'],
      internalRegulation: json['internalRegulation']??"",
      id: json['id'],
    );
  }
}
