import 'dart:convert';

List<User> userUnitModelFromJson(String str) => List<User>.from(
    json.decode(str)["data"].map((x) => User.fromJson(x)));

String unitModelToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OwnerUserUnits {
  String? message;
  List<User>? data;

  OwnerUserUnits({this.message, this.data});

  OwnerUserUnits.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data!.add(new User.fromJson(v));
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

class User {
  int? id;
  String? profileImage;
  String? nameAr;
  String? nameEn;
  String? name;
  String? phoneNumber;
  String? nationalCardNumber;
  String? additionalPhoneNumber;
  String? permanentAddress;
  bool? isActive;
  bool? isApproved;
  bool? isBlocked;
  String? userID;
  String? unitOwnerTypeId;
  String? createdDate;
  String? modifiedDate;
  String? modifiedByUserName;
  User(
      {this.id,
        this.profileImage,
        this.nameAr,
        this.nameEn,
        this.name,
        this.phoneNumber,
        this.nationalCardNumber,
        this.additionalPhoneNumber,
        this.permanentAddress,   this.createdDate,
        this.modifiedDate,
        this.modifiedByUserName,
        this.isActive,
        this.isApproved,
        this.isBlocked,
        this.unitOwnerTypeId,
        this.userID,});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profileImage'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    name = json['name'];
    phoneNumber = json['phoneNumber']; createdDate = json['CreatedDate'];
    modifiedDate = json['ModifiedDate'];
    modifiedByUserName = json['ModifiedByUserName'];
    nationalCardNumber = json['nationalCardNumber'];
    additionalPhoneNumber = json['additionalPhoneNumber'];
    permanentAddress = json['permanentAddress'];
    isActive = json['isActive'];
    isApproved = json['isApproved'];
    isBlocked = json['isBlocked']??false;
    userID = json['userID'];
    unitOwnerTypeId=json['unitOwnerTypeId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profileImage'] = this.profileImage;
    data['nameAr'] = this.nameAr;
    data['nameEn'] = this.nameEn;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['nationalCardNumber'] = this.nationalCardNumber;
    data['additionalPhoneNumber'] = this.additionalPhoneNumber;
    data['permanentAddress'] = this.permanentAddress;
    data['isActive'] = this.isActive;
    data['isApproved'] = this.isApproved;
    data['isBlocked'] = this.isBlocked;
    data['userID'] = this.userID;
    return data;
  }
}


