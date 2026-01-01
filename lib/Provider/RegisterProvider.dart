import 'dart:convert';
import 'dart:io';
import 'package:core_project/Model/CompoundModel.dart';
import 'package:core_project/Model/GetUserModel.dart';
import 'package:core_project/Model/complain_model.dart';
import 'package:core_project/Provider/LoginProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:core_project/waiting_approve.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/user_info_model.dart';
import '../Services/RequestFile.dart';
import '../Services/RestApi.dart';
import '../Utill/Notifications/notification.dart';
import '../View/Screen/DashBoard/DashBoardSCreen.dart';
import '../View/Screen/SecurityScreen.dart';
import '../helper/EnumLoading.dart';
import '../print_object.dart';

class RegisterProvider extends ChangeNotifier {
  LoadingStatus? status = LoadingStatus.SUCCESS;

  Future<void> register(
      {required int? comId,
      required String fullNameEn,
      required String fullNameAr,
      required String email,
      required String? phoneNumber,
      required String password,
      required String? address,
      required String userType,
      required String userLanguage,
      required String userLanguageID,
      required String carPlateNumber,
      required String nationalIdNumber,
      File? profilePic,
      required BuildContext context,
      File? imageFront,
      File? imageBack,
      File? imageContract,
      List<Map<String, dynamic>>? unitsList}) async {
    if (!await isNetworkAvailable()) return;
    startLoader();
    List<String> imageBackList = await uploadImagePostFunction(
        [imageBack], "Common/UploadImage", context);
    List<String> imageFrontList = await uploadImagePostFunction(
        [imageFront], "Common/UploadImage", context);
    List<String> profilePicList = await uploadImagePostFunction(
        [profilePic], "Common/UploadImage", context);
    List<String> imageContractList = await uploadImagePostFunction(
        [imageContract], "Common/UploadImage", context,
        pdf: true);
    var response = await FullDataForRegister(
        comId,
        fullNameEn,
        fullNameAr,
        email,
        phoneNumber,
        password,
        userType,
        userLanguageID,
        context,
        address,
        profilePicList.isEmpty ? null : profilePicList.first,
        imageFrontList.isEmpty ? null : imageFrontList.first,
        imageBackList.isEmpty ? null : imageBackList.first,
        imageContractList.isEmpty ? null : imageContractList.first,
        unitsList: unitsList, carPlateNumber:carPlateNumber, nationalIdNumber: nationalIdNumber);
    print(response);
    if (response.isEmpty) {
      S_finishLoader();
    }
    await successResponse(response, context);
  }

  Future<OwnerData?> getPrimaryAccount(
      context, String phoneNumber, String? email) async {
    startLoader();
    var response = await getFunctionRestApi(context,
        urlEndPoint: GETOWNERBYPHONENUMBER +
            (email ?? phoneNumber.replaceAll("+", "%2B")));
    try {
      if (json.decode(response)["message"] == "Owner not found") {
        status = LoadingStatus.FAILURE;
        notifyListeners();
        failedSnack(context, "عفواً، رقم الحساب غير موجود");
        return null;
      } else {
        var data = OwnerData.fromJson(json.decode(response)["data"]);
        status = LoadingStatus.SUCCESS;
        notifyListeners();
        return data;
      }
    } catch (e) {
      status = LoadingStatus.FAILURE;
    }
  }

  Future<CompoundData?> verifyCode(context, String code) async {
    startLoader();

    try {
      var response = await postFunctionRestApi(
        context,
        url: VERIVYCODE + code,
      );

      if (json.decode(response)["message"] == "Code Not Found") {
        print("hereee ${json.decode(response)["message"]}");
        status = LoadingStatus.FAILURE;
        notifyListeners();
        failedSnack(context, "عفواً، رمز الكمباوند غير موجود");
        return null;
      } else {
        print("hereee");
        var data = CompoundData.fromJson(json.decode(response)["data"]);
        status = LoadingStatus.SUCCESS;
        notifyListeners();
        return data;
      }
    } catch (e) {
      status = LoadingStatus.FAILURE;
    }
    return null;
  }

  Future<void> registerSub({
    required int? comId,
    required String fullNameEn,
    required String fullNameAr,
    required String email,
    required String phoneNumber,
    required String password,
    required String address,
    required String userType,
    required String userLanguage,
    required String primaryOwnerId,
    required String userLanguageID,
    required String carPlateNumber,
    required String nationalIdNumber,
    File? profilePic,
    required BuildContext context,
    File? imageFront,
    File? imageBack,
    File? birthImage,
  }) async {
    if (!await isNetworkAvailable()) return;
    startLoader();
    List<String> imageBackList = imageBack == null
        ? []
        : await uploadImagePostFunction(
            [imageBack], "Common/UploadImage", context);
    List<String> imageFrontList = imageFront == null
        ? []
        : await uploadImagePostFunction(
            [imageFront], "Common/UploadImage", context);
    List<String> birthImageList = birthImage == null
        ? []
        : await uploadImagePostFunction(
            [birthImage], "Common/UploadImage", context);
    List<String> profilePicList = await uploadImagePostFunction(
        [profilePic!], "Common/UploadImage", context);
    var response = await postFunctionRestApi(context,
        url: REGISTERSUB,
        body: jsonEncode({
          "compID": comId,
          "fullNameEn": fullNameEn,
          "fullNameAr": fullNameAr,
          "email": email,
          "phoneNumber": phoneNumber,
          "password": password,
          "UnitOwnerTypeId": "2",
          "profilePic": profilePicList.isEmpty ? null : profilePicList.first,
          "fireBaseToken": token.toString(),
          "userLanguage": userLanguage,
          "userLanguageID": 0.toString(),
          "address": address,
          "userType": "UintOwner",
          "ownerTyprId": "2",
          "ownerType": {
            "id": "2",
            "nameAr": "مالك فرعي",
          },
          "primaryOwnerId": primaryOwnerId,
          "idBackImage": imageBackList.isEmpty ? null : imageBackList.first,
          "idFrontImage": imageFrontList.isEmpty
              ? birthImageList.first
              : imageFrontList.first,

          "CarPlateNumber": carPlateNumber,
          "NationalIdNumber": nationalIdNumber,
        }),
        needContent: true,
        needAccept: false);
    print(response);
    await successResponse(response, context);
  }

  /// PUT DATA INSIDE MAP IN REGISTER FUNCTION
  Future<String> FullDataForRegister(
    int? comId,
    String fullNameEn,
    fullNameAr,
    email,
    phoneNumber,
    password,
    userType,
    userLanguageID,
    context,
    address,
    profilePic,
    imageFront,
    imageBack,
    String? s, {
    List<Map<String, dynamic>>? unitsList,
    required String carPlateNumber,
    required String nationalIdNumber,
  }) async {
    getToken();

    printAllObject(json:{
      "compID": comId,
      "fullNameEn": fullNameEn,
      "fullNameAr": fullNameAr,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "profilePic": profilePic ?? "",
      "userType": userType,
      "fireBaseToken": token.toString(),
      "userLanguage": userLanguageID,
      "userLanguageID": 0.toString(),
      "address": address,
      "ownerTyprId": "1",
      "UnitOwnerTypeId": "1",
      "idBackImage": imageBack ?? "",
      "idFrontImage": imageFront ?? "",
      "OwnershipContract": s,
      "units": unitsList,
      "CarPlateNumber": carPlateNumber,
      "NationalIdNumber": nationalIdNumber,
    });
    final response = await postFunctionRestApi(context,
        url: REGISTER,
        body: jsonEncode({
          "compID": comId,
          "fullNameEn": fullNameEn,
          "fullNameAr": fullNameAr,
          "email": email,
          "phoneNumber": phoneNumber,
          "password": password,
          "profilePic": profilePic ?? "",
          "userType": userType,
          "fireBaseToken": token.toString(),
          "userLanguage": userLanguageID,
          "userLanguageID": 0.toString(),
          "address": address,
          "ownerTyprId": "1",
          "UnitOwnerTypeId": "1",
          "idBackImage": imageBack ?? "",
          "idFrontImage": imageFront ?? "",
          "OwnershipContract": s,
          "units": unitsList,
          "CarPlateNumber": carPlateNumber,
          "NationalIdNumber": nationalIdNumber,
        }),
        needContent: true,
        needAccept: false);
    return response;
  }

  stopLoading() {
    status = LoadingStatus.SUCCESS;
    notifyListeners();
  }

  /// SUCCESS RESPONSE IN REGISTER FUNCTION
  Future<void> successResponse(response, BuildContext context) async {
    try {
      saveUserData(UserInfoModel.fromJson(json.decode(response))).then((value) {
        pushRemoveUntilRoute(
          context: context,
          route: WaitingApprove(),
        );
        Provider.of<LoginProvider>(context, listen: false)
            .getCompoundData(context);
        S_finishLoader();
      });

      toast(json.decode(response)["message"] == "اسم المستخدم موجود"
          ? "البريد الالكترونى مستخدم بالفعل"
          : json.decode(response)["message"]);
      S_finishLoader();
    } catch (e) {
      toast(json.decode(response)["message"] == "اسم المستخدم موجود"
          ? "البريد الالكترونى مستخدم بالفعل"
          : json.decode(response)["message"]);
      S_finishLoader();
    }
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// {

  /// CHANGE FUNCTION PASSWORD
  Future<bool> updatePassword(
      {required String password,
      required String oldPassword,
      required BuildContext context}) async {
    if (!await isNetworkAvailable()) return false;
    status = LoadingStatus.LOADING;
    notifyListeners();
    final response = await postFunctionRestApi(context,
        url: CHANGE_PASSWORD,
        body: json.encode(
            forgetPassword(oldPassword: oldPassword, newPassword: password)),
        needContent: true,
        needAccept: true);
    if (response.isEmpty) {
      status = LoadingStatus.FAILURE;
      notifyListeners();
      failedSnack(context, json.decode(response)["message"]);
      return false;
    } else {
      var data = json.decode(response);
      status = LoadingStatus.SUCCESS;
      notifyListeners();
      return data["data"];
    }
  }

  /// EDIT ACCOUNT DATA

  Future updateAccountData(
      {required String email,
      required String name,
      required String phone,
      File? profilePic,
      required BuildContext context}) async {
    if (!await isNetworkAvailable()) return;
    status = LoadingStatus.LOADING;
    notifyListeners();
    List<String> imageBackList = [];
    if (profilePic != null) {
      imageBackList = await uploadImagePostFunction(
          [profilePic], "Common/UploadImage", context);
    }
    final response = await putFunctionRestApi(context,
        url: EDIT_ACCOUNT,
        body: json.encode({
          "id": "0",
          "nameAr": name,
          "nameEn": name,
          "name": "string",
          "phoneNumber": "string",
          "nationalCardNumber": "string",
          "additionalPhoneNumber": "string",
          "permanentAddress": "string",
          "idImageURL": "string",
          "isActive": true,
          "isApproved": true,
          "isBlocked": true,
          "unitOwnerTypeId": "0",
          "unitOwnerType": {
            "id": "0",
            "nameAr": "string",
            "nameEn": "string",
            "name": "string"
          },
          "userID": "${globalAccountData.getId().toString()}",
          "user": {
            "id": "${globalAccountData.getId().toString()}",
            "userName": "${name}",
            "normalizedUserName": "string",
            "email": "$email",
            "normalizedEmail": "string",
            "emailConfirmed": true,
            "passwordHash": "string",
            "securityStamp": "string",
            "concurrencyStamp": "string",
            "phoneNumber": "${phone}",
            "phoneNumberConfirmed": true,
            "twoFactorEnabled": true,
            "lockoutEnd": "2024-05-07T10:00:24.422Z",
            "lockoutEnabled": true,
            "accessFailedCount": "0",
            "isActive": true,
            "fullNameAr": "string",
            "fullNameEn": "string",
            "profileImagePath":
                "${imageBackList.isEmpty ? "" : imageBackList.first}",
            "imageNationalIdFrontURL": "string",
            "imageNationalIdBackURL": "string",
            "address": "string",
            "isDeleted": true,
            "isConfirmed": true,
            "createdDate": "2024-05-07T10:00:24.422Z",
            "password": "string",
            "roleName": "string",
            "isBlocked": true,
            "isApproved": true
          },
          "type": "string",
        }),
        needContent: true,
        needAccept: true);
    if (response.isEmpty) {
      status = LoadingStatus.FAILURE;
    } else {
      var data = json.decode(response);

      if (name != "") {
        globalAccountData.setUsername(name);
      }
      if (phone != "") {
        globalAccountData.setPhoneNumber(phone);
      }
      if (email != "") {
        globalAccountData.setEmail(email);
      }
      if (imageBackList.isNotEmpty) {
        globalAccountData
            .setProfilePic(imageBackList.isEmpty ? "" : imageBackList.first);
      }
      pushRemoveUntilRoute(
        context: context,
        route: DashBoardScreen(),
      );
      successSnak(context, "${data["message"]}");
    }
    notifyListeners();
  }

  Future updateAccountDataBefourAcceptu(
      {required String email,
      required String name,
      required String phone,
      required String address,
        required File? ownershipContract,
        required String? ownershipContractString,
      File? profilePic,
      required BuildContext context,
      required int? unitId}) async {
    if (!await isNetworkAvailable()) return;
    status = LoadingStatus.LOADING;
    notifyListeners();
    List<String> imageBackList = [];
    List<String> imageContractList=[];
    if (profilePic != null) {
      imageBackList = await uploadImagePostFunction(
          [profilePic], "Common/UploadImage", context);
    }
    if(ownershipContract!=null)
      {

        print("heree");
     imageContractList = await uploadImagePostFunction(
            [ownershipContract], "Common/UploadImage", context,
            pdf: true);
      }

    printAllObject(json: {
      "roleName": "UintOwner",
      "id": "${globalAccountData.getId().toString()}",
      "compID": "${globalAccountData.getCompoundId().toString()}",
      "fullNameEn": name,
      "fullNameAr": name,
      "email": email,
      "phoneNumber": phone,
      "profilePic": "${imageBackList.isEmpty ? "" : imageBackList.first}",
      "userType": "UintOwner",
      "fireBaseToken": token,
      "userLanguage": "1",
      "userLanguageID": "0",
      "address": address,
      "ownerTyprId": "1",
      "UnitOwnerTypeId": unitId != null ? "1" : "2",
      "OwnershipContract": "${imageContractList.isEmpty ? ownershipContractString : imageContractList.first}",
      "units": unitId != null
          ? [
        {"id": unitId}
      ]
          : [],
    });
    final response = await postFunctionRestApi(context,
        url: UpdateUser,
        body: json.encode({
          "roleName": "UintOwner",
          "id": "${globalAccountData.getId().toString()}",
          "compID": "${globalAccountData.getCompoundId().toString()}",
          "fullNameEn": name,
          "fullNameAr": name,
          "email": email,
          "phoneNumber": phone,
          "profilePic": "${imageBackList.isEmpty ? "" : imageBackList.first}",
          "userType": "UintOwner",
          "fireBaseToken": token,
          "userLanguage": "1",
          "userLanguageID": "0",
          "address": address,
          "ownerTyprId": "1",
          "UnitOwnerTypeId": unitId != null ? "1" : "2",
          "OwnershipContract": "${imageContractList.isEmpty ? ownershipContractString : imageContractList.first}",
          "units": unitId != null
              ? [
                  {"id": unitId}
                ]
              : [],
        }),
        needContent: true,
        needAccept: true);
    if (response.isEmpty) {
      status = LoadingStatus.FAILURE;
    } else {
      var data = json.decode(response);

      if (name != "") {
        globalAccountData.setUsername(name);
      }
      if (phone != "") {
        globalAccountData.setPhoneNumber(phone);
      }
      if (email != "") {
        globalAccountData.setEmail(email);
      }
      if (address != "") {
        globalAccountData.setAddress(address);
      }
      if (imageBackList.isNotEmpty) {
        globalAccountData
            .setProfilePic(imageBackList.isEmpty ? "" : imageBackList.first);
      }
      // pushRemoveUntilRoute(
      //   context: context,
      //   route: DashBoardScreen(),
      // );
      popRoute(context: context);
      status = LoadingStatus.SUCCESS;
      successSnak(context, "${data["message"]}");
    }
    notifyListeners();
  }

  Future<GetUserModel?> getUserById(
    context,
  ) async {
    startLoader();
    var response = await getFunctionRestApi(context,
        urlEndPoint: GetUserByID + (globalAccountData.getId() ?? ""));
    try {
      var data = GetUserModel.fromJson(json.decode(response));
      status = LoadingStatus.SUCCESS;
      notifyListeners();
      return data;
    } catch (e) {
      status = LoadingStatus.FAILURE;
    }
  }

  void handleResponse(data, BuildContext context) {
    if (data["data"] == true) {
      status = LoadingStatus.SUCCESS;
      pushRemoveUntilRoute(
        context: context,
        route: SecurityScreen(),
      );
      successSnak(context, "requestSend");
    } else {
      status = LoadingStatus.FAILURE;
      failedSnack(context, data["message"]);
    }
  }

  /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///  /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///  /// /// }

  Future ForgetPassword(
      {required String email, required BuildContext context}) async {
    startLoader();
    final response = await postFunctionRestApi(context,
        url: CHANGE_PASSWORD,
        body: json.encode({"email": email}),
        needContent: true,
        needAccept: true);
    if (response.isEmpty) {
      S_finishLoader();
    } else {
      var data = json.decode(response);
      handleResponse(data, context);
    }
  }

  void startLoader() {
    status = LoadingStatus.LOADING;
    notifyListeners();
  }

  void S_finishLoader() {
    status = LoadingStatus.SUCCESS;
    notifyListeners();
  }

  bool loading = false;
  Future<bool> sendComplaint(context,
      {File? imageFront,
      required String description,
      required String unitName,
      required String email}) async {
    startLoader();

    List<String> imageFrontList = await uploadImagePostFunction(
        [imageFront], "Common/UploadImage", context);
    final complaint = Complaint(
      descriptionComplaint: description,
      email: email,
      UnitName: unitName,
      image: imageFrontList.isEmpty ? null : imageFrontList.first,
    );
    // status = LoadingStatus.SUCCESS;
    // notifyListeners();
    // print("complaint ${complaint.toJson()}");
    // return false;

    // Send the complaint to the backend API
    final response = await postFunctionRestApi(context,
        url: AddComplaint,
        body: json.encode(complaint),
        needContent: true,
        needAccept: true);
    if (response.isEmpty) {
      status = LoadingStatus.FAILURE;
      notifyListeners();
      failedSnack(context, json.decode(response)["message"]);
      return false;
    } else {
      var data = json.decode(response);
      status = LoadingStatus.SUCCESS;
      notifyListeners();
      return data["data"].isEmpty;
    }
  }
}
