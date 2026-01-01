import 'dart:convert';

List<UnitModel> MyUnitFromJson(String str) => List<UnitModel>.from(json.decode(str)["data"].map((x) => UnitModel.fromJson(x)));

class UnitModel {
  final int id;
  final int unitNumber;
  final String nameAr;
  final String nameEn;
  final String name;
  final String? unitDescraptionAr;
  final String? unitDescraptionEn;
  final String? unitDescraption;
  final int constructionUnitStatusId;
  final String? constructionUnitStatus;
  final int unitDeliveryStatusId;
  final String? unitDeliveryStatus;
  final int unitFinancialPositionStatusId;
  final String? unitFinancialPositionStatus;
  final int unitTypeId;
  final String? unitType;
  final int unitModelId;
  final String? unitModel;
  final String userId;
  final String? unitOwner;
  final dynamic user;

  UnitModel({
    required this.id,
    required this.unitNumber,
    required this.nameAr,
    required this.nameEn,
    required this.name,
    this.unitDescraptionAr,
    this.unitDescraptionEn,
    this.unitDescraption,
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
    required this.userId,
    this.unitOwner,
    this.user,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'],
      unitNumber: json['unitNumber'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      name: json['name'],
      unitDescraptionAr: json['unitDescraptionAr'],
      unitDescraptionEn: json['unitDescraptionEn'],
      unitDescraption: json['unitDescraption'],
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
      userId: json['userId'],
      unitOwner: json['unitOwner'],
      user: json['user'],
    );
  }
}
