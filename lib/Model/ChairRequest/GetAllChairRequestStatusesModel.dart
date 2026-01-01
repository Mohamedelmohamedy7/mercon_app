import 'dart:convert';

List<ChairRequestStatusModel> chairRequestStatusFromJson(String str) =>
    List<ChairRequestStatusModel>.from(json
        .decode(str)["data"]
        .map((x) => ChairRequestStatusModel.fromJson(x)));

class GetAllChairRequestStatusesModel {
  String? message;
  List<ChairRequestStatusModel>? data;

  GetAllChairRequestStatusesModel({this.message, this.data});

  GetAllChairRequestStatusesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ChairRequestStatusModel>[];
      json['data'].forEach((v) {
        data!.add(new ChairRequestStatusModel.fromJson(v));
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

class ChairRequestStatusModel {
  String? status;
  bool? forAdmin;
  int? id;
  String? createdDate;

  ChairRequestStatusModel(
      {this.status, this.forAdmin, this.id, this.createdDate});

  ChairRequestStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    forAdmin = json['forAdmin'];
    id = json['id'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['forAdmin'] = this.forAdmin;
    data['id'] = this.id;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
