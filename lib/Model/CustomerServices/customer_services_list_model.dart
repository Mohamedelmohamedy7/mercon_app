import 'dart:convert';

List<CustomerServiceModel> customerServiceFromJson(String str) =>json.decode(str)["data"].isEmpty?[]:
    List<CustomerServiceModel>.from(
        json.decode(str)["data"].map((x) => CustomerServiceModel.fromJson(x)));

String customerServiceToJson(List<CustomerServiceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerServicesListModel {
  String? message;
  List<CustomerServiceModel>? data;

  CustomerServicesListModel({this.message, this.data});

  CustomerServicesListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <CustomerServiceModel>[];
      json['data'].forEach((v) {
        data!.add(new CustomerServiceModel.fromJson(v));
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

class CustomerServiceModel {
  int? id;
  String? details;
  int? serviceTypeId;
  int? subServiceId;
  double? price;
  double? emergancyServicePrice;
  bool? isOther;
  String? ownerName;
  String? unitName;
  int? unitID;
  int? unitModelId;
  String? userId;
  String? createdDate;
  String? modifiedDate;
  String? phoneNumber;
  String? uintModelName;
  int? statusID;
  String? serviceTypeName;
  String? dateFrom;
  String? dateTo;
  String? modifiedByUserName;
  String? createdByUserName;
  bool? isApprove;
  ServiceType? serviceType;
  UnitDetails? unitDetails;
  SubServiceDTO? subServiceDTO;
  CustomerServiceModel({
    this.id,
    this.details,
    this.serviceTypeId,
    this.subServiceId,
    this.price,
    this.isApprove,
    this.dateFrom,
    this.dateTo,
    this.emergancyServicePrice,
    this.isOther,
    this.ownerName,
    this.unitName,
    this.unitID,
    this.unitModelId,
    this.userId,
    this.createdDate,
    this.modifiedDate,
    this.phoneNumber,
    this.uintModelName,
    this.statusID,
    this.serviceTypeName,
    this.serviceType,
    this.modifiedByUserName,
    this.createdByUserName
  });

  CustomerServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    serviceTypeId = json['serviceTypeId'];
    subServiceId = json['subServiceId'];
    isApprove = json['isApprove'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    price = double.tryParse(json['price'].toString());
    emergancyServicePrice =
        double.tryParse(json['emergancyServicePrice'].toString());
    isOther = json['isOther'];
    ownerName = json['ownerName'];
    unitName = json['unitName'];
    unitID = json['unitID'];
    unitModelId = json['unitModelId'];
    userId = json['userId'];
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
    phoneNumber = json['phoneNumber'];
    uintModelName = json['uintModelName'];
    statusID = json['statusID'];
    serviceTypeName = json['serviceTypeName'];
    serviceType = json['serviceType'] != null
        ? new ServiceType.fromJson(json['serviceType'])
        : null;
    unitDetails = json['unitDetails'] != null
        ? new UnitDetails.fromJson(json['unitDetails'])
        : null;
    subServiceDTO = json['subServiceDTO'] != null
        ? new SubServiceDTO.fromJson(json['subServiceDTO'])
        : null;
    modifiedByUserName= json['modifiedByUserName'];
    createdByUserName= json['createdByUserName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['details'] = this.details;
    data['serviceTypeId'] = this.serviceTypeId;
    data['subServiceId'] = this.subServiceId;
    data['price'] = this.price;
    data['emergancyServicePrice'] = this.emergancyServicePrice;
    data['isOther'] = this.isOther;
    data['ownerName'] = this.ownerName;
    data['unitName'] = this.unitName;
    data['unitID'] = this.unitID;
    data['unitModelId'] = this.unitModelId;
    data['userId'] = this.userId;
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    data['phoneNumber'] = this.phoneNumber;
    data['uintModelName'] = this.uintModelName;
    data['statusID'] = this.statusID;
    data['serviceTypeName'] = this.serviceTypeName;
    if (this.serviceType != null) {
      data['serviceType'] = this.serviceType!.toJson();
    }
    if (this.unitDetails != null) {
      data['unitDetails'] = this.unitDetails!.toJson();
    }
    if (this.subServiceDTO != null) {
      data['subServiceDTO'] = this.subServiceDTO!.toJson();
    }
    return data;
  }
}

class ServiceType {
  int? id;
  String? nameAr;
  String? nameEn;
  String? name;
  String? iconURLPath;
  double? servicePrice;
  double? emergencyServicePrice;

  ServiceType(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.name,
      this.iconURLPath,
      this.servicePrice,
      this.emergencyServicePrice});

  ServiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    name = json['name'];
    iconURLPath = json['iconURLPath'];
    servicePrice = double.tryParse(json['servicePrice'].toString());
    emergencyServicePrice =
        double.tryParse(json['emergencyServicePrice'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameAr'] = this.nameAr;
    data['nameEn'] = this.nameEn;
    data['name'] = this.name;
    data['iconURLPath'] = this.iconURLPath;
    data['servicePrice'] = this.servicePrice;
    data['emergencyServicePrice'] = this.emergencyServicePrice;
    return data;
  }
}

class UnitDetails {
  int? ownerUnitsID;
  int? ownerUnitOldID;
  int? ownerID;
  String? ownerName;
  int? modelID;
  String? modelName;
  int? buildingID;
  String? buildingName;
  int? unitID;
  String? unitNumber;
  int? levelID;
  String? levelName;
  int? statusID;
  String? statusName;
  int? unitTypeID;
  String? unitType;
  bool? isApproved;

  UnitDetails(
      {this.ownerUnitsID,
      this.ownerUnitOldID,
      this.ownerID,
      this.ownerName,
      this.modelID,
      this.modelName,
      this.buildingID,
      this.buildingName,
      this.unitID,
      this.unitNumber,
      this.levelID,
      this.levelName,
      this.statusID,
      this.statusName,
      this.unitTypeID,
      this.unitType,
      this.isApproved});

  UnitDetails.fromJson(Map<String, dynamic> json) {
    ownerUnitsID = json['ownerUnitsID'];
    ownerUnitOldID = json['ownerUnitOldID'];
    ownerID = json['ownerID'];
    ownerName = json['ownerName'];
    modelID = json['modelID'];
    modelName = json['modelName'];
    buildingID = json['buildingID'];
    buildingName = json['buildingName'];
    unitID = json['unitID'];
    unitNumber = json['unitNumber'];
    levelID = json['levelID'];
    levelName = json['levelName'];
    statusID = json['statusID'];
    statusName = json['statusName'];
    unitTypeID = json['unitTypeID'];
    unitType = json['unitType'];
    isApproved = json['isApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ownerUnitsID'] = this.ownerUnitsID;
    data['ownerUnitOldID'] = this.ownerUnitOldID;
    data['ownerID'] = this.ownerID;
    data['ownerName'] = this.ownerName;
    data['modelID'] = this.modelID;
    data['modelName'] = this.modelName;
    data['buildingID'] = this.buildingID;
    data['buildingName'] = this.buildingName;
    data['unitID'] = this.unitID;
    data['unitNumber'] = this.unitNumber;
    data['levelID'] = this.levelID;
    data['levelName'] = this.levelName;
    data['statusID'] = this.statusID;
    data['statusName'] = this.statusName;
    data['unitTypeID'] = this.unitTypeID;
    data['unitType'] = this.unitType;
    data['isApproved'] = this.isApproved;
    return data;
  }
}

class SubServiceDTO {
  int? id;
  double? price;
  String? subServicesName;
  int? compID;
  num? emergencyServicePrice;
  double? totalPrice;
  double? servicePriceAfterTax;
  double? emergencyServicePriceAfterTax;

  SubServiceDTO(
      {this.id,
      this.price,
      this.subServicesName,
      this.compID,
      this.emergencyServicePrice,
      this.totalPrice,
      this.servicePriceAfterTax,
      this.emergencyServicePriceAfterTax});

  SubServiceDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price =double.tryParse(json['price'].toString()) ;
    subServicesName = json['subServicesName'];
    compID = json['compID'];
    emergencyServicePrice = json['emergencyServicePrice'];
    totalPrice =double.tryParse(json['totalPrice'].toString()) ;
    servicePriceAfterTax = double.tryParse(json['servicePriceAfterTax'].toString());
    emergencyServicePriceAfterTax =  double.tryParse(json['emergencyServicePriceAfterTax'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['subServicesName'] = this.subServicesName;
    data['compID'] = this.compID;
    data['emergencyServicePrice'] = this.emergencyServicePrice;
    data['totalPrice'] = this.totalPrice;
    data['servicePriceAfterTax'] = this.servicePriceAfterTax;
    data['emergencyServicePriceAfterTax'] = this.emergencyServicePriceAfterTax;
    return data;
  }
}
