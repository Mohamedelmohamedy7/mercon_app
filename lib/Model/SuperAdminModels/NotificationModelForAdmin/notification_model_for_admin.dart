import 'dart:convert';

List<NotificationModel> notificationModelForAdminFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str)["data"].map((x) => NotificationModel.fromJson(x)));

String notificationModelForAdminToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModelForAdmin {
  String? message;
  List<NotificationModel>? data;

  NotificationModelForAdmin({this.message, this.data});

  NotificationModelForAdmin.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationModel>[];
      json['data'].forEach((v) {
        data!.add(new NotificationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationModel {
  String? senderId;
  String? senderName;
  String? userId;
  bool? isRead;
  String? descriptionEn;
  String? titleEn;
  String? descriptionAr;
  String? titleAr;
  bool? isNew;
  bool? flagAdmin;
  int? compID;
  int? id;
  String? createdDate;

  NotificationModel(
      {this.senderId,
        this.senderName,
        this.userId,
        this.isRead,
        this.descriptionEn,
        this.titleEn,
        this.descriptionAr,
        this.titleAr,
        this.isNew,
        this.flagAdmin,
        this.compID,
        this.id,
        this.createdDate,});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    senderName = json['senderName'];
    userId = json['userId'];
    isRead = json['isRead'];
    descriptionEn = json['descriptionEn'];
    titleEn = json['titleEn'];
    descriptionAr = json['descriptionAr'];
    titleAr = json['titleAr'];
    isNew = json['isNew'];
    flagAdmin = json['flagAdmin'];
    compID = json['compID'];
    id = json['id'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senderId'] = this.senderId;
    data['senderName'] = this.senderName;
    data['userId'] = this.userId;
    data['isRead'] = this.isRead;
    data['descriptionEn'] = this.descriptionEn;
    data['titleEn'] = this.titleEn;
    data['descriptionAr'] = this.descriptionAr;
    data['titleAr'] = this.titleAr;
    data['isNew'] = this.isNew;
    data['flagAdmin'] = this.flagAdmin;
    data['compID'] = this.compID;
    data['id'] = this.id;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
