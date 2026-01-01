import 'dart:convert';

import 'package:core_project/Model/CustomerServices/customer_services_list_model.dart';
import 'package:core_project/Model/SuperAdminModels/VisitAndRentModels/notice_visit_and_rent_details_model.dart';
import 'package:core_project/Model/SuperAdminModels/VisitAndRentModels/visit_and_rent_model.dart';
import 'package:core_project/Model/complaint_list_model.dart';
import 'package:core_project/Services/RestApi.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';

class ComplaintProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;

  bool first = true;
  bool notify = true;
  List<ComplaintModel> complaintList = [];

  Future<void> getComplaintList(context, {bool? isRent}) async {
    complaintList.clear();
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetComplaintList,
    );
    for (ComplaintModel complaintModel in complaintFromJson(res)) {
      complaintList.add(complaintModel);
      first = false;
    }

    S_finishLoader();
    return;
  }

  ComplaintModel? complaintModel;
  Future<void> getComplaintDetails(context, {required int? id}) async {
    startLoader();
    complaintModel = null;
    final res = await getFunctionRestApi(context,
        urlEndPoint: GetComplaintById + id.toString());
    if (json.decode(res)['data'].isNotEmpty)
      complaintModel = ComplaintModel.fromJson(json.decode(res)['data']);

    S_finishLoader();
    return;
  }

  Future<void> deleteComplaint(context, {required int? id}) async {
    final res = await putFunctionRestApi(
      context,
      url: DeleteComplaintById + id.toString(),
    );

    if (res.isEmpty) {
      getComplaintList(context);
    }
    S_finishLoader();
    return;
  }

  bool loading = false;

  void S_finishLoader() {
    status = LoadingStatus.SUCCESS;
    notifyListeners();
  }

  void startLoader() {
    status = LoadingStatus.LOADING;
    if (notify) notifyListeners();
  }


  Future<bool> sendReplay(context,
      {
        required int? complaintID,
        required String replyText,}) async
  {
    startLoader();

    Map<String,dynamic> replay ={
      "complaintID": complaintID,
      "replyText": replyText
    };
    // Send the complaint to the backend API
    final response = await postFunctionRestApi(context,
        url: SendReplayToComplanint,
        body:json.encode(replay) ,
        needContent: true,
        needAccept: true);


    if (response.isEmpty) {
      status = LoadingStatus.FAILURE;
      notifyListeners();
      failedSnack(context, json.decode(response)["message"]);
      return false;
    } else {
      // print("ffff ${response}");
      // var data = json.decode(response);
      // status = LoadingStatus.SUCCESS;
      // notifyListeners();
      return true;
    }
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
