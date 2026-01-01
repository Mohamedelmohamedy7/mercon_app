import 'dart:convert';

List<OwnerUnit> parseOwnerUnits(String src) =>
    List<OwnerUnit>.from(json.decode(src)["data"].map<OwnerUnit>((json) => OwnerUnit.fromJson(json)));
class OwnerUnit {
  final int ownerID;
  final String ownerName;
  final int modelID;
  final String modelName;
  final int buildingID;
  final String buildingName;
  final int unitID;
  final String unitNumber;
  final int levelID;
  final String levelName;
  final int statusID;
  final String statusName;
  final int unitTypeID;
  final String unitType;

  OwnerUnit({
    required this.ownerID,
    required this.ownerName,
    required this.modelID,
    required this.modelName,
    required this.buildingID,
    required this.buildingName,
    required this.unitID,
    required this.unitNumber,
    required this.levelID,
    required this.levelName,
    required this.statusID,
    required this.statusName,
    required this.unitTypeID,
    required this.unitType,
  });

  factory OwnerUnit.fromJson(Map<String, dynamic> json) {
    return OwnerUnit(
      ownerID: json['ownerID'],
      ownerName: json['ownerName'],
      modelID: json['modelID'],
      modelName: json['modelName'],
      buildingID: json['buildingID'],
      buildingName: json['buildingName'],
      unitID: json['unitID'],
      unitNumber: json['unitNumber'],
      levelID: json['levelID'],
      levelName: json['levelName'],
      statusID: json['statusID'],
      statusName: json['statusName'],
      unitTypeID: json['unitTypeID'],
      unitType: json['unitType'],
    );
  }
}
