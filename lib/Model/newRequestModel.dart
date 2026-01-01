class RequestResponse {
  final String message;
  final List<RequestData> data;

  RequestResponse({
    required this.message,
    required this.data,
  });

  factory RequestResponse.fromJson(Map<String, dynamic> json) {
    return RequestResponse(
      message: json['message'],
      data: List<RequestData>.from(json['data'].map((x) => RequestData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RequestData {
  final String details;
  final int serviceTypeId;
  final bool isOther;
  final String ownerName;
  final int unitID;
  final int subServiceId;
  final num price;
  final int unitModelId;
  final String userId;
  final int statusID;
  final int compID;
  final dynamic compounds;
  final dynamic rateId;
  final dynamic rate;
  final String? dateFrom;
  final String? dateTo;
  final bool? isApprove;
  final String? complaint;
  final int id;
  final bool? isDeleted;
  final String createdDate;
  final String modifiedDate;
  final String createdByNameId;
  final String modifiedByNameId;
  final String? createdByName;
  final String? modifiedByName;

  RequestData({
    required this.details,
    required this.serviceTypeId,
    required this.isOther,
    required this.ownerName,
    required this.unitID,
    required this.subServiceId,
    required this.price,
    required this.unitModelId,
    required this.userId,
    required this.statusID,
    required this.compID,
    this.compounds,
    this.rateId,
    this.rate,
    this.dateFrom,
    this.dateTo,
    this.isApprove,
    this.complaint,
    required this.id,
    this.isDeleted,
    required this.createdDate,
    required this.modifiedDate,
    required this.createdByNameId,
    required this.modifiedByNameId,
    this.createdByName,
    this.modifiedByName,
  });

  factory RequestData.fromJson(Map<String, dynamic> json) {
    return RequestData(
      details: json['details'],
      serviceTypeId: json['serviceTypeId'],
      isOther: json['isOther'],
      ownerName: json['ownerName'],
      unitID: json['unitID'],
      subServiceId: json['subServiceId'],
      price: json['price'],
      unitModelId: json['unitModelId'],
      userId: json['userId'],
      statusID: json['statusID'],
      compID: json['compID'],
      compounds: json['compounds'],
      rateId: json['rateId'],
      rate: json['rate'],
      dateFrom: json['dateFrom'],
      dateTo: json['dateTo'],
      isApprove: json['isApprove'],
      complaint: json['complaint'],
      id: json['id'],
      isDeleted: json['isDeleted'],
      createdDate: json['createdDate'],
      modifiedDate: json['modifiedDate'],
      createdByNameId: json['createdByNameId'],
      modifiedByNameId: json['modifiedByNameId'],
      createdByName: json['createdByName'],
      modifiedByName: json['modifiedByName']["userName"],
    );
  }

  Map<String, dynamic> toJson() => {
    'details': details,
    'serviceTypeId': serviceTypeId,
    'isOther': isOther,
    'ownerName': ownerName,
    'unitID': unitID,
    'subServiceId': subServiceId,
    'price': price,
    'unitModelId': unitModelId,
    'userId': userId,
    'statusID': statusID,
    'compID': compID,
    'compounds': compounds,
    'rateId': rateId,
    'rate': rate,
    'dateFrom': dateFrom,
    'dateTo': dateTo,
    'isApprove': isApprove,
    'complaint': complaint,
    'id': id,
    'isDeleted': isDeleted,
    'createdDate': createdDate,
    'modifiedDate': modifiedDate,
    'createdByNameId': createdByNameId,
    'modifiedByNameId': modifiedByNameId,
    'createdByName': createdByName,
    'modifiedByName': modifiedByName,
  };
}
