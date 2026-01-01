import 'dart:convert';
List<ALLModelModel> parseModelUnitData(String src) => List<ALLModelModel>.from(json.decode(src)["data"].map<ALLModelModel>((json)
=> ALLModelModel.fromJson(json)));

class ALLModelModel {
    String name;
    String modelName;
    int id;


  ALLModelModel({
    required this.name,
    required this.modelName,
    required this.id,
  });

  factory ALLModelModel.fromJson(Map<String, dynamic> json) {
    return ALLModelModel(
      name: json['modelName']??"",
      modelName: json['modelName']??"",
      id: json['id']??0,
    );
  }
    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
            other is ALLModelModel && runtimeType == other.runtimeType && id == other.id;

    @override
    int get hashCode => id.hashCode;
}
