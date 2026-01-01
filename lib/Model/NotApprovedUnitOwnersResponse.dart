class NotApprovedUnitOwnersResponse {
  final String message;
  final List<UnitOwner> data;

  NotApprovedUnitOwnersResponse({
    required this.message,
    required this.data,
  });

  factory NotApprovedUnitOwnersResponse.fromJson(Map<String, dynamic> json) {
    return NotApprovedUnitOwnersResponse(
      message: json['message'],
      data: List<UnitOwner>.from(
        json['data'].map((x) => UnitOwner.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UnitOwner {
  final int id;
  final String? profileImage;
  final String? nameAr;
  final String? nameEn;
  final String? name;
  final String phoneNumber;
  final String? nationalCardNumber;
  final String additionalPhoneNumber;
  final String permanentAddress;
  final String? idImageURL;
  final bool isActive;
  final bool isApproved;
  final bool isBlocked;
  final dynamic unitOwnerUser;
  final int unitOwnerTypeId;
  final dynamic unitOwnerType;
  final String userID;
  final dynamic user;
  final dynamic type;
  final dynamic statusID;
  final dynamic unitID;

  UnitOwner({
    required this.id,
    this.profileImage,
    this.nameAr,
    this.nameEn,
    this.name,
    required this.phoneNumber,
    this.nationalCardNumber,
    required this.additionalPhoneNumber,
    required this.permanentAddress,
    this.idImageURL,
    required this.isActive,
    required this.isApproved,
    required this.isBlocked,
    this.unitOwnerUser,
    required this.unitOwnerTypeId,
    this.unitOwnerType,
    required this.userID,
    this.user,
    this.type,
    this.statusID,
    this.unitID,
  });

  factory UnitOwner.fromJson(Map<String, dynamic> json) {
    return UnitOwner(
      id: json['id'],
      profileImage: json['profileImage'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      nationalCardNumber: json['nationalCardNumber'],
      additionalPhoneNumber: json['additionalPhoneNumber'],
      permanentAddress: json['permanentAddress'],
      idImageURL: json['idImageURL'],
      isActive: json['isActive'],
      isApproved: json['isApproved'] ?? false,
      isBlocked: json['isBlocked']??false,
      unitOwnerUser: json['unitOwnerUser'],
      unitOwnerTypeId: json['unitOwnerTypeId'],
      unitOwnerType: json['unitOwnerType'],
      userID: json['userID'],
      user: json['user'],
      type: json['type'],
      statusID: json['statusID'],
      unitID: json['unitID'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'profileImage': profileImage,
    'nameAr': nameAr,
    'nameEn': nameEn,
    'name': name,
    'phoneNumber': phoneNumber,
    'nationalCardNumber': nationalCardNumber,
    'additionalPhoneNumber': additionalPhoneNumber,
    'permanentAddress': permanentAddress,
    'idImageURL': idImageURL,
    'isActive': isActive,
    'isApproved': isApproved,
    'isBlocked': isBlocked,
    'unitOwnerUser': unitOwnerUser,
    'unitOwnerTypeId': unitOwnerTypeId,
    'unitOwnerType': unitOwnerType,
    'userID': userID,
    'user': user,
    'type': type,
    'statusID': statusID,
    'unitID': unitID,
  };
}
