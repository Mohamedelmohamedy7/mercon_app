import 'dart:convert';

List<PaymentLog> paymentLogsModelFromJson(String str) => List<PaymentLog>.from(
    json.decode(str)["data"].map((x) => PaymentLog.fromJson(x)));

String paymentLogsModelToJson(List<PaymentLog> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentLogsModel {
  String? message;
  List<PaymentLog>? data;

  PaymentLogsModel({this.message, this.data});

  PaymentLogsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <PaymentLog>[];
      json['data'].forEach((v) {
        data!.add(new PaymentLog.fromJson(v));
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

class PaymentLog {
  String? paymentType;
  double? amount;
  String? recivedType;
  int? compID;
  int? id;
  String? createdDate;

  PaymentLog({
    this.paymentType,
    this.amount,
    this.recivedType,
    this.compID,
    this.id,
    this.createdDate,
  });

  PaymentLog.fromJson(Map<String, dynamic> json) {
    paymentType = json['paymentType'];
    amount = double.tryParse(json['amount'].toString());
    recivedType = json['recivedType'];
    compID = json['compID'];
    id = json['id'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentType'] = this.paymentType;
    data['amount'] = this.amount;
    data['recivedType'] = this.recivedType;
    data['compID'] = this.compID;
    data['id'] = this.id;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
