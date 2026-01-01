import 'dart:convert';

import 'package:core_project/Model/WhatsModel.dart';
import 'package:core_project/Model/user_info_model.dart';
import 'package:flutter/material.dart';
import '../Model/HotlineModel.dart';
import '../Services/RequestFile.dart';
import '../Services/RestApi.dart';
import '../Utill/Comman.dart';
import '../Utill/Local_User_Data.dart';
import '../Utill/Notifications/notification.dart';
import '../View/Screen/PartAuth/LoginScreen.dart';
import '../helper/EnumLoading.dart';
import '../helper/app_constants.dart';
///**
///  http://31.220.84.50:888/#/pages/login
/// http://31.220.84.50:777/docs/index.html
///
///
///
///
class ConfigProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;
  String hotlineNumber = "";

  Future<String?> refreshMyAccessibility(context) async {
    String token = await getToken();
    await globalAccountData.init();
    print("${globalAccountData.GetRefreshToken()}____________________________00");
    try {
      final res = await postFunctionRestApi(context,
          url: REFRESH_TOKEN, body: json.encode({
            "refreshToken": (globalAccountData.GetRefreshToken() == null
                ? ""
                : globalAccountData.GetRefreshToken())!,
            "firebaseToken": (token),
            "UserLanguage": "0",
          }));

      if (res.isNotEmpty && json.decode(res)["statusCode"] != "User Not Found") {
        globalAccountData.SetAccessToken(
            UserInfoModel.fromJson(json.decode(res)).accessToken!);
        globalAccountData.SetRefreshToken(
            UserInfoModel.fromJson(json.decode(res)).refreshToken!);
        globalAccountData.SetExpiredTime(
            UserInfoModel.fromJson(json.decode(res)).expiresIn ?? "");
      }

      S_finishLoader();
      if (res.isNotEmpty &&
          json.decode(res)["statusCode"] != "User Not Found" &&
          UserInfoModel.fromJson(json.decode(res)).isBlocked == true) {
        return "isBlocked";
      } else if (res.isNotEmpty &&
          json.decode(res)["statusCode"] != "User Not Found" &&
          (UserInfoModel.fromJson(json.decode(res)).isApprove == false ||
              UserInfoModel.fromJson(json.decode(res)).isApprove == null)) {
        return "isApprove";
      } else {
        return '';
      }
    } catch (e) {
      print("***********************///////***********" + e.toString());
      pushRemoveUntilRoute(
        context: context,
        route: LoginScreen(),
      );
      return '';
    }
  }

  List<HotlineData> hotline = [];

  Future<void> getHotlineNumber(context) async {
    hotline.clear();
    startLoader();
    final res = await getFunctionRestApi(context, urlEndPoint: HOTLINE_NUMBER);
    for (HotlineData unitModelItem in parseHotlineData(res)) {
      hotline.add(unitModelItem);
    }
    S_finishLoader();
    return;
  }

  WhatsData? whatsData;
  Future<void> getWhatsAppNumber(context) async {
    whatsData = null;
    startLoader();
    final res = await getFunctionRestApi(context, urlEndPoint: WHATS_NUMBER);
    whatsData = WhatsData.fromJson(json.decode(res)["data"]);
    print("whatsData ${whatsData?.toJson()}");
    S_finishLoader();
    return;
  }

  void S_finishLoader() {
    status = LoadingStatus.SUCCESS;
    notifyListeners();
  }

  void startLoader() {
    status = LoadingStatus.LOADING;
    notifyListeners();
  }
}
