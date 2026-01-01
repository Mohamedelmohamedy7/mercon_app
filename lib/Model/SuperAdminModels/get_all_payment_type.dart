import 'dart:convert';

List<PaymentType> getPaymentTypesModelFromJson(String str) => List<PaymentType>.from(
    json.decode(str)["data"].map((x) => PaymentType.fromJson(x)));

String getPaymentTypesModelToJson(List<PaymentType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class PaymentTypeModel {
  String? message;
  List<PaymentType>? data;

  PaymentTypeModel({this.message, this.data});

  PaymentTypeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <PaymentType>[];
      json['data'].forEach((v) {
        data!.add(new PaymentType.fromJson(v));
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

class PaymentType {
  int? id;
  String? name;

  PaymentType({this.id, this.name});

  PaymentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}