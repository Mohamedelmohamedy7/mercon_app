
class RegulationResponse {
  final int id;
  final String internalRegulation;
  final bool isDeleted;
  final DateTime createdDate;
  final DateTime ? modifiedDate;
  final String createdByName;
  final String modifiedByName;

  RegulationResponse({
    required this.id,
    required this.internalRegulation,
    required this.isDeleted,
    required this.createdDate,
    required this.modifiedDate,
    required this.createdByName,
    required this.modifiedByName,
  });

  factory RegulationResponse.fromJson(Map<String, dynamic> json) {
    return RegulationResponse(
      id: json['data']['id'],
      internalRegulation: json['data']['internalRegulations'],
      isDeleted: json['data']['isDeleted']??false,
      createdDate: DateTime.tryParse(json['data']['createdDate']??"")??DateTime.now(),
      modifiedDate: json['data']['modifiedDate'] != null
          ? DateTime.tryParse(json['data']['modifiedDate']): null,
      createdByName: json['data']['createdByName']??"",
      modifiedByName: json['data']['modifiedByName']??"",
    );
  }

}
