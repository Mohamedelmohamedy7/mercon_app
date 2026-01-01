import 'dart:convert';

List<MobileSlider> mobileSliderFromJson(String str) => List<MobileSlider>.from(json.decode(str)["data"].map((x) => MobileSlider.fromJson(x)));

String mobileSliderToJson(List<MobileSlider> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MobileSlider {
  MobileSlider({
    required this.sliderPath,
    required this.id,
    this.isDeleted,
    this.createdDate,
    this.modifiedDate,
    this.createdByNameId,
    this.modifiedByNameId,
    this.createdByName,
    this.modifiedByName,
  });

  String sliderPath;
  int id;
  dynamic isDeleted;
  DateTime? createdDate;
  dynamic modifiedDate;
  String? createdByNameId;
  dynamic modifiedByNameId;
  dynamic createdByName;
  dynamic modifiedByName;

  factory MobileSlider.fromJson(Map<String, dynamic> json) => MobileSlider(
    sliderPath: json["sliderPath"],
    id: json["id"],
    isDeleted: json["isDeleted"],
    createdDate: json["createdDate"] == null
        ? null
        : DateTime.parse(json["createdDate"]),
    modifiedDate: json["modifiedDate"],
    createdByNameId: json["createdByNameId"],
    modifiedByNameId: json["modifiedByNameId"],
    createdByName: json["createdByName"],
    modifiedByName: json["modifiedByName"],
  );

  Map<String, dynamic> toJson() => {
    "sliderPath": sliderPath,
    "id": id,
    "isDeleted": isDeleted,
    "createdDate": createdDate?.toIso8601String(),
    "modifiedDate": modifiedDate,
    "createdByNameId": createdByNameId,
    "modifiedByNameId": modifiedByNameId,
    "createdByName": createdByName,
    "modifiedByName": modifiedByName,
  };
}
