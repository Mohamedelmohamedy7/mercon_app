import 'dart:convert';

List<GateModel> gateModelFromJson(String str) => List<GateModel>.from(
    json.decode(str)["data"].map((x) => GateModel.fromJson(x)));

String gateModelToJson(List<GateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetGateModel {
  String? message;
  List<GateModel>? data;

  GetGateModel({this.message, this.data});

  GetGateModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <GateModel>[];
      json['data'].forEach((v) {
        data!.add(new GateModel.fromJson(v));
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

class GateModel {
  String? name;
  String? checkOutDate;
  String? checkinDate;
  String? type;
  String? phoneNumber;
  String? unitName;
  String? statusName;
  int? status;

  GateModel(
      {this.name,
        this.checkOutDate,
        this.checkinDate,
        this.type,
        this.phoneNumber,
        this.unitName,
        this.statusName,
        this.status});

  GateModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    checkOutDate = json['checkOutDate'];
    checkinDate = json['checkinDate'];
    type = json['type'];
    phoneNumber = json['phoneNumber'];
    unitName = json['unitName'];
    statusName = json['statusName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['checkOutDate'] = this.checkOutDate;
    data['checkinDate'] = this.checkinDate;
    data['type'] = this.type;
    data['phoneNumber'] = this.phoneNumber;
    data['unitName'] = this.unitName;
    data['statusName'] = this.statusName;
    data['status'] = this.status;
    return data;
  }
}