import 'dart:convert';

List<DeliveryData> deliveryDataFromJson(String str) => List<DeliveryData>.from(
    json.decode(str)["data"].map((x) => DeliveryData.fromJson(x)));

class DeliveryModel {
  String? message;
  List<DeliveryData>? data;

  DeliveryModel({this.message, this.data});

  DeliveryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <DeliveryData>[];
      json['data'].forEach((v) {
        data!.add(new DeliveryData.fromJson(v));
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

class DeliveryData {
  int? id;
  String? restaurantName;
  String? restaurantNumber;
  int? compID;

  DeliveryData({
    this.id,
    this.restaurantName,
    this.restaurantNumber,
    this.compID,
  });

  DeliveryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantName = json['restaurantName'];
    restaurantNumber = json['restaurantNumber'];
    compID = json['compID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurantName'] = this.restaurantName;
    data['restaurantNumber'] = this.restaurantNumber;
    data['compID'] = this.compID;
    return data;
  }
}
