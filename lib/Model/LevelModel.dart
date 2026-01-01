import 'dart:convert';

List<LevelModel> parseLevelModels(String responseBody) {
  final parsed = jsonDecode(responseBody)['data'].cast<Map<String, dynamic>>();
  return parsed.map<LevelModel>((json) => LevelModel.fromJson(json)).toList();
}

class LevelModel {
    int id;
    String levelsName;
    int buildingID;

  LevelModel({
    required this.id,
    required this.levelsName,
    required this.buildingID,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['id'],
      levelsName: json['levelName']??"",
      buildingID: json['buildingID'],
    );
  }
    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
            other is LevelModel && runtimeType == other.runtimeType && id == other.id;

    @override
    int get hashCode => id.hashCode;
}