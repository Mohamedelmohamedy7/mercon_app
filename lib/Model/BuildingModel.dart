import 'dart:convert';


List<BuildingModel> parseBuildingModel(String src) => List<BuildingModel>.from(json.decode(src)["data"].map<BuildingModel>((json) => BuildingModel.fromJson(json)));

class BuildingModel {
    int id;
    String BuildingModelName;
    int unitModelsId;

  BuildingModel({
    required this.id,
    required this.BuildingModelName,
    required this.unitModelsId,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      id: json['id'],
      BuildingModelName: json['buildingName'],
      unitModelsId: json['unitModelsId'],
    );
  }
    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
            other is BuildingModel && runtimeType == other.runtimeType && id == other.id;

    @override
    int get hashCode => id.hashCode;
}
