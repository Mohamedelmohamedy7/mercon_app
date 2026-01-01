import 'dart:convert';

List<Unitmodel> unitModelFromJson(String str) => List<Unitmodel>.from(
    json.decode(str)["data"].map((x) => Unitmodel.fromJson(x)));

String unitModelToJson(List<Unitmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUnitsForDashboardModel {
  String? message;
  List<Unitmodel>? data;

  GetUnitsForDashboardModel({this.message, this.data});

  GetUnitsForDashboardModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Unitmodel>[];
      json['data'].forEach((v) {
        data!.add(new Unitmodel.fromJson(v));
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

class Unitmodel {
  int? unitModelId;
  String? modelName;
  int? totalUnitsCount;
  int? busyUnitsCount;
  int? emptyUnitsCount;
  List<int>? series;
  double? busyUnitsPercentage;
  double? emptyUnitsPercentage;

  Unitmodel(
      {this.unitModelId,
      this.modelName,
      this.totalUnitsCount,
      this.busyUnitsCount,
      this.emptyUnitsCount,
      this.series,
      this.busyUnitsPercentage,
      this.emptyUnitsPercentage});

  Unitmodel.fromJson(Map<String, dynamic> json) {
    unitModelId = json['unitModelId'];
    modelName = json['modelName'];
    totalUnitsCount = json['totalUnitsCount'];
    busyUnitsCount = json['busyUnitsCount'];
    emptyUnitsCount = json['emptyUnitsCount'];
    series = json['series'].cast<int>();
    busyUnitsPercentage = double.tryParse(json['busyUnitsPercentage'].toString());
    emptyUnitsPercentage =double.tryParse(json['emptyUnitsPercentage'].toString());;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unitModelId'] = this.unitModelId;
    data['modelName'] = this.modelName;
    data['totalUnitsCount'] = this.totalUnitsCount;
    data['busyUnitsCount'] = this.busyUnitsCount;
    data['emptyUnitsCount'] = this.emptyUnitsCount;
    data['series'] = this.series;
    data['busyUnitsPercentage'] = this.busyUnitsPercentage;
    data['emptyUnitsPercentage'] = this.emptyUnitsPercentage;
    return data;
  }
}
