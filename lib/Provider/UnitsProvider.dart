import 'dart:convert';

import 'package:core_project/Model/GuestModel.dart';
import 'package:core_project/Model/UnitModel.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:flutter/material.dart';

import '../Model/ALLModelModel.dart';
import '../Model/BuildingModel.dart';
import '../Model/LevelModel.dart';
import '../Model/UnitModelService.dart';
import '../Model/UnitPayments.dart';
import '../Model/UnitPymantModel.dart';
import '../Services/RequestFile.dart';
import '../Services/RestApi.dart';
import '../helper/EnumLoading.dart';
import '../helper/app_constants.dart';

class UnitsProvider extends ChangeNotifier {
  List<GuestModel> guestsList = [];
  List<ALLModelModel> aLLModelModelList = [];
  List<OwnerUnit> modelUnitServiceList = [];
  List<OwnerUnit> modelUnitServiceListAndContainPending = [];
  LoadingStatus status = LoadingStatus.LOADING;

  List<UnitPayments> ownersPayment = [];

  Future<void> getAllUnitsPayment(context) async {
    ownersPayment.clear();
    startLoader();
    final res = await getFunctionRestApi(context,
        urlEndPoint:
            GET_ALL_OWNER_PAYMENT + globalAccountData.getId().toString());
    for (UnitPayments unit in unitPaymentsList(res)) {
      ownersPayment.add(unit);
    }
    print("${ownersPayment.length}************");
    S_finishLoader();
    return;
  }

  Future<void> getAllGuest(context) async {
    guestsList.clear();
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint:
          GET_ALL_GUEST_ACCESS + "?UserId=${globalAccountData.getId()}",
    );
    print(res);
    for (GuestModel unit in parseGuestModel(res)) {
      guestsList.add(unit);
    }
    S_finishLoader();
    return;
  }

  /// GET ALL MODELS
  Future<List<ALLModelModel>> getAllModel(context,
      {int? comId, bool? isLogin}) async {
    aLLModelModelList.clear();
    buildingList.clear();
    levelList.clear();
    unitList.clear();
    // startLoader();
    final res = await getFunctionRestApi(context,
        urlEndPoint: isLogin == true
            ? GET_ALL_MODELS_FOR_USER + "?UserId=${globalAccountData.getId()}"
            : comId != null
                ? GET_ALL_MODELS_FOR_MOBILE + "?CompID=$comId"
                : GET_ALL_MODELS);
    for (ALLModelModel unitModel in parseModelUnitData(res)) {
      if (!aLLModelModelList.any((model) => model.id == unitModel.id)) {
        aLLModelModelList.add(unitModel);
      }
    }
    S_finishLoader();
    return aLLModelModelList;
  }

  /// GET ALL BUILDING BY ID
  List<BuildingModel> buildingList = [];

  Future<List<BuildingModel>> getAllBuilding(context, String id,
      {bool? isLogin}) async {
    buildingList.clear();
    levelList.clear();
    final res = await getFunctionRestApi(context,
        urlEndPoint: isLogin == true
            ? GET_BUILDING_BY_ID_FOR_USER +
                "?UserId=${globalAccountData.getId()}&ModelID=${id.toString()}"
            : GET_BUILDING_BY_ID + id.toString());
    for (BuildingModel buildModel in parseBuildingModel(res)) {
      if (!buildingList.any((model) => model.id == buildModel.id)) {
        buildingList.add(buildModel);
      }
    }
    S_finishLoader();
    return buildingList;
  }

  ///  GET ALL LEVELS BY ID
  List<LevelModel> levelList = [];

  Future<List<LevelModel>> getAllLevel(context, String id,
      {bool? isLogin}) async {
    levelList.clear();
    unitList.clear();
    startLoader();
    final res = await getFunctionRestApi(context,
        urlEndPoint: isLogin == true
            ? GET_ALL_LEVELS_BY_ID_FOR_USER +
                "?UserId=${globalAccountData.getId()}&buildingID=${id.toString()}"
            : GET_ALL_LEVELS_BY_ID + id.toString());
    for (LevelModel levelModel in parseLevelModels(res)) {
      if (!levelList.any((model) => model.id == levelModel.id)) {
        levelList.add(levelModel);
      }
    }
    S_finishLoader();
    return levelList;
  }

  ///  GET ALL UNITS BY ID
  List<UnitModel> unitList = [];

  Future<List<UnitModel>> getUnitModel(context, String id,
      {bool? isLogin, bool addNewUnit = false}) async {
    unitList.clear();
    startLoader();
    final res = await getFunctionRestApi(context,
        urlEndPoint: isLogin != false
            ? GET_ALL_UNITS_BY_ID +
                globalAccountData.getId()! +
                "&LevelID=" +
                id.toString()
            : addNewUnit
                ? GET_UNIT_DATA_BY_LEVELS_FOR_ADD_NEW_UNIT +
                    "?Id=" +
                    id.toString() +
                    "&" +
                    "UserID=${globalAccountData.getId()}"
                : GET_UNIT_DATA_BY_LEVELS + "?Id=" + id.toString());
    for (UnitModel unitModel in parseUnitModel(res)) {
      if (!unitList.any((model) => model.id == unitModel.id)) {
        unitList.add(unitModel);
      }
    }
    S_finishLoader();
    return unitList;
  }

  Future<void> getMyUnitNumber(
    context,
  ) async {
    modelUnitServiceList.clear();
    modelUnitServiceListAndContainPending.clear();
    startLoader();
    final res = await getFunctionRestApi(context,
        urlEndPoint:
            GET_MY_UNITS_NUMBERS + globalAccountData.getId().toString());
    for (OwnerUnit unitModel in parseOwnerUnits(res)) {
      if (unitModel.statusID.toString() == "1" ||
          unitModel.statusID.toString() == "5") {
        modelUnitServiceListAndContainPending.add(unitModel);
      } else {
        modelUnitServiceList.add(unitModel);
        modelUnitServiceListAndContainPending.add(unitModel);
      }
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

  Future<String> addUnitModel(
    BuildContext context, {
    required userID,
    required String unitID,
    required String ownerID,
  }) async {
    startLoader();
    final res = await postFunctionRestApi(context,
        url: ADD_NEW_UNIT,
        body: jsonEncode({
          "unitID": unitID,
          "ownerID": 0,
          "userID": userID,
          "statusID": 1,
        }));
    S_finishLoader();
    return json.decode(res)["message"].toString();
  }
}
