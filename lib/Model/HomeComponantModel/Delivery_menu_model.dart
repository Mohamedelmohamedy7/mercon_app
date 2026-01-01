import 'dart:convert';

List<DeliveryMenus> deliveryMenuDataFromJson(String str) =>
    List<DeliveryMenus>.from(json
        .decode(str)["data"]["deliveryMenus"]
        .map((x) => DeliveryMenus.fromJson(x)));

class DeliveryMenuModel {
  String? message;
  Data? data;

  DeliveryMenuModel({this.message, this.data});

  DeliveryMenuModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? restaurantName;
  String? restaurantNumber;
  int? compID;
  List<DeliveryMenus>? deliveryMenus;

  Data(
      {this.id,
      this.restaurantName,
      this.restaurantNumber,
      this.compID,
      this.deliveryMenus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantName = json['restaurantName'];
    restaurantNumber = json['restaurantNumber'];
    compID = json['compID'];
    if (json['deliveryMenus'] != null) {
      deliveryMenus = <DeliveryMenus>[];
      json['deliveryMenus'].forEach((v) {
        deliveryMenus!.add(new DeliveryMenus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurantName'] = this.restaurantName;
    data['restaurantNumber'] = this.restaurantNumber;
    data['compID'] = this.compID;
    if (this.deliveryMenus != null) {
      data['deliveryMenus'] =
          this.deliveryMenus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveryMenus {
  int? id;
  String? menuIamge;
  int? compID;
  int? deliveryID;

  DeliveryMenus({this.id, this.menuIamge, this.compID, this.deliveryID});

  DeliveryMenus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuIamge = json['menuIamge'];
    compID = json['compID'];
    deliveryID = json['deliveryID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menuIamge'] = this.menuIamge;
    data['compID'] = this.compID;
    data['deliveryID'] = this.deliveryID;
    return data;
  }
}
