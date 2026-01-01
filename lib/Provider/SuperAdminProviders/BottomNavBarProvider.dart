import 'package:core_project/Utill/Comman.dart';
import 'package:flutter/material.dart';
import '../../helper/EnumLoading.dart';

class BottomNavBarProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void onDrawerStateChanged() {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      showBottomNavBar = false;
      notifyListeners();
    } else {
      showBottomNavBar = true;
      notifyListeners();
    }
  }

  bool showBottomNavBar = true;

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
