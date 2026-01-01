import 'dart:convert';
import 'package:core_project/Model/HomeComponantModel/DeliveryModel.dart';
import 'package:core_project/Model/HomeComponantModel/Delivery_menu_model.dart';
import 'package:core_project/Model/HomeComponantModel/NewsModel.dart';
import 'package:core_project/Provider/UnitsProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:flutter/material.dart';
import '../Model/HomeComponantModel/SlidersModel.dart';
import '../Model/HomeComponantModel/UnitsModel.dart';
import '../Model/internalRegolutions.dart';
import '../Services/RestApi.dart';
import '../helper/EnumLoading.dart';
import '../helper/app_constants.dart';
import 'ConfigProvider.dart';

class DeliveryProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;
  List<DeliveryData> deliveryData = [];

  Future<void> getDeliveryDataFunction(context) async {
    deliveryData.clear();
    startLoader();
    await globalAccountData.init();
    final res =
        await getFunctionRestApi(context, urlEndPoint: Get_All_Delivery);
    for (DeliveryData delivery in deliveryDataFromJson(res)) {
      deliveryData.add(delivery);
    }
    S_finishLoader();
    return;
  }

  List<DeliveryMenus> deliveryMenuData = [];

  Future<void> getDeliveryMenusDataFunction(context, {required int? id}) async {
    deliveryMenuData.clear();
    startLoader();
    await globalAccountData.init();
    final res = await getFunctionRestApi(context,
        urlEndPoint: Get_Delivery_Menu_By_Id + id.toString());
    for (DeliveryMenus delivery in deliveryMenuDataFromJson(res)) {
      deliveryMenuData.add(delivery);
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
