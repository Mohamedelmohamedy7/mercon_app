import 'package:core_project/Model/SuperAdminModels/get_gate_logs_model.dart';
import 'package:core_project/Services/RestApi.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';
import '../../helper/EnumLoading.dart';

class GetGateLogProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;
  List<GateModel> gateModelList = [];
  Future<void> getGateLog(context) async {
    gateModelList.clear();
    startLoader();
    final res = await getFunctionRestApi(
      context,
      urlEndPoint: GetAllGateLogs,
      //  body: json.encode({"pageNumber": 0, "pageSize": 0})
    );
    for (GateModel gate in gateModelFromJson(res)) {
      gateModelList.add(gate);
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