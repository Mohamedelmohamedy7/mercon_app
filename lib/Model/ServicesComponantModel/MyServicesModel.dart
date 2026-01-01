import 'dart:convert';

List<ServiceRequest> ServiceRequestFromJson(String str) =>
    List<ServiceRequest>.from(
      json.decode(str)["data"].map((x) => ServiceRequest.fromJson(x)),
    );

class ServiceRequest {
  int id;
  String details;
  int? serviceTypeId;
  bool isOther;
  String ownerName;
  String IsProccessing;
  String IsFinshed;
  int unitNumber;
  int unitModelId;
  String? userId;
  String? dateFrom;
  String? dateTo;
  bool? isApprove;
  ServiceType? serviceType;
  String? createdDate;
  String? statusID;
  String? rate;
  String? complaint;
  int? rateId;

  ServiceRequest({
    required this.id,
    required this.details,
    required this.serviceTypeId,
    required this.isOther,
    required this.ownerName,
    required this.unitNumber,
    required this.IsFinshed,
    required this.IsProccessing,
    required this.unitModelId,
    required this.userId,
    required this.serviceType,
    required this.statusID,
    required this.createdDate,
    this.rate,
    this.rateId,
    this.dateFrom,
    this.dateTo,
    this.isApprove,
    this.complaint
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      id: json['id'],
      details: json['details'],
      serviceTypeId: json['serviceTypeId'],
      IsProccessing: json['isProccessing'].toString(),
      IsFinshed: json['isFinshed'].toString(),
      isOther: json['isOther'],
      ownerName: json['ownerName'],
      unitNumber: json['unitID'] ?? 0,
      unitModelId: json['unitModelId'],
      userId: json['userId'],
      statusID: json['statusID'].toString(),
      complaint: json['complaint'].toString(),
      serviceType: json['serviceType'] != null
          ? ServiceType.fromJson(json['serviceType'])
          : null,
      createdDate: json['createdDate'],
      rate: json['rate'],
      rateId: json['rateId'],
      dateFrom: json['dateFrom'],
      isApprove: json['isApprove'],
      dateTo: json['dateTo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'details': details,
      'serviceTypeId': serviceTypeId,
      'isOther': isOther,
      'ownerName': ownerName,
      'isProccessing': IsProccessing,
      'isFinshed': IsFinshed,
      'unitID': unitNumber,
      'unitModelId': unitModelId,
      'userId': userId,
      'statusID': statusID,
      'serviceType': serviceType?.toJson(),
      'createdDate': createdDate,
      'rate': rate,
      'rateId': rateId,
      'complaint': complaint,
    };
  }
}

class ServiceType {
  int id;
  String nameAr;
  String nameEn;
  String name;
  String? iconURLPath;

  ServiceType({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.name,
    this.iconURLPath,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) {
    return ServiceType(
      id: json['id'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      name: json['name'],
      iconURLPath: json['iconURLPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'name': name,
      'iconURLPath': iconURLPath,
    };
  }
}

class ServiceRequestList {
  String message;
  List<ServiceRequest> data;

  ServiceRequestList({
    required this.message,
    required this.data,
  });

  factory ServiceRequestList.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ServiceRequest> dataList =
    list.map((i) => ServiceRequest.fromJson(i)).toList();

    return ServiceRequestList(
      message: json['message'],
      data: dataList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
