class UnitUserFull {
  String? model;
  String? build;
  String? level;
  String? unit;

  UnitUserFull(
      {required this.model,
      required this.build,
      required this.level,
      required this.unit});

  factory UnitUserFull.fromJson(Map<String, dynamic> json) {
    return UnitUserFull(
        model: json["model"],
        build: json["build"],
        level: json["level"],
        unit: json["unit"]);
  }
}
