import 'dart:convert';

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

class TransactionsProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;

  bool first = true;
  bool notify = true;
  List<TransactionType> transactionTypesList = [];

  Future<void> getTransactionTypeList(
    context,
  ) async {
    transactionTypesList.clear();
    //  startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetAllTransactionTypesList,
    );
    for (TransactionType transactionType in transactionTypeFromJson(res)) {
      transactionTypesList.add(transactionType);
      first = false;
    }

    S_finishLoader();
    return;
  }

  List<Transaction> transactionsList = [];
  Future<void> getTransactionsList(
    context,
  ) async {
    transactionsList.clear();
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetAllTransactionsList,
    );
    for (Transaction transactionType in transactionFromJson(res)) {
      transactionsList.add(transactionType);
      first = false;
    }

    S_finishLoader();
    return;
  }

  Transaction? transaction;
  Future<void> getTransactionDetails(context, {required int? id}) async {
    startLoader();
    transaction = null;
    final res = await getFunctionRestApi(context,
        urlEndPoint: GetTransactionDetailsEp + id.toString());
    if (json.decode(res)['data'].isNotEmpty)
      transaction = Transaction.fromJson(json.decode(res)['data']);

    S_finishLoader();
    return;
  }

  Future<void> deleteTransaction(context, {required int? id}) async {
    final res = await DeleteFunctionRestApi(
      context,
      url: DeleteTransactionEp + id.toString(),
    );

    startLoader();

    getTransactionsList(context);
    S_finishLoader();
    return;
  }

  Future<bool> CreateTransaction(context,
      {required TransactionRequest transactionRequest}) async {
    startLoader();

    // Send the complaint to the backend API
    final response = await postFunctionRestApi(context,
        url: CreateTransactionEp,
        body: json.encode(transactionRequest.toJson()),
        needContent: true,
        needAccept: true);

    if (response.isEmpty) {
      status = LoadingStatus.FAILURE;
      notifyListeners();
      failedSnack(context, json.decode(response)["message"]);
      return false;
    } else {
      getTransactionsList(context);
      // print("ffff ${response}");
      // var data = json.decode(response);
      // status = LoadingStatus.SUCCESS;
      // notifyListeners();
      return true;
    }
  }

  Future<bool> UpdateTransaction(context,
      {required TransactionRequest transactionRequest,
      required int? transactionId}) async {
    startLoader();
    transactionRequest.id=transactionId;
    // Send the complaint to the backend API
    final response = await putFunctionRestApi(context,
        url: UpdateTransactionEp ,
        body: json.encode(transactionRequest.toJson()),
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
      getTransactionsList(context);
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
