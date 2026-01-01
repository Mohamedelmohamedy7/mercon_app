

import 'dart:convert';

List<NewsModel> MyNewsFromJson(String str) => List<NewsModel>.from(json.decode(str)["data"].map((x) => NewsModel.fromJson(x)));

class NewsModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String name;
  final String descriptionAr;
  final String descriptionEn;
    String? imageUrl;
   String? videoUrl;
   String? createdDate;

  NewsModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.name,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.imageUrl,
    required this.videoUrl,
    required this.createdDate,

  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      name: json['name'],
      descriptionAr: json['descriptionAr'],
      descriptionEn: json['descriptionEn'],
      imageUrl: json['imageUrl']??"",
      videoUrl: json['videoUrl']??"",
      createdDate: json['createdDate']??"",
    );
  }

}
