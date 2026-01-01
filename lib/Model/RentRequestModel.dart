class RentNotApprovedResponse {
  final String? message;
  final List<RentRequestData>? data;

  RentNotApprovedResponse({
    this.message,
    this.data,
  });

  factory RentNotApprovedResponse.fromJson(Map<String, dynamic> json) {
    return RentNotApprovedResponse(
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((x) => RentRequestData.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data?.map((x) => x.toJson()).toList(),
  };
}

class RentRequestData {
  final int? id;
  final String? name;
  final String? nameAr;
  final String? nameEn;
  final String? nationalId;
  final String? phoneNumber;
  final bool? isCheckoutQrCodeGenerated;
  final String? imageNationalIdFrontURL;
  final String? imageNationalIdBackURL;
  final bool? isRent;
  final String? entryDateTime;
  final String? ckeckOutDateTime;
  final String? faceBookLink;
  final String? instagramLink;
  final int? statusId;
  final bool? isNationalIdScaned;
  final int? totalWithVistiorCount;
  final bool? isQrCodeScaned;
  final String? qrCodeFilePath;
  final String? email;
  final bool? isCheckout;
  final bool? isDenied;
  final String? denyReason;
  final String? relativeRelation;
  final String? createdByNameId;
  final String? unitOwnerName;
  final String? statusName;
  final String? statusColor;
  final String? unitModelName;
  final String? unitTypeName;
  final int? unitID;
  final String? buildingName;
  final String? userID;
  final String? levelName;
  final int? compID;
  final String? ownerName;
  final String? saveReasonOfRefuseAdmin;

  RentRequestData({
    this.id,
    this.name,
    this.nameAr,
    this.nameEn,
    this.nationalId,
    this.phoneNumber,
    this.isCheckoutQrCodeGenerated,
    this.imageNationalIdFrontURL,
    this.imageNationalIdBackURL,
    this.isRent,
    this.entryDateTime,
    this.ckeckOutDateTime,
    this.faceBookLink,
    this.instagramLink,
    this.statusId,
    this.isNationalIdScaned,
    this.totalWithVistiorCount,
    this.isQrCodeScaned,
    this.qrCodeFilePath,
    this.email,
    this.isCheckout,
    this.isDenied,
    this.denyReason,
    this.relativeRelation,
    this.createdByNameId,
    this.unitOwnerName,
    this.statusName,
    this.statusColor,
    this.unitModelName,
    this.unitTypeName,
    this.unitID,
    this.buildingName,
    this.userID,
    this.levelName,
    this.compID,
    this.ownerName,
    this.saveReasonOfRefuseAdmin,
  });

  factory RentRequestData.fromJson(Map<String, dynamic> json) {
    return RentRequestData(
      id: json['id'],
      name: json['name'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      nationalId: json['nationalId'],
      phoneNumber: json['phoneNumber'],
      isCheckoutQrCodeGenerated: json['isCheckoutQrCodeGenerated'],
      imageNationalIdFrontURL: json['imageNationalIdFrontURL'],
      imageNationalIdBackURL: json['imageNationalIdBackURL'],
      isRent: json['isRent'],
      entryDateTime: json['entryDateTime'],
      ckeckOutDateTime: json['ckeckOutDateTime'],
      faceBookLink: json['faceBookLink'],
      instagramLink: json['instagramLink'],
      statusId: json['statusId'],
      isNationalIdScaned: json['isNationalIdScaned'],
      totalWithVistiorCount: json['totalWithVistiorCount'],
      isQrCodeScaned: json['isQrCodeScaned'],
      qrCodeFilePath: json['qrCodeFilePath'],
      email: json['email'],
      isCheckout: json['isCheckout'],
      isDenied: json['isDenied'],
      denyReason: json['denyReason'],
      relativeRelation: json['relativeRelation'],
      createdByNameId: json['createdByNameId'],
      unitOwnerName: json['unitOwnerName'],
      statusName: json['statusName'],
      statusColor: json['statusColor'],
      unitModelName: json['unitModelName'],
      unitTypeName: json['unitTypeName'],
      unitID: json['unitID'],
      buildingName: json['buildingName'],
      userID: json['userID'],
      levelName: json['levelName'],
      compID: json['compID'],
      ownerName: json['ownerName'],
      saveReasonOfRefuseAdmin: json['saveReasonOfRefuseAdmin'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nameAr': nameAr,
    'nameEn': nameEn,
    'nationalId': nationalId,
    'phoneNumber': phoneNumber,
    'isCheckoutQrCodeGenerated': isCheckoutQrCodeGenerated,
    'imageNationalIdFrontURL': imageNationalIdFrontURL,
    'imageNationalIdBackURL': imageNationalIdBackURL,
    'isRent': isRent,
    'entryDateTime': entryDateTime,
    'ckeckOutDateTime': ckeckOutDateTime,
    'faceBookLink': faceBookLink,
    'instagramLink': instagramLink,
    'statusId': statusId,
    'isNationalIdScaned': isNationalIdScaned,
    'totalWithVistiorCount': totalWithVistiorCount,
    'isQrCodeScaned': isQrCodeScaned,
    'qrCodeFilePath': qrCodeFilePath,
    'email': email,
    'isCheckout': isCheckout,
    'isDenied': isDenied,
    'denyReason': denyReason,
    'relativeRelation': relativeRelation,
    'createdByNameId': createdByNameId,
    'unitOwnerName': unitOwnerName,
    'statusName': statusName,
    'statusColor': statusColor,
    'unitModelName': unitModelName,
    'unitTypeName': unitTypeName,
    'unitID': unitID,
    'buildingName': buildingName,
    'userID': userID,
    'levelName': levelName,
    'compID': compID,
    'ownerName': ownerName,
    'saveReasonOfRefuseAdmin': saveReasonOfRefuseAdmin,
  };
}
