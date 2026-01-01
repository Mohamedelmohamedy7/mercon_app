import "package:core_project/Utill/Comman.dart";
import "package:core_project/Utill/Local_User_Data.dart";
import "package:core_project/View/Screen/DashBoard/DashBoardSCreen.dart";
import "package:core_project/View/Screen/EmployeeScreens/EmployeeDashboardScreen.dart";
import "package:core_project/View/Screen/PartAuth/LoginScreen.dart";
import "package:core_project/View/Screen/SuperAdminScreens/dashboard_super_admin.dart";
import "package:core_project/View/Screen/dash_board_security.dart";
import "package:core_project/helper/app_constants.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";

Future navigatorManager({required BuildContext context}) {
  return Future.delayed(const Duration(seconds: 3), () async {
    await globalAccountData.init().then((value) async {
      if (globalAccountData.getUserType() == AppConstants.IS_OWNER) {
        return pushRemoveUntilRoute(
          context: context,
          route: DashBoardScreen(),
        );
      } else if (globalAccountData.getUserType() ==
              AppConstants.IS_SuperAdmin ||
          globalAccountData.getUserType() ==  AppConstants.IS_FullSuperAdmin ||
          globalAccountData.getUserType() == AppConstants.IS_Accounting ||
          globalAccountData.getUserType() == AppConstants.IS_Supervisor ||
          globalAccountData.getUserType() == AppConstants.IS_CustomerService) {
        return pushRemoveUntilRoute(
          context: context,
          route: DashBoardSuperAdmin(),
        );
      } else if (globalAccountData.getUserType() ==
          AppConstants.IS_SecurityOfficer) {
        return pushRemoveUntilRoute(
          context: context,
          route: DashBoardSecurity(),
        );
      }
      else if(globalAccountData.getUserType() ==
          AppConstants.IS_Employee)
        {
          return pushRemoveUntilRoute(
            context: context,
            route: EmployeeDashboardScreen(),
          );
        }

      else {
        await globalAccountData.clearSharedPreferencesForLogOut();
        toast("error_to_login".tr());
        return pushRemoveUntilRoute(
          context: context,
          route: LoginScreen(),
        );
      }
    });
  });
}
