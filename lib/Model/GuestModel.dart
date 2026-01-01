import 'dart:convert';

List<GuestModel> parseGuestModel(String src) => json.decode(src)["data"] == "" ? [] : List<GuestModel>.from(json.decode(src)["data"].map<GuestModel>((json) => GuestModel.fromJson(json)));


class GuestModel {
  final int id;
  final String name;
  final String nameAr;
  final String nameEn;
  final String nationalId;
  final String phoneNumber;
  final String? imageNationalIdFrontURL;
  final String? imageNationalIdBackURL;
  final bool isRent;
  final bool isVisit;
  final DateTime entryDateTime;
  final DateTime checkOutDateTime;
  final int statusId;
  final bool isNationalIdScanned;
  final int totalWithVisitorCount;
  final bool isQrCodeScanned;
  final String qrCodeFilePath;
  final bool isApproved;
  final bool isCancel;
  final String email;

  GuestModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.nameEn,
    required this.nationalId,
    required this.phoneNumber,
    required this.imageNationalIdFrontURL,
    required this.imageNationalIdBackURL,
    required this.isRent,
    required this.isVisit,
    required this.entryDateTime,
    required this.checkOutDateTime,
    required this.statusId,
    required this.isNationalIdScanned,
    required this.totalWithVisitorCount,
    required this.isQrCodeScanned,
    required this.qrCodeFilePath,
    required this.isApproved,
    required this.isCancel,
    required this.email,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json) {
    return GuestModel(
      id: json['id'],
      name: json['name'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      nationalId: json['nationalId'],
      phoneNumber: json['phoneNumber'],
      imageNationalIdFrontURL: json['imageNationalIdFrontURL'],
      imageNationalIdBackURL: json['imageNationalIdBackURL'],
      isRent: json['isRent'],
      isVisit: json['isVisit']??false,
      entryDateTime: DateTime.parse(json['entryDateTime']),
      checkOutDateTime: DateTime.parse(json['ckeckOutDateTime']),
      statusId: json['statusId'],
      isNationalIdScanned: json['isNationalIdScaned'],
      totalWithVisitorCount: json['totalWithVistiorCount'],
      isQrCodeScanned: json['isQrCodeScaned'],
      qrCodeFilePath: json['qrCodeFilePath']??"",
      isApproved: json['isApproved']??false,
      isCancel: json['isCancel']??false,
      email: json['email']??"",
    );
  }
}
