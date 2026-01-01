import 'dart:convert';
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

class HomeProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;
  List<MobileSlider> mobileSliders = [];
  List<UnitModel> unitModel = [];
  List<NewsModel> newsList = [];
  RegulationResponse ? regulationResponse;

  Future<void> loadData (context) async {
    catchError(getSlidersFunction(context), 'getSlidersFunction');
    catchError(getAllNewsFunction(context), 'getAllNewsFunction');
    catchError(getRegulations(context), 'getRegulations');
    catchError(p_Listeneress<ConfigProvider>(context).getHotlineNumber(context), 'loadConfigData');
    catchError(p_Listeneress<UnitsProvider>(context).getMyUnitNumber(context), 'getMyUnitNumber');
  }

  Future<void> getSlidersFunction(context) async {
    mobileSliders.clear();
    startLoader();
    await globalAccountData.init();
    final res = await getFunctionRestApi(context, urlEndPoint: MOBILESLIDERS);
    for (MobileSlider mobileSlider in mobileSliderFromJson(res)) {
      mobileSliders.add(mobileSlider);
    }
    S_finishLoader();
    return;
  }
  Future<void> getRegulations(context) async {
    startLoader();
    final res = await getFunctionRestApi(context, urlEndPoint: ADDREGULATIONS);
    regulationResponse = RegulationResponse.fromJson(json.decode(res));
    S_finishLoader();
    return;
  }

  Future<void> getAllNewsFunction(context) async {
    newsList.clear();
    startLoader();
    final res = await getFunctionRestApi(context, urlEndPoint: GET_ALL_NEWS);
    for (NewsModel unitModelItem in MyNewsFromJson(res)) {
      newsList.add(unitModelItem);
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


void handleFunctionError(dynamic e , var function) {
  talker.error('');
  talker.error('Error in function ${function}: $e');
  talker.error('');
}

Future<void> catchError(Future<void> function,String functionName) async {
  try {
    await function;
  } catch (e) {
    handleFunctionError(e, functionName);
  }
}