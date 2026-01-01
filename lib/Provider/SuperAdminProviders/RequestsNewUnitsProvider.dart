import 'dart:convert';

import 'package:core_project/Model/SuperAdminModels/RequestsNewUnitsModel/request_list_model.dart';
import 'package:core_project/Services/RestApi.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';

import '../../Model/SuperAdminModels/unit_details_model.dart';

class RequestsNewUnitsProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;

  bool first = true;
  bool notify = true;
  List<RequestModel> requestNewUnits = [];

  Future<void> getOwnerUserUnits(context) async {
    requestNewUnits.clear();
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetAllRequestAnnexProperty,
      //  body: json.encode({"pageNumber": 0, "pageSize": 0})
    );
    for (RequestModel request in requestsNewUnitsFromJson(res)) {
      requestNewUnits.add(request);
      first = false;
    }

    S_finishLoader();
    return;
  }
  Future<void> deleteRequest(context, {required int? id}) async {
    final res = await DeleteFunctionRestApi(
      context,
      url: DeleteOwnrUnit +"?Id="+ id.toString(),
    );
    getOwnerUserUnits(context);
    S_finishLoader();
    return;
  }
  UnitDetailsModel? unitDetailsModel;
  bool showAcceptOrRejectOwnerUnit = false;
  Future<void> getRequestUnitOwnerDetails(context, {required int? unitId}) async {
    startLoader();
    unitDetailsModel = null;
    final res = await getFunctionRestApi(context,
        urlEndPoint: GetRequestAnnexPropertyUnitOwnerById + unitId.toString());
    if (json.decode(res)['data'].isNotEmpty)
      unitDetailsModel = UnitDetailsModel.fromJson(json.decode(res));

    showAcceptOrRejectOwnerUnit = unitDetailsModel?.data?.unitDetails
        ?.any((element) => element.statusID == 2) ??
        false;

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
