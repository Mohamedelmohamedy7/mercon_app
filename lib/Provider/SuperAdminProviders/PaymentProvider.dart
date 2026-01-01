import 'dart:convert';
import 'package:core_project/Model/SuperAdminModels/get_all_payment_type.dart';
import 'package:core_project/Model/SuperAdminModels/payment_logs_model.dart';
import 'package:core_project/Services/RestApi.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';
import '../../helper/EnumLoading.dart';

class PaymentProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;
  List<PaymentLog> paymentLogsList = [];

  bool first = true;
  bool notify = true;
  Future<void> getPaymentLogs(context) async {
    paymentLogsList.clear();
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetOwnersPaymentLogs,
      //  body: json.encode({"pageNumber": 0, "pageSize": 0})
    );
    for (PaymentLog payment in paymentLogsModelFromJson(res)) {
      paymentLogsList.add(payment);
      first = false;
    }

    S_finishLoader();
    return;
  }

  Future<String> addOwnerUnitPayment(
    context, {
    required int? unitModelId,
    required int? buildingNumberId,
    required int? unitId,
    required int? levelId,
    required int? paymentTypeId,
    required String description,
  //  required String recivedType,
    required bool isAllUnits,
    required String value,
  }) async {
    print("656565");
    startLoader();
    final res = await postFunctionRestApi(context,
        url: AddOwnerUnitPayment,
        body: json.encode({
          "unitModelId": unitModelId,
          "buildingNumberId": buildingNumberId,
          "unitId": unitId,
          "levelId": levelId,
          "paymentTypeId": paymentTypeId,
         // "recivedType": recivedType,
          "description": description,
          "value": value,
          "isAllUnits": isAllUnits
        }));

    // if ((json.decode(res)["message"].toString()).isNotEmpty) {
    //   successSnak(context, json.decode(res)["message"], translateTest: false);
    // } else {
    //   failedSnack(context, json.decode(res)["data"], translateTest: false);
    // }

    getPaymentLogs(context);
    S_finishLoader();
    return json.decode(res)["message"].toString();
  }
  List<PaymentType> paymentTypesList = [];

  Future< List<PaymentType> > getPaymentTypes(context) async {
    paymentTypesList.clear();
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetAllPaymentType,
      //  body: json.encode({"pageNumber": 0, "pageSize": 0})
    );
    for (PaymentType payment in getPaymentTypesModelFromJson(res)) {
      paymentTypesList.add(payment);
    }

    S_finishLoader();
    return paymentTypesList;
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
