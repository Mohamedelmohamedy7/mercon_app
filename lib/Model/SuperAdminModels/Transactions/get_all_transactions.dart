import 'dart:convert';

List<Transaction> transactionFromJson(String str) => List<Transaction>.from(
    json.decode(str)["data"].map((x) => Transaction.fromJson(x)));

class TransactionTypeModel {
  String? message;
  List<Transaction>? transaction;

  TransactionTypeModel({this.message, this.transaction});

  TransactionTypeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      transaction = <Transaction>[];
      json['data'].forEach((v) {
        transaction!.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.transaction != null) {
      data['data'] = this.transaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  int? id;
  String? title;
  String? description;
  String? attachmentUrl;
  int? transactionTypeID;
  String? createdDate;
  Transaction(
      {this.id,
      this.description,
      this.attachmentUrl,
      this.transactionTypeID,
      this.title,this.createdDate});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    attachmentUrl = json['attachmentUrl'];
    transactionTypeID = json['transactionTypeID'];
    title = json['title'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['attachmentUrl'] = this.attachmentUrl;
    data['transactionTypeID'] = this.transactionTypeID;
    data['title'] = this.title;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
