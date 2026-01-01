import 'dart:convert';

List<ComplaintModel> complaintFromJson(String str) => List<ComplaintModel>.from(
    json.decode(str)["data"].map((x) => ComplaintModel.fromJson(x)));

String complaintToJson(List<ComplaintModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComplaintListModel {
  String? message;
  List<ComplaintModel>? data;

  ComplaintListModel({this.message, this.data});

  ComplaintListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ComplaintModel>[];
      json['data'].forEach((v) {
        data!.add(new ComplaintModel.fromJson(v));
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

class ComplaintModel {
  int? id;
  String? descriptionComplaint;
  String? imageUrl;
  String? name;
  String? createdDate;
  bool? isEmployee;
  String ? unitName;
  String ? replyText;
  ComplaintModel(
      {this.id,
      this.descriptionComplaint,
      this.imageUrl,
      this.name,
      this.unitName,
      this.createdDate,
      this.isEmployee,this.replyText});

  ComplaintModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descriptionComplaint = json['descriptionComplaint'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    createdDate = json['createdDate'];
    isEmployee = json['isEmployee'];
    unitName = json['unitName'];
    replyText = json['replyText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descriptionComplaint'] = this.descriptionComplaint;
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['createdDate'] = this.createdDate;
    data['isEmployee'] = this.isEmployee;
    data['replyText'] = this.replyText;
    return data;
  }
}
