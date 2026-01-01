import 'dart:convert';

List<TransactionType> transactionTypeFromJson(String str) => List<TransactionType>.from(
    json.decode(str)["data"].map((x) => TransactionType.fromJson(x)));
class TransactionTypeModel {


  String? message;
  List<TransactionType>? transactionType;

  TransactionTypeModel({this.message, this.transactionType});

  TransactionTypeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      transactionType = <TransactionType>[];
      json['data'].forEach((v) {
        transactionType!.add(new TransactionType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.transactionType != null) {
      data['data'] = this.transactionType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionType {
  int? id;
  String? name;
  int? compID;

  TransactionType({this.id, this.name, this.compID});

  TransactionType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    compID = json['compID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['compID'] = this.compID;
    return data;
  }
}
