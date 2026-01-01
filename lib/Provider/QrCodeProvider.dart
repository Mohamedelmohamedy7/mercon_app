import 'dart:convert';

import 'package:core_project/Services/RestApi.dart';
import 'package:flutter/material.dart';
import '../Utill/Local_User_Data.dart';
import '../helper/EnumLoading.dart';
import '../helper/app_constants.dart';
import 'package:nb_utils/nb_utils.dart' as nb_utils;
class QrcodeProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;
  String qrCodePath = "";

  Future<void> generateQrCodeToken(BuildContext context) async {
    final res = await postFunctionRestApi(context, url: Genrate_Entrance_QrCode + "?userId=${globalAccountData.getId()}", body: {}, needContent: false);
    qrCodePath = json.decode(res)["data"];
    S_finishLoader();
  }



  Future<void> generateQrCodeForEmployee(BuildContext context) async {
    startLoader();
    final res = await postFunctionRestApi(context, url: GenerateQrCodeForEmployeeEp + "?userId=${globalAccountData.getId()}", body: {}, needContent: false);
    qrCodePath = json.decode(res)["data"];
    S_finishLoader();
  }
  Future<bool> getScanAvalibleForEmployee(context, String data) async {
    startLoader();
    final res = await postFunctionRestApi(context, url: "$GET_QRCODE_STATUS_For_Employee${data.toString()}",showError:true );

    print("ressss ${res}");
    Map<String, dynamic> jsonData = jsonDecode(res);
    String message = jsonData['message'];
    print(message);
    nb_utils.toast(message, gravity: nb_utils.ToastGravity.BOTTOM);
    S_finishLoader();
    return decodeIsActive(res) ?? false;
  }


  Future<bool> getScanAvalible(context, String userId) async {
    startLoader();
    final res = await postFunctionRestApi(context, url: "$GET_QRCODE_STATUS${userId.toString()}");

    print("ressss ${res}");
    Map<String, dynamic> jsonData = jsonDecode(res);
    String message = jsonData['message'];
    print(message);
    nb_utils.toast(message, gravity: nb_utils.ToastGravity.BOTTOM);
    S_finishLoader();
    return decodeIsActive(res) ?? false;
  }

  Future<bool> getScanAvalibleForCheckout(context, String qrCode) async {
    startLoader();
    final res = await postFunctionRestApi(context,
        url: "$GET_QRCODE_STATUS_FOR_CHECKOUT" + "?noticQrCode=${qrCode.toString()}",
        body: {"noticQrCode": qrCode.toString()},
        needContent: false);
    S_finishLoader();
    if (json.decode(res)["message"] == "تم استخدام QRCode من قبل") {
      return false;
    } else {
      return json.decode(res)["data"]["isCheckout"] ?? false;
    }
  }

  ///---------------------------------------------
  Future<bool> getScanAvalibleForCheckIn(context, String qrCode) async {
    startLoader();

    print("ffffff ${qrCode.toString()}");
    final res = await postFunctionRestApi(context,
        url: "$GET_QRCODE_STATUS_FOR_CHECKIN" +
            "?noticQrCode=${qrCode.toString()}",
        body: {
          "noticQrCode": qrCode.toString(),
        },
        needContent: false);
    S_finishLoader();
    return decodeIsActive(res) ?? false;
  }

  Future<bool> setScanCheckOut(context, String userId, bool isFlag) async {
    startLoader();
    final res = await putFunctionRestApi(context,
        url: "$SELECT_CHECKOUT_USER_STATUS?OnwerUserId=${userId.toString()}&flag=${isFlag.toString()}",
        body: {
          "OnwerUserId":userId.toString(),
          "flag":isFlag.toString(),
        },
        needContent: false);
    S_finishLoader();
    return  json.decode(res)["data"] ?? false;
  }

  Future<bool> sendStatusQrcodeForCheckIn(
      context, String qrCode, String reason, bool isDeny) async {
    startLoader();
    var x = jsonEncode({
      "QRCodeFilePath": qrCode.toString(),
      "denyReason": reason,
      "isDenied": isDeny,
    });
    final res = await postFunctionRestApi(
      context,
      url: "$SEND_Status_QRCODE_FOR_CHECKIN",
      body: x,
    );
    S_finishLoader();
    return decodeIsActive(res) ?? false;
  }

  ///---------------------------------------------

  void S_finishLoader() {
    status = LoadingStatus.SUCCESS;
    notifyListeners();
  }

  void startLoader() {
    status = LoadingStatus.LOADING;
    notifyListeners();
  }

  decodeIsActive(String res) {
    return json.decode(res)["message"] == "error in QR code"
        ? false
        : json.decode(res)["data"]["isActive"];

  }
}
