import 'dart:convert';

List<RequestModel> requestsNewUnitsFromJson(String str) =>
    List<RequestModel>.from(
        json.decode(str)["data"].map((x) => RequestModel.fromJson(x)));

String requestsNewUnitsToJson(List<RequestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestsNewUnitsModel {
  String? message;
  List<RequestModel>? data;

  RequestsNewUnitsModel({this.message, this.data});

  RequestsNewUnitsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <RequestModel>[];
      json['data'].forEach((v) {
        data!.add(new RequestModel.fromJson(v));
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

class RequestModel {
  int? id;
  String? profileImage;
  String? nameAr;
  String? nameEn;
  String? name;
  String? phoneNumber;
  String? nationalCardNumber;
  String? additionalPhoneNumber;
  String? permanentAddress;
  String? idImageURL;
  bool? isActive;
  bool? isApproved;
  bool? isBlocked;
  String? unitOwnerTypeId;
  String? userID;
  int? statusID;
  int? unitID;

  RequestModel(
      {this.id,
      this.profileImage,
      this.nameAr,
      this.nameEn,
      this.name,
      this.phoneNumber,
      this.nationalCardNumber,
      this.additionalPhoneNumber,
      this.permanentAddress,
      this.idImageURL,
      this.isActive,
      this.isApproved,
      this.isBlocked,
      this.unitOwnerTypeId,
      this.userID,
      this.statusID,
      this.unitID});

  RequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profileImage'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    nationalCardNumber = json['nationalCardNumber'];
    additionalPhoneNumber = json['additionalPhoneNumber'];
    permanentAddress = json['permanentAddress'];
    idImageURL = json['idImageURL'];
    isActive = json['isActive'];
    isApproved = json['isApproved'];
    isBlocked = json['isBlocked'];
    unitOwnerTypeId = json['unitOwnerTypeId'].toString();
    userID = json['userID'];
    statusID = json['statusID'];
    unitID = json['unitID'];
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
    data['idImageURL'] = this.idImageURL;
    data['isActive'] = this.isActive;
    data['isApproved'] = this.isApproved;
    data['isBlocked'] = this.isBlocked;
    data['unitOwnerTypeId'] = this.unitOwnerTypeId;
    data['userID'] = this.userID;
    data['statusID'] = this.statusID;
    data['unitID'] = this.unitID;
    return data;
  }
}
