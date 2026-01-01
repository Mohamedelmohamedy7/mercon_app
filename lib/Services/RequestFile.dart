import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/Utill/Notifications/notification.dart';

/// Login Request Body
Map<String, String> loginBody(String email, String password, String type) {
  return {
    "userName": email.toString(),
    "password": password.toString(),
    "PhoneNumber": "",
    "fireBaseToken": token.toString(),
    "userType": "",
  };
}

/// Register Request Body
// Map<String, String> registerBody(String fullNameEn, String fullNameAr, String userLanguageID, String email, String phoneNumber,
//     String password, String userType, String address,  {required profilePic, required imageFront, required imageBack, List<Map<String,dynamic>> ? unitsList}) {
//   return {
//     "fullNameEn": fullNameEn,
//     "fullNameAr": fullNameAr,
//     "email": email,
//     "phoneNumber": phoneNumber,
//     "password": password,
//     "profilePic": profilePic ?? "",
//     "userType": userType,
//     "userLanguage": userLanguageID,
//     "userLanguageID": 0.toString(),
//     "address": address,
//     "idBackImage": imageBack ??"",
//     "idFrontImage": imageFront ??"",
//     "units": unitsList
//   };
// }

/// ForgetPassword
Map<String, String> forgetPassword({required String oldPassword, required String newPassword}) {
  return {
    "new_password": newPassword,
    "old_password": oldPassword,
  };
}
/// Edit Account Data
Map<String, String> editAccount({required String name, required String phone, required String email}) {
  return {
    "fullNameEn": name,
    "fullNameAr": name,
    "email": email,
    "phoneNumber": phone,
  };
}

/// Refresh Token Body
Map<String, String> refreshBody(String token) {
  return {
    "refreshToken": (globalAccountData.GetRefreshToken() == null
        ? ""
        : globalAccountData.GetRefreshToken())!,
    "firebaseToken": (token),
    "UserLanguage": "0",
  };
}

/// send Service Request Body
Map<String, dynamic> sendServiceRequestBody({required String details, required String? serviceTypeId,
  required bool isOther, required String ownerName, required String unitNumber, required String unitModelId,List<String>? subServiceIds}) {
  return {
    "details": details,
    "serviceTypeId": serviceTypeId,
    "isOther": isOther,
    "ownerName": ownerName,
    "unitID": unitNumber,
    "unitModelId": unitModelId,
    "subServiceIds":subServiceIds,
    "userId":
        (globalAccountData.getId() == null ? "" : globalAccountData.getId())!,
  };
}

/// send Visitor Request Body
Map<String, dynamic> sendVisitorRequestBody({
  required String name,
  required String nationalId,
  required String imageNationalIdFrontURL,
  required String imageNationalIdBackURL,
  required String email,
  required bool isRent,
  required bool isVisitor,
  required DateTime checkOutDateTime,
  required DateTime entryDateTime,
  required String totalWithVistiorCount,
  required String relationship,
  required String unitId,
  required String phoneNumber, String? facebookLink, String? instagramLink,
}) {
  return {
    "id": 0,
    "name": name,
    "nameAr": name,
    "nameEn": name,
    "email": email,
    "unitID": unitId,
    "RelativeRelation": relationship,
    "isNationalIdScaned": true,
    "statusId": 0,
    "nationalId": nationalId,
    "imageNationalIdFrontURL": imageNationalIdFrontURL,
    "imageNationalIdBackURL": imageNationalIdBackURL,
    "isRent":isRent==true?true: isVisitor==true?false:true,
    "entryDateTime": entryDateTime.toIso8601String(),
    "ckeckOutDateTime": checkOutDateTime.toIso8601String(),
    "totalWithVistiorCount": totalWithVistiorCount,
    "phoneNumber": phoneNumber,
    "isCheckout": false,
    "UserID": globalAccountData.getId(),
    "isApproved": false,
    "isCancel": false,
    "qrCodeFilePath": "",
    "faceBookLink": facebookLink??"",
    "instagramLink": instagramLink??"",
    "isQrCodeScaned": false,
  };
}

/// send Service Request Body
Map<String, dynamic> sendGetGuestAccessRequestBody() {
  return {
    "name": "",
    "nationalId": "",
    "phoneNumber": "",
    "isRent": false,
    "pageNumber": 0,
    "pageSize": 0
  };
}

/// Send Add New Request
Map<String, dynamic> addNewRequest({String?  unitId}){
  return {
    "unitId": unitId
  };
}