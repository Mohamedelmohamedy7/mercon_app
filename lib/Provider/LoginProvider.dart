// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:core_project/Model/CompoundModel.dart';
import 'package:core_project/Services/RestApi.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/Utill/Notifications/notification.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/app_constants.dart';
import '../Model/user_info_model.dart';
import 'package:flutter/material.dart';
import '../Services/RequestFile.dart';
import '../Utill/Comman.dart';

class LoginProvider extends ChangeNotifier {
  String countryDial = "+20";
  LoadingStatus status = LoadingStatus.SUCCESS;
  bool showNavBarButton = true;

  bool showNavBar(bool isLogin) {
    showNavBarButton = isLogin;
    notifyListeners();
    return showNavBarButton;
  }

  Future login(context,
      {required String email,
      required String password,
      required String type}) async {
    startLoader();
    final res = await postFunctionRestApi(context,
        url: LOGIN,
        body: json.encode(loginBody(email, password, type)),
        needContent: true);
    S_finishLoader();
    print(res);
    if (json
        .decode(res)["message"]
        .toString()
        .toUpperCase()
        .contains("WRONG")) {
      failedSnack(context, "${json.decode(res)["message"]}");
    } else if (json
        .decode(res)["message"]
        .toString()
        .toLowerCase()
        .contains("not found")) {
      failedSnack(context, "${json.decode(res)["message"]}");
    }

    return UserInfoModel.fromJson(json.decode(res));
  }

  Future<bool> resetPassword(context, {required String email}) async {
    startLoader();
    final res = await postFunctionRestApi(context,
        url: RESET_PASSWORD + "?email=$email",
        body: {
          "email": email,
        },
        needContent: false);
    S_finishLoader();
    print(res);
    if ((json.decode(res)["message"].toString()).contains("have been sent")) {
      successSnak(context, json.decode(res)["message"]);
      return true;
    } else {
      failedSnack(context, json.decode(res)["message"]);
      return false;
    }
  }

  Future<String> logout(context) async {
    startLoader();
    final res = await getFunctionRestApi(context,
        urlEndPoint: LOGOUT + "?firebaseToken=${token}", needContent: true);
    S_finishLoader();
    return res;
  }

  Future<String> deleteAccount(context) async {
    startLoader();
    final res = await DeleteFunctionRestApi(context,
        url: DELETE_ACCOUNT + "?UserId=${globalAccountData.getId()}",
        needContent: false,
        body: {"UserId": globalAccountData.getId()});
    S_finishLoader();
    return res;
  }

  Future<CompoundData?> getCompoundData(
    context,
  ) async {
    try {
      var response = await getFunctionRestApi(
        context,
        urlEndPoint: GET_COMPOUND_DATA,
        navigate: false,
      );
      var data = CompoundData.fromJson(json.decode(response)["data"]);
      saveCompoundData(data);
      notifyListeners();
      return data;
    } catch (e) {}
    return null;
  }

  Future<void> checkUserValidation(
    context,

  ) async {
    try {
     await getFunctionRestApi(
        context,
        urlEndPoint: CheckUserValidationEp,
       showError: false,
      );
    } catch (e) {}
    return null;
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
