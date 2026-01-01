import 'dart:convert';

List<ServicesModel> parseServiceList(String src) => List<ServicesModel>.from(json.decode(src)["data"].map<ServicesModel>((json) => ServicesModel.fromJson(json)));

class ServicesModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String name;
  final String iconURLPath;

  ServicesModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.name,
    required this.iconURLPath,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      id: json['id'] as int,
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
      name: json['name'] as String,
      iconURLPath: json['iconURLPath'] as String,
    );
  }
}
