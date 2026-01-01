import 'dart:convert';

import 'package:core_project/Model/SuperAdminModels/VisitAndRentModels/notice_visit_and_rent_details_model.dart';
import 'package:core_project/Model/SuperAdminModels/VisitAndRentModels/visit_and_rent_model.dart';
import 'package:core_project/Services/RestApi.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';

class VisitAndRentProviderProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;

  bool first = true;
  bool notify = true;
  List<VisitAndRent> visitAndRentList = [];

  Future<void> getVisitAndRentList(context, {bool? isRent}) async {
    visitAndRentList.clear();
    startLoader();
    final res = await postFunctionRestApi(context,
        url: NoticeVisitAndRent, body: json.encode({"isRent": isRent}));
    for (VisitAndRent visit in visitAndRentFromJson(res)) {
      visitAndRentList.add(visit);
      first = false;
    }

    S_finishLoader();
    return;
  }

  NoticeVisitAndRentDetails? noticeVisitAndRentDetails;
  Future<void> getNoticeVisitAndRentDetails(context, {required int? id}) async {
    startLoader();
    noticeVisitAndRentDetails = null;
    final res = await getFunctionRestApi(context,
        urlEndPoint: NoticeVisitAndRentDetailsEp + id.toString());
    if (json.decode(res)['data'].isNotEmpty)
      noticeVisitAndRentDetails =
          NoticeVisitAndRentDetails.fromJson(json.decode(res)['data']);

    S_finishLoader();
    return;
  }

  bool loading = false;
  Future<void> acceptNoticeVisitAndRent(context,
      {required String? id, required String? statusId}) async {
    loading = true;
    notifyListeners();
    final res = await putFunctionRestApi(
      context,
      url: ApproveOrCancelNotice +
          id.toString() +
          "&statusId=" +
          statusId.toString(),
    );

    getVisitAndRentList(context);
    loading = false;
    notifyListeners();
    S_finishLoader();
    return;
  }

  Future<void> saveReasonOfRefuseAdmin(context,
      {required String? userID,
      required String? saveReasonOfRefuseAdmin}) async {
    loading = true;
    notifyListeners();
    final res = await putFunctionRestApi(
      context,
      url: SaveReasonOfRefuseAdmin,
      body: json.encode({
        "userID": userID,
        "saveReasonOfRefuseAdmin": saveReasonOfRefuseAdmin
      }),
    );
    loading = false;
    notifyListeners();
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
