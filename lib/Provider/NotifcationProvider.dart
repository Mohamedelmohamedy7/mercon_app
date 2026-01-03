import 'package:core_project/Model/NotificationModel.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:flutter/material.dart';

import '../Services/RestApi.dart';
import '../helper/EnumLoading.dart';
import '../helper/app_constants.dart';

class NotificationProvider extends ChangeNotifier{
  LoadingStatus status = LoadingStatus.SUCCESS;
  List<NotificationModel> myNotification = [];
  Future<void> getMyNotifcation(context) async {
    myNotification.clear();
     startLoader();
    final res = await getFunctionRestApi(context, urlEndPoint: "$GET_ALL_NOTIFICATION${globalAccountData.getId().toString()}");
    for (NotificationModel unitModelItem in parseNotificationModel(res)) {
      unitModelItem.url = "assets/images/newsIcon.png";
      myNotification.add(unitModelItem);
    }
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