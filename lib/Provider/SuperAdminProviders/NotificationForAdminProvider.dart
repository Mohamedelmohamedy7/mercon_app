import 'dart:convert';

import 'package:core_project/Model/ALLModelModel.dart';
import 'package:core_project/Model/SuperAdminModels/NotificationModelForAdmin/notification_model_for_admin.dart';
import 'package:core_project/Model/SuperAdminModels/OwnerManagementModels/user_model.dart';
import 'package:core_project/Services/RestApi.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';
import '../../helper/EnumLoading.dart';

class NotificationForAdminProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;
  List<NotificationModel> notificationList = [];

  bool first = true;
  bool notify = true;
  Future<void> getNotificationList(context) async {
    notificationList.clear();
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetAllNotificationForAdmin,
      //  body: json.encode({"pageNumber": 0, "pageSize": 0})
    );
    for (NotificationModel notification
        in notificationModelForAdminFromJson(res)) {
      notificationList.add(notification);
      first = false;
    }

    S_finishLoader();
    return;
  }

  Future<Map<bool,String?>> sendNotification(
    context, {
    required int? modelId,
    required int? toUserId,
    required String title,
    required String body,
    required bool onlyCompound
  }) async {
    startLoader();
    final res = await postFunctionRestApi(
      context,
      url: SendNotification +
          "?modelId=$modelId&TouserId=$toUserId&Titel=$title&body=$body&sendToAllOwners=$onlyCompound",
      //  body: json.encode({"pageNumber": 0, "pageSize": 0})
    );
    getNotificationList(context);
    S_finishLoader();
    if ((json.decode(res)["message"].toString()).isNotEmpty) {
    //  successSnak(context, json.decode(res)["message"], translateTest: false);
      return {true:json.decode(res)["message"],};
    } else {
     // failedSnack(context, json.decode(res)["data"], translateTest: false);
      return {false:json.decode(res)["data"],};
    }
  }

  /// GET ALL MODELS
  List<ALLModelModel> aLLModelModelList = [];
  Future<List<ALLModelModel>> getAllModel(
    context,
  ) async {
    aLLModelModelList.clear();
    // startLoader();
    final res = await getFunctionRestApi(context, urlEndPoint: GET_ALL_MODELS);
    for (ALLModelModel unitModel in parseModelUnitData(res)) {
      if (!aLLModelModelList.any((model) => model.id == unitModel.id)) {
        aLLModelModelList.add(unitModel);
      }
    }
    S_finishLoader();
    return aLLModelModelList;
  }

  List<User> ownerUserUnits = [];
  Future<List<User>> getOwnerUserUnits(context) async {
    ownerUserUnits.clear();
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetAllUintOwners,
      //  body: json.encode({"pageNumber": 0, "pageSize": 0})
    );
    for (User user in userUnitModelFromJson(res)) {
      ownerUserUnits.add(user);
    }

    S_finishLoader();
    return ownerUserUnits;
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

void handleFunctionError(dynamic e, var function) {
  talker.error('');
  talker.error('Error in function ${function}: $e');
  talker.error('');
}

Future<void> catchError(Future<void> function, String functionName) async {
  try {
    await function;
  } catch (e) {
    handleFunctionError(e, functionName);
  }
}
