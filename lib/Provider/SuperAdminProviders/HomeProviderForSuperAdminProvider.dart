import 'dart:convert';
import 'package:core_project/Model/HomeComponantModel/NewsModel.dart';
import 'package:core_project/Model/SuperAdminModels/general_model.dart';
import 'package:core_project/Model/SuperAdminModels/get_units_for_dashboard_model.dart';
import 'package:core_project/Provider/UnitsProvider.dart';
import 'package:core_project/Services/RestApi.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';

import '../../Model/NotApprovedUnitOwnersResponse.dart';
import '../../Model/RentRequestModel.dart';
import '../../Model/VisitorsNotApprovedResponse.dart';
import '../../Model/VisitorsNotExitResponse.dart';
import '../../Model/newRequestModel.dart';

class HomeProviderForSuperAdminProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;

  bool notify = true;
  GeneralModel? getVisitorsNotApprovedCountModel;
  GeneralModel? getRentsNotApprovedCountModel;
  GeneralModel? getVisitorsNotExitCountModel;
  GeneralModel? getNewOwnersCountModel;
  GeneralModel? getNewRequestsCountModel;
  List<Unitmodel> getUnitsForDashboardModel = [];
  RequestResponse ? requestResponse;
  RentNotApprovedResponse ? rentNotApprovedResponse;
  NotApprovedUnitOwnersResponse ? notApprovedUnitOwnersResponse;
  VisitorsNotApprovedResponse ? visitorsNotApprovedResponse;
  VisitorsNotExitResponse ? visitorsNotExitResponse;

  Future<void> loadData(context) async {
    catchError(
        getVisitorsNotApprovedCount(context), 'getVisitorsNotApprovedCount');
    catchError(getRentsNotApprovedCount(context), 'getRentsNotApprovedCount');
    catchError(getVisitorsNotExitCount(context), 'getVisitorsNotExitCount');
    catchError(getNewOwnersCount(context), 'getNewOwnersCount');
    catchError(getNewRequestsCount(context), 'getNewRequestsCount');
    catchError(getUnitsForDashboard(context), 'getUnitsForDashboard');
  }

  Future<void> getVisitorsNotApprovedCount(context) async {
    startLoader();
    final res = await getFunctionRestApi(context,
        urlEndPoint: GetVisitorsNotApprovedCount);
    getVisitorsNotApprovedCountModel = GeneralModel.fromJson(json.decode(res));
    S_finishLoader();
    return;
  }

  Future<void> getNewRequests(context) async {
    startLoader();
    final res = await getFunctionRestApi(context, urlEndPoint: GetNewRequests);
    requestResponse = RequestResponse.fromJson(json.decode(res));
    S_finishLoader();
    return;
  }

  Future<void> getVisitorsNotExitResponse(context) async {
    startLoader();
    final res = await getFunctionRestApi(
        context, urlEndPoint: GetVisitorsNotExitResponse);
    visitorsNotExitResponse =
        VisitorsNotExitResponse.fromJson(json.decode(res));
    S_finishLoader();
    return;
  }

  Future<void> getRentsNotApproved(context) async {
    startLoader();
    final res = await getFunctionRestApi(
        context, urlEndPoint: GetRentsNotApproved);
    rentNotApprovedResponse =
        RentNotApprovedResponse.fromJson(json.decode(res));
    S_finishLoader();
    return;
  }

  Future<void> getVisitsNotApproved(context) async {
    startLoader();
    final res = await getFunctionRestApi(
        context, urlEndPoint: GetVisitsNotApproved);
    visitorsNotApprovedResponse =
        VisitorsNotApprovedResponse.fromJson(json.decode(res));
    S_finishLoader();
    return;
  }

  Future<void> getUnitOwnersNotApproved(context) async {
    startLoader();
    final res = await getFunctionRestApi(
        context, urlEndPoint: GetUnitOwnersNotApproved);
    notApprovedUnitOwnersResponse =
        NotApprovedUnitOwnersResponse.fromJson(json.decode(res));
    S_finishLoader();
    return;
  }

  Future<void> getRentsNotApprovedCount(context) async {
    startLoader();
    final res = await getFunctionRestApi(context,
        urlEndPoint: GetRentsNotApprovedCount);
    getRentsNotApprovedCountModel = GeneralModel.fromJson(json.decode(res));
    S_finishLoader();
    return;
  }

  Future<void> getVisitorsNotExitCount(context) async {
    startLoader();
    final res =
    await getFunctionRestApi(context, urlEndPoint: GetVisitorsNotExitCount);
    getVisitorsNotExitCountModel = GeneralModel.fromJson(json.decode(res));
    S_finishLoader();
    return;
  }

  Future<void> getNewOwnersCount(context) async {
    startLoader();
    final res =
    await getFunctionRestApi(context, urlEndPoint: GetNewOwnersCount);
    getNewOwnersCountModel = GeneralModel.fromJson(json.decode(res));
    S_finishLoader();
    return;
  }

  Future<void> getNewRequestsCount(context) async {
    startLoader();
    final res =
    await getFunctionRestApi(context, urlEndPoint: GetNewRequestsCount);
    getNewRequestsCountModel = GeneralModel.fromJson(json.decode(res));
    S_finishLoader();
    return;
  }

  Future<void> getUnitsForDashboard(context) async {
    getUnitsForDashboardModel.clear();
    startLoader();
    final res =
    await getFunctionRestApi(context, urlEndPoint: GetUnitsForDashboard);
    for (Unitmodel unitModel in unitModelFromJson(res)) {
      getUnitsForDashboardModel.add(unitModel);
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
}