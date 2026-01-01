import 'dart:convert';
import 'package:core_project/Utill/Local_User_Data.dart';

List<ChairRequest> ChairRequestFromJson(String str) => List<ChairRequest>.from(
    json.decode(str)["data"].map((x) => ChairRequest.fromJson(x)));

class GetAllChairRequestsModel {
  String? message;
  List<ChairRequest>? data;

  GetAllChairRequestsModel({this.message, this.data});

  GetAllChairRequestsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ChairRequest>[];
      json['data'].forEach((v) {
        data!.add(new ChairRequest.fromJson(v));
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

class ChairRequest {
  int? id;
  int? count;
  String? description;
  String? userId;
  String? ownerName;
  int? statusID;
  String? statusName;

  ChairRequest(
      {this.id,
      this.count,
      this.description,
      this.userId,
      this.ownerName,
      this.statusID,
      this.statusName});

  ChairRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    description = json['description'];
    userId = json['userID'];
    ownerName = json['ownerName'];
    statusID = json['statusID'];
    statusName = json['statusName'];
  }

  Map<String, dynamic> toJson({bool create=false,bool admin=false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(!create)
    data['id'] = this.id;
    data['count'] = this.count;
    data['description'] = this.description;
 // if(!admin)
    data['userID'] = this.userId ?? globalAccountData.getId() ?? 0;
    data['ownerName'] = this.ownerName;
    data['statusID'] = this.statusID;
    data['statusName'] = this.statusName;
    return data;
  }
}
