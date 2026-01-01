import 'dart:convert';

List<RateModel> getAllServiceRatesModelFromJson(String str) =>
    List<RateModel>.from(
        json.decode(str)["data"].map((x) => RateModel.fromJson(x)));

String getAllServiceRatesModelToJson(List<RateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllServiceRatesModel {
  String? message;
  List<RateModel>? data;

  GetAllServiceRatesModel({this.message, this.data});

  GetAllServiceRatesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <RateModel>[];
      json['data'].forEach((v) {
        data!.add(new RateModel.fromJson(v));
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

class RateModel {
  String? label;
  int? id;

  RateModel({this.label, this.id});

  RateModel.fromJson(Map<String, dynamic> json) {
    label = json['rate'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.label;
    data['id'] = this.id;
    return data;
  }
}
