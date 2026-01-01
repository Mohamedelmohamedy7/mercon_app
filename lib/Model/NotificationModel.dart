import 'dart:convert';

List<NotificationModel> parseNotificationModel(String src) => List<NotificationModel>.from(json.decode(src)["data"].map<NotificationModel>((json)
=> NotificationModel.fromJson(json)));

class NotificationModel {
  final String? senderId;
  final String senderName;
  final String userId;
  final bool isRead;
  final String descriptionEn;
  final String titleEn;
  final String descriptionAr;
  final String titleAr;
  final bool isNew;
  final int id;
  final DateTime createdDate;
  final DateTime? modifiedDate;
  final String? createdByNameId;
  final String? modifiedByNameId;
  final String? createdByName;
  final String? modifiedByName;

  final String ? url;

  NotificationModel({
    this.senderId,
    required this.senderName,
    required this.userId,
    required this.isRead,
    required this.descriptionEn,
    required this.titleEn,
    required this.descriptionAr,
    required this.titleAr,
    required this.isNew,
    required this.id,
    required this.createdDate,
    this.modifiedDate,
    this.createdByNameId,
    this.modifiedByNameId,
    this.createdByName,
    this.modifiedByName,
    this.url,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      senderId: json['senderId'],
      senderName: json['senderName']??"",
      userId: json['userId'],
      isRead: json['isRead'],
      descriptionEn: json['descriptionEn']??"",
      titleEn: json['titleEn']??"",
      descriptionAr: json['descriptionAr']??"",
      titleAr: json['titleAr'],
      isNew: json['isNew'],
      id: json['id'],
      url: json['url'],
      createdDate: DateTime.parse(json['createdDate']),
      modifiedDate: json['modifiedDate'] != null ? DateTime.parse(json['modifiedDate']) : null,
      createdByNameId: json['createdByNameId'],
      modifiedByNameId: json['modifiedByNameId'],
      createdByName: json['createdByName'],
      modifiedByName: json['modifiedByName'],
    );
  }
}
