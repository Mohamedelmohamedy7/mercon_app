import 'dart:convert';
List<UnitModel> parseUnitModel(String src) => List<UnitModel>.from(json.decode(src)["data"].map<UnitModel>((json) =>
    json == null ? UnitModel.fromJson({
      'id': 0,
      'unitNumber': '',
      'constructionUnitStatusId': 0,
      'constructionUnitStatus': null,
      'unitDeliveryStatusId': 0,
      'unitDeliveryStatus': null,
      'unitFinancialPositionStatusId': 0,
      'unitFinancialPositionStatus': null,
      'unitTypeId': 0,
      'unitType': null,
      'unitModelId': 0,
      'unitModel': null,
      'buildingID': 0,
      'unitBuilding': null,
      'levelID': 0,
      'unitLevel': null,
      'unitDetails': null,
    }) :
    UnitModel.fromJson(json))).toList();

 
class UnitModel {
  int id;
  String unitNumber;
  int constructionUnitStatusId;
  String? constructionUnitStatus;
  int unitDeliveryStatusId;
  String? unitDeliveryStatus;
  int unitFinancialPositionStatusId;
  String? unitFinancialPositionStatus;
  int unitTypeId;
  String? unitType;
  int unitModelId;
  String? unitModel;
  int buildingID;
  String? unitBuilding;
  int levelID;
  String? unitLevel;
  dynamic unitDetails;

  UnitModel({
    required this.id,
    required this.unitNumber,
    required this.constructionUnitStatusId,
    this.constructionUnitStatus,
    required this.unitDeliveryStatusId,
    this.unitDeliveryStatus,
    required this.unitFinancialPositionStatusId,
    this.unitFinancialPositionStatus,
    required this.unitTypeId,
    this.unitType,
    required this.unitModelId,
    this.unitModel,
    required this.buildingID,
    this.unitBuilding,
    required this.levelID,
    this.unitLevel,
    this.unitDetails,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'],
      unitNumber: json['unitNumber'],
      constructionUnitStatusId: json['constructionUnitStatusId'],
      constructionUnitStatus: json['constructionUnitStatus'],
      unitDeliveryStatusId: json['unitDeliveryStatusId'],
      unitDeliveryStatus: json['unitDeliveryStatus'],
      unitFinancialPositionStatusId: json['unitFinancialPositionStatusId'],
      unitFinancialPositionStatus: json['unitFinancialPositionStatus'],
      unitTypeId: json['unitTypeId'],
      unitType: json['unitType'],
      unitModelId: json['unitModelId'],
      unitModel: json['unitModel'],
      buildingID: json['buildingID'],
      unitBuilding: json['unitBuilding'],
      levelID: json['levelID'],
      unitLevel: json['unitLevel'],
      unitDetails: json['unitDetails'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unitNumber'] = this.unitNumber;
    data['constructionUnitStatusId'] = this.constructionUnitStatusId;
    data['constructionUnitStatus'] = this.constructionUnitStatus;
    data['unitDeliveryStatusId'] = this.unitDeliveryStatusId;
    data['unitDeliveryStatus'] = this.unitDeliveryStatus;
    data['unitFinancialPositionStatusId'] = this.unitFinancialPositionStatusId;
    data['unitFinancialPositionStatus'] = this.unitFinancialPositionStatus;
    data['unitTypeId'] = this.unitTypeId;
    data['unitType'] = this.unitType;
    data['unitModelId'] = this.unitModelId;
    data['unitModel'] = this.unitModel;
    data['buildingID'] = this.buildingID;
    data['unitBuilding'] = this.unitBuilding;
    data['levelID'] = this.levelID;
    data['unitLevel'] = this.unitLevel;
    data['unitDetails'] = this.unitDetails;
    return data;
  }
}
