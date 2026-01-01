import 'dart:convert';
import 'dart:developer';

import 'package:core_project/Model/SuperAdminModels/OwnerManagementModels/check_model.dart';
import 'package:core_project/Model/SuperAdminModels/OwnerManagementModels/search_model.dart';
import 'package:core_project/Model/SuperAdminModels/OwnerManagementModels/user_model.dart';
import 'package:core_project/Model/SuperAdminModels/unit_details_model.dart';
import 'package:core_project/Services/RestApi.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';

import '../../Model/SuperAdminModels/OwnerManagementModels/payment_model.dart';

class OwnersManagementProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;

  bool first = true;
  bool notify = true;
  List<User> ownerUserUnits = [];

  bool search = false;

  void changeSearchKey() {
    search = false;
    notifyListeners();
  }

  Future<void> getOwnerUserUnits(context) async {
    ownerUserUnits.clear();
    search = false;
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetAllUintOwners,
      //  body: json.encode({"pageNumber": 0, "pageSize": 0})
    );
    for (User user in userUnitModelFromJson(res)) {
      ownerUserUnits.add(user);
      first = false;
    }

    S_finishLoader();
    return;
  }

  Future<void> getOwnerUserUnitsSearch(context,
      {required SearchModel model}) async {
    ownerUserUnits.clear();
    search = true;
    startLoader();
    final res = await postFunctionRestApi(
      context,
      url: GetAllUintOwnersSearch,
      body: json.encode(model.toJson()),
      //  body: json.encode({"pageNumber": 0, "pageSize": 0})
    );
    for (User user in userUnitModelFromJson(res)) {
      ownerUserUnits.add(user);
    }
    S_finishLoader();
    return;
  }

  Future<void> blockOrUnBlockUser(context, {required int? id}) async {
    final res = await putFunctionRestApi(
      context,
      url: BlockOrUnBlockUser + id.toString(),
    );

    if (res.isEmpty) {
      getOwnerUserUnits(context);
    }
    S_finishLoader();
    return;
  }

  Future<void> deleteUser(context, {required int? id}) async {
    final res = await putFunctionRestApi(
      context,
      url: DeleteUser + id.toString(),
    );

    if (res.isEmpty) {
      getOwnerUserUnits(context);
    }
    S_finishLoader();
    return;
  }

  UnitDetailsModel? unitDetailsModel;

  bool showAcceptOrRejectOwnerUnit = false;
  Future<void> getUnitOwnerDetails(context, {required int? id}) async {
    startLoader();
    unitDetailsModel = null;
    final res = await getFunctionRestApi(context,
        urlEndPoint: GetUnitOwnerDetails + id.toString());
    if (json.decode(res)['data'].isNotEmpty)
      unitDetailsModel = UnitDetailsModel.fromJson(json.decode(res));

    showAcceptOrRejectOwnerUnit = unitDetailsModel?.data?.unitDetails
            ?.any((element) => element.statusID == 2) ??
        false;

    S_finishLoader();
    return;
  }

  Future<void> sendReason(context,
      {required String? userId, required String? reason}) async {
    startLoader();
    final res = await postFunctionRestApi(context,
        url: SendDenialReason,
        body: json.encode({
          "userId": userId,
          "denialReason": reason,
        }));

    if (res.isEmpty) {
      getOwnerUserUnits(context);
    }
    S_finishLoader();
    return;
  }

  Future<void> accept(context, {required String? id}) async {
    startLoader();
    final res = await putFunctionRestApi(
      context,
      url: Accept + id.toString(),
    );

    if (res.isEmpty) {
      getOwnerUserUnits(context);
    }
    S_finishLoader();
    return;
  }

  PaymentModel? paymentModel;

  bool loading = false;
  Future<void> getPaymentData(context,
      {required int? id, required int? ownerId}) async {
    loading = true;
    notifyListeners();
    final res = await getFunctionRestApi(context,
        urlEndPoint: GetUnitPayments + id.toString() + "&OwnerId=$ownerId");
    paymentModel = PaymentModel.fromJson(json.decode(res));
    loading = false;
    notifyListeners();

    return;
  }

  bool isSwitched = false;
  Future<void> paidOwnerPayment(context, {required int? id}) async {
    final res = await putFunctionRestApi(
      context,
      url: PaidOwnerPayment + id.toString(),
    );

    S_finishLoader();
    return;
  }

  CheckModel? checkModel;
  Future<CheckModel?> checkUnitBelongingToAnotherOwner(context,
      {required int? unitId}) async {
    checkModel = null;
    final res = await postFunctionRestApi(context,
        url: CheckUnitBelongingToAnotherOwner,
        body: json.encode({"unitID": unitId}));
    if (json.decode(res).isNotEmpty)
      checkModel = CheckModel.fromJson(json.decode(res));

    S_finishLoader();
    return checkModel;
  }

  Future<void> statusForOwnerAndUnit(context,
      {required int? ownerUnitOldID,
      required int? ownerID, int? ownerDataID,
      required int? unitID,
      required int? statusID}) async {
    startLoader();
    print("-*-*-*-*->>");
    log({   "ownerUnitOldID": ownerUnitOldID, //when accept and remove old owner that get from checkUnitBelongingToAnotherOwner
      "ownerUnitsID": ownerID,
      "unitID": unitID,
      "ownerID":ownerDataID?? ownerID,
      "statusID": statusID, }.toString());
    print("SEWc-*-*-*-*->>");
    final res = await putFunctionRestApi(
      context,
      url: StatusForOwnerAndUnit,
      body: json.encode({
        "ownerUnitOldID": ownerUnitOldID, //when accept and remove old owner that get from checkUnitBelongingToAnotherOwner
        "ownerUnitsID": ownerID,
        "unitID": unitID,
        "ownerID":ownerDataID?? ownerID,
        "statusID": statusID, //
      }),
    );

    S_finishLoader();
    return;
  }

  void S_finishLoader() {
    status = LoadingStatus.SUCCESS;
    notifyListeners();
  }

  void startLoader() {
    status = LoadingStatus.LOADING;
    if (notify) notifyListeners();
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
