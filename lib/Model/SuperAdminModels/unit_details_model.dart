import 'dart:developer';

class UnitDetailsModel {
  String? message;
  Data? data;

  UnitDetailsModel({this.message, this.data});

  UnitDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? oldAddress;
  String? oldPhoneNumber;
  String? id;
  String? ownerName;
  String? address;
  String? phoneNumber;
  String? nationalCardNumber;
  bool? isApproved;
  String? imageNationalIdFrontURL;
  String? imageNationalIdBackURL;
  bool? isConfirmed;
  bool? oldIsApproved;
  String? ownerType;
  int? ownerTypeId;
  String? profileImagePath;
  String? ownershipContract;
  String? oldImageNationalIdFrontURL;
  String? oldImageNationalIdBackURL;
  List<UnitDetails>? unitDetails;
  SubOwnerDetails? subOwnerDetails;
  String? oldOwnerName;
  String? createdDate;
  String? modifiedDate;
  String? modifiedByUserName;
  String? denialReason;
  Data({
    this.id,
    this.ownerName,
    this.address,
    this.phoneNumber,
    this.nationalCardNumber,
    this.isApproved,
    this.imageNationalIdFrontURL,
    this.imageNationalIdBackURL,
    this.isConfirmed,
    this.oldIsApproved,
    this.ownerType,
    this.ownerTypeId,
    this.profileImagePath,
    this.ownershipContract,
    this.oldImageNationalIdFrontURL,
    this.oldImageNationalIdBackURL,
    this.unitDetails,
  this.subOwnerDetails,
    this.oldOwnerName,
    this.createdDate,
    this.modifiedDate,
    this.modifiedByUserName,
    this.denialReason,

  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerName = json['ownerName'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    nationalCardNumber = json['nationalCardNumber'];
    isApproved = json['isApproved'];
    imageNationalIdFrontURL = json['imageNationalIdFrontURL'];
    imageNationalIdBackURL = json['imageNationalIdBackURL'];
    isConfirmed = json['isConfirmed'];
    oldIsApproved = json['oldIsApproved'];
    ownerType = json['ownerType'];
    ownerTypeId = json['ownerTypeId'];
    profileImagePath = json['profileImagePath'];
    ownershipContract = json['ownershipContract'];
    oldImageNationalIdFrontURL = json['oldImageNationalIdFrontURL'];
    createdDate = json['createdDate'];
    modifiedDate = json['ModifiedDate'];
    modifiedByUserName = json['ModifiedByUserName'];
    oldImageNationalIdBackURL = json['oldImageNationalIdBackURL'];
    if (json['unitDetails'] != null) {
      unitDetails = <UnitDetails>[];
      json['unitDetails'].forEach((v) {
        unitDetails!.add(new UnitDetails.fromJson(v));
      });
    }
    subOwnerDetails = json['subOwnerDetails'] != null
        ? new SubOwnerDetails.fromJson(json['subOwnerDetails'])
        : null;
    oldOwnerName = json['oldOwnerName'];
    oldAddress = json['oldAddress'];
    oldPhoneNumber = json['oldPhoneNumber'];
    denialReason = json['denialReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ownerName'] = this.ownerName;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['nationalCardNumber'] = this.nationalCardNumber;
    data['isApproved'] = this.isApproved;
    data['imageNationalIdFrontURL'] = this.imageNationalIdFrontURL;
    data['imageNationalIdBackURL'] = this.imageNationalIdBackURL;
    data['isConfirmed'] = this.isConfirmed;
    data['oldIsApproved'] = this.oldIsApproved;
    data['ownerType'] = this.ownerType;
    data['ownerTypeId'] = this.ownerTypeId;
    data['profileImagePath'] = this.profileImagePath;
    data['ownershipContract'] = this.ownershipContract;
    data['oldOwnerName'] = this.oldOwnerName;
    data['oldAddress'] = this.oldAddress;
    data['oldPhoneNumber'] = this.oldPhoneNumber;
    data['oldImageNationalIdFrontURL'] = this.oldImageNationalIdFrontURL;
    data['oldImageNationalIdBackURL'] = this.oldImageNationalIdBackURL;
    if (this.unitDetails != null) {
      data['unitDetails'] = this.unitDetails!.map((v) => v.toJson()).toList();
    }
    if (this.subOwnerDetails != null) {
      data['subOwnerDetails'] = this.subOwnerDetails!.toJson();
    }
    data['denialReason'] = this.denialReason;
    return data;
  }
}

class UnitDetails {
  int? ownerUnitsID;
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
    log("----->>>>${json}");
    ownerUnitsID = json['ownerUnitsID'];
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
class SubOwnerDetails {
  String? id;
  String? ownerName;
  String? address;
  String? phoneNumber;
  String? nationalCardNumber;
  bool? isApproved;
  String? imageNationalIdFrontURL;
  String? imageNationalIdBackURL;
  bool? isConfirmed;
  int? oldId;
  String? oldOwnerName;
  String? oldAddress;
  String? oldPhoneNumber;
  String? oldImageNationalIdFrontURL;
  String? oldImageNationalIdBackURL;
  String? oldNationalCardNumber;
  bool? oldIsApproved;
  String? ownerType;
  int? ownerTypeId;
  String? profileImagePath;


  SubOwnerDetails(
      {this.id,
        this.ownerName,
        this.address,
        this.phoneNumber,
        this.nationalCardNumber,
        this.isApproved,
        this.imageNationalIdFrontURL,
        this.imageNationalIdBackURL,
        this.isConfirmed,
        this.oldId,
        this.oldOwnerName,
        this.oldAddress,
        this.oldPhoneNumber,
        this.oldImageNationalIdFrontURL,
        this.oldImageNationalIdBackURL,
        this.oldNationalCardNumber,
        this.oldIsApproved,
        this.ownerType,
        this.ownerTypeId,
        this.profileImagePath,
       });

  SubOwnerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerName = json['ownerName'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    nationalCardNumber = json['nationalCardNumber'];
    isApproved = json['isApproved'];
    imageNationalIdFrontURL = json['imageNationalIdFrontURL'];
    imageNationalIdBackURL = json['imageNationalIdBackURL'];
    isConfirmed = json['isConfirmed'];
    oldId = json['oldId'];
    oldOwnerName = json['oldOwnerName'];
    oldAddress = json['oldAddress'];
    oldPhoneNumber = json['oldPhoneNumber'];
    oldNationalCardNumber = json['oldNationalCardNumber'];
    oldImageNationalIdFrontURL = json['oldImageNationalIdFrontURL'];
    oldImageNationalIdBackURL = json['oldImageNationalIdBackURL'];
    oldIsApproved = json['oldIsApproved'];
    ownerType = json['ownerType'];
    ownerTypeId = json['ownerTypeId'];
    profileImagePath = json['profileImagePath'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ownerName'] = this.ownerName;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['nationalCardNumber'] = this.nationalCardNumber;
    data['isApproved'] = this.isApproved;
    data['imageNationalIdFrontURL'] = this.imageNationalIdFrontURL;
    data['imageNationalIdBackURL'] = this.imageNationalIdBackURL;
    data['isConfirmed'] = this.isConfirmed;
    data['oldId'] = this.oldId;
    data['oldOwnerName'] = this.oldOwnerName;
    data['oldAddress'] = this.oldAddress;
    data['oldPhoneNumber'] = this.oldPhoneNumber;
    data['oldImageNationalIdFrontURL'] = this.oldImageNationalIdFrontURL;
    data['oldImageNationalIdBackURL'] = this.oldImageNationalIdBackURL;
    data['oldNationalCardNumber'] = this.oldNationalCardNumber;
    data['oldIsApproved'] = this.oldIsApproved;
    data['ownerType'] = this.ownerType;
    data['ownerTypeId'] = this.ownerTypeId;
    data['profileImagePath'] = this.profileImagePath;

    return data;
  }
}