import 'dart:convert';

import 'package:core_project/Model/CustomerServices/customer_services_list_model.dart';
import 'package:core_project/Services/RestApi.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';

class CustomerServiceProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;

  bool first = true;
  bool notify = true;
  List<CustomerServiceModel> customerServicesList = [];

  Future<void> getCustomerServicesList(context, {bool? isRent}) async {
    customerServicesList.clear();
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetAllServiceRequest,
    );
    for (CustomerServiceModel customerService in customerServiceFromJson(res)) {
      customerServicesList.add(customerService);
      first = false;
    }

    S_finishLoader();
    return;
  }

  CustomerServiceModel? customerServiceModel;
  Future<void> getCustomerServiceDetails(context, {required int? id}) async {
    startLoader();
    customerServiceModel = null;
    final res = await getFunctionRestApi(context,
        urlEndPoint: GetServiceRequestById + id.toString());
    if (json.decode(res)['data'].isNotEmpty)
      customerServiceModel =
          CustomerServiceModel.fromJson(json.decode(res)['data']);

    S_finishLoader();
    return;
  }

  bool loading = false;

  Future<void> startingRequest(context, {required int? id}) async {
    loading = true;
    notifyListeners();
    final res =
        await putFunctionRestApi(context, url: StartingRequest + id.toString());
    getCustomerServicesList(context);
    loading = false;
    notifyListeners();
    S_finishLoader();
    return;
  }
  Future<void> sendTimeOfService(context, {required Map<String, dynamic> body}) async {
    // loading = true;
    notifyListeners();
    final res = await putFunctionRestApi(context, url: UpdateServiceRequest,body: jsonEncode(body),
  );
    loading = false;
    notifyListeners();
    S_finishLoader();
    return;
  }
  Future<void> updateServiceStatus(context,
      {required int? id, required int? statusId}) async {
    loading = true;
    notifyListeners();
    final res = await putFunctionRestApi(context,
        url: UpdateServiceStatus,
        body: json.encode({"id": id, "statusId": statusId}));
    getCustomerServicesList(context);
    loading = false;
    notifyListeners();
    S_finishLoader();
    return;
  }

  Future<void> updateServicePrice(context,
      {required int? id, required String field, required String? value}) async {
    startLoader();
    await putFunctionRestApi(context,
        url: UpdateServicePrice,
        body: json.encode({
          "id": id,
          "field": field,
          "value": value,
        }));
    getCustomerServiceDetails(context, id: id);

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
