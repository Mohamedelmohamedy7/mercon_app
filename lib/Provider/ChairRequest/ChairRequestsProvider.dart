import 'dart:convert';

import 'package:core_project/Model/ChairRequest/GetAllChairRequestStatusesModel.dart';
import 'package:core_project/Model/ChairRequest/GetAllChairRequestsModel.dart';
import 'package:core_project/Model/ChairRequest/GetChairCountModel.dart';
import 'package:core_project/Model/CustomerServices/customer_services_list_model.dart';
import 'package:core_project/Model/SuperAdminModels/Transactions/Transaction_request.dart';
import 'package:core_project/Model/SuperAdminModels/Transactions/get_all_transactions.dart';
import 'package:core_project/Model/SuperAdminModels/VisitAndRentModels/notice_visit_and_rent_details_model.dart';
import 'package:core_project/Model/SuperAdminModels/VisitAndRentModels/visit_and_rent_model.dart';
import 'package:core_project/Model/SuperAdminModels/Transactions/get_all_transaction_types.dart';
import 'package:core_project/Model/complaint_list_model.dart';
import 'package:core_project/Services/RestApi.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:core_project/Utill/Local_User_Data.dart';

class ChairRequestsProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;

  bool first = true;
  bool notify = true;
  List<ChairRequestStatusModel> chairRequestStatusModelList = [];

  Future<void> getChairRequestStatusList(
    context,
  ) async {
    chairRequestStatusModelList.clear();
    //  startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetAllChairRequestStatusesEp,
    );
    for (ChairRequestStatusModel chairRequest
        in chairRequestStatusFromJson(res)) {
      chairRequestStatusModelList.add(chairRequest);
      first = false;
    }

    S_finishLoader();
    return;
  }

  List<ChairRequest> chairRequestList = [];
  Future<void> getChairRequestsList(
    context,
  ) async {
    chairRequestList.clear();
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetAllChairRequestsEp,
    );
    for (ChairRequest chairRequest in ChairRequestFromJson(res)) {
      chairRequestList.add(chairRequest);
      first = false;
    }

    S_finishLoader();
    return;
  }

  Future<void> getChairRequestsListByUserId(
    context,
  ) async {
    chairRequestList.clear();
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint:
          GetAllChairRequestsBuUserIdEp + globalAccountData.getId().toString(),
    );
    for (ChairRequest chairRequest in ChairRequestFromJson(res)) {
      chairRequestList.add(chairRequest);
      first = false;
    }

    S_finishLoader();
    return;
  }

  TextEditingController controller = TextEditingController();
  GetChairCountModel? getChairCountModel;
  Future<void> getChairsCount(
    context,
  ) async {
    startLoader();
    getChairCountModel = null;
    final res =
        await getFunctionRestApi(context, urlEndPoint: GetChairsCountEp);
    if (json.decode(res)['data'].isNotEmpty) {
      getChairCountModel = GetChairCountModel.fromJson(json.decode(res));
      controller.text =
          (getChairCountModel?.data?.chairsCount ?? "").toString();
    }

    S_finishLoader();
    return;
  }

  Future<bool> setChairCount(context, {required int chairCount}) async {
    //startLoader();
    // Send the complaint to the backend API
    final response = await putFunctionRestApi(context,
        url: SetChairsCount + chairCount.toString(),
        needContent: true,
        needAccept: true);

    print("hereee ${response}");
    if (response.isEmpty) {
      status = LoadingStatus.FAILURE;
      notifyListeners();
      failedSnack(context, json.decode(response)["message"]);
      return false;
    } else {
      return true;
    }
  }

  Future<void> deleteChairRequest(context,
      {required int? id, bool admin = false}) async {
    startLoader();

    final res = await DeleteFunctionRestApi(
      context,
      url: DeleteChairRequestEp + id.toString(),
    );

    if (admin) {
      getChairRequestsList(context);
    } else {
      getChairRequestsListByUserId(context);
    }

    //  S_finishLoader();
    return;
  }

  Future<bool> CreateChairRequest(context,
      {required ChairRequest chairRequest}) async {
    startLoader();

    chairRequest.statusID = 1;
    final response = await postFunctionRestApi(context,
        url: CreateChairRequestEp,
        body: json.encode(chairRequest.toJson(create: true)),
        needContent: true,
        needAccept: true);

    if (response.isEmpty) {
      status = LoadingStatus.FAILURE;
      notifyListeners();
      failedSnack(context, json.decode(response)["message"]);
      return false;
    } else {
      getChairRequestsListByUserId(context);
      // print("ffff ${response}");
      // var data = json.decode(response);
      // status = LoadingStatus.SUCCESS;
      // notifyListeners();
      return true;
    }
  }

  Future<bool> UpdateChairRequest(context,
      {required ChairRequest chairRequest,
      required int? chairRequestId,
      bool admin = false}) async {
    startLoader();
    chairRequest.id = chairRequestId;
    // Send the complaint to the backend API

    final response = await putFunctionRestApi(context,
        url: UpdateChairRequestEp,
        body: json.encode(chairRequest.toJson(admin: admin)),
        needContent: true,
        needAccept: true);

    print("hereee ${response}");
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
      if (admin) {
        getChairRequestsList(context);
        getChairsCount(context);
      } else {
        getChairRequestsListByUserId(context);
      }
      return true;
    }
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
