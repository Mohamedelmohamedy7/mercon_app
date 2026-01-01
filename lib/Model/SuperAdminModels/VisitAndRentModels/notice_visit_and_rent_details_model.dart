class NoticeVisitAndRentDetailsModel {
  String? message;
  NoticeVisitAndRentDetails? data;

  NoticeVisitAndRentDetailsModel({this.message, this.data});

  NoticeVisitAndRentDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? new NoticeVisitAndRentDetails.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NoticeVisitAndRentDetails {
  int? id;
  String? name;
  String? nameAr;
  String? nameEn;
  String? nationalId;
  String? phoneNumber;
  String? isCheckoutQrCodeGenerated;
  String? imageNationalIdFrontURL;
  String? imageNationalIdBackURL;
  bool? isRent;
  String? entryDateTime;
  String? ckeckOutDateTime;
  String? faceBookLink;
  String? instagramLink;
  int? statusId;
  bool? isNationalIdScaned;
  int? totalWithVistiorCount;
  bool? isQrCodeScaned;
  String? qrCodeFilePath;
  String? email;
  bool? isCheckout;
  bool? isDenied;
  String? denyReason;
  String? relativeRelation;
  String? createdByNameId;
  String? unitOwnerName;
  String? statusName;
  String? statusColor;
  String? unitModelName;
  String? unitTypeName;
  int? unitID;
  String? buildingName;
  int? userID;
  String? levelName;
  int? compID;
  String? ownerName;
  String? saveReasonOfRefuseAdmin;
  List<String>? imageNationalIdList;
  NoticeVisitAndRentDetails(
      {this.id,
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
      this.saveReasonOfRefuseAdmin,this.imageNationalIdList,});

  NoticeVisitAndRentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    nationalId = json['nationalId'];
    phoneNumber = json['phoneNumber'];
    isCheckoutQrCodeGenerated = json['isCheckoutQrCodeGenerated'];
    imageNationalIdFrontURL = json['imageNationalIdFrontURL'];
    imageNationalIdBackURL = json['imageNationalIdBackURL'];
    isRent = json['isRent'];
    entryDateTime = json['entryDateTime'];
    ckeckOutDateTime = json['ckeckOutDateTime'];
    faceBookLink = json['faceBookLink'];
    instagramLink = json['instagramLink'];
    statusId = json['statusId'];
    isNationalIdScaned = json['isNationalIdScaned'];
    totalWithVistiorCount = json['totalWithVistiorCount'];
    isQrCodeScaned = json['isQrCodeScaned'];
    qrCodeFilePath = json['qrCodeFilePath'];
    email = json['email'];
    isCheckout = json['isCheckout'];
    isDenied = bool.tryParse(json['isDenied'].toString());
    denyReason = json['denyReason'];
    relativeRelation = json['relativeRelation'];
    createdByNameId = json['createdByNameId'];
    unitOwnerName = json['unitOwnerName'];
    statusName = json['statusName'];
    statusColor = json['statusColor'];
    unitModelName = json['unitModelName'];
    unitTypeName = json['unitTypeName'];
    unitID = json['unitID'];
    buildingName = json['buildingName'];
    userID = json['userID'];
    levelName = json['levelName'];
    compID = json['compID'];
    ownerName = json['ownerName'];
    saveReasonOfRefuseAdmin = json['saveReasonOfRefuseAdmin'];
    imageNationalIdList = json['imageNationalIdList'] != null
        ? List<String>.from(json['imageNationalIdList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nameAr'] = this.nameAr;
    data['nameEn'] = this.nameEn;
    data['nationalId'] = this.nationalId;
    data['phoneNumber'] = this.phoneNumber;
    data['isCheckoutQrCodeGenerated'] = this.isCheckoutQrCodeGenerated;
    data['imageNationalIdFrontURL'] = this.imageNationalIdFrontURL;
    data['imageNationalIdBackURL'] = this.imageNationalIdBackURL;
    data['isRent'] = this.isRent;
    data['entryDateTime'] = this.entryDateTime;
    data['ckeckOutDateTime'] = this.ckeckOutDateTime;
    data['faceBookLink'] = this.faceBookLink;
    data['instagramLink'] = this.instagramLink;
    data['statusId'] = this.statusId;
    data['isNationalIdScaned'] = this.isNationalIdScaned;
    data['totalWithVistiorCount'] = this.totalWithVistiorCount;
    data['isQrCodeScaned'] = this.isQrCodeScaned;
    data['qrCodeFilePath'] = this.qrCodeFilePath;
    data['email'] = this.email;
    data['isCheckout'] = this.isCheckout;
    data['isDenied'] = this.isDenied;
    data['denyReason'] = this.denyReason;
    data['relativeRelation'] = this.relativeRelation;
    data['createdByNameId'] = this.createdByNameId;
    data['unitOwnerName'] = this.unitOwnerName;
    data['statusName'] = this.statusName;
    data['statusColor'] = this.statusColor;
    data['unitModelName'] = this.unitModelName;
    data['unitTypeName'] = this.unitTypeName;
    data['unitID'] = this.unitID;
    data['buildingName'] = this.buildingName;
    data['userID'] = this.userID;
    data['levelName'] = this.levelName;
    data['compID'] = this.compID;
    data['ownerName'] = this.ownerName;
    data['saveReasonOfRefuseAdmin'] = this.saveReasonOfRefuseAdmin;
    data['imageNationalIdList'] = this.imageNationalIdList;
    return data;
  }
}
