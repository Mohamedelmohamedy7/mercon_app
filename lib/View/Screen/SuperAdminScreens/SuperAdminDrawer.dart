import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/View/Screen/EmployeeScreens/EmployeeGenerateScanQrCodeScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ChairRequest/ChairRequestsListScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ComplaintScreens/ComplaintListScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/CustomerServiceasScreens/CustomerServicesListScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/GateLogsScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/NotificationForAdminScreens/notification_for_admin_screen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/OwnersManagement/OwnersManagementScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/Payment/PaymentLogsScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/RequestsNewUnitsScreens/RequestsNewUnitsScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/Transactions/TransactionsListScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/VisitAndRentScreens/VisitAndRentScreen.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import "package:core_project/Utill/Local_User_Data.dart";

class SuperAdminDrawer extends StatelessWidget {
  const SuperAdminDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            Padding(
              padding:   EdgeInsetsDirectional.only(start: 60,end: 60,top: 20),
              child: Image.asset("assets/images/the_gate.png", width: 200, height: 100),
            ),
            drawerItem(
                show: true,
                onTap: () {
                  Navigator.pop(context);
                },
                icon: Icons.home,
                test: "home".tr()),
            drawerItem(
                show: globalAccountData.getUserType() ==
                        AppConstants.IS_SuperAdmin ||
                    globalAccountData.getUserType() ==
                        AppConstants.IS_Accounting,
                onTap: () {
                  pushRoute(
                    context: context,
                    route: OwnersManagementScreen(
                      needBack: true,
                    ),
                  );
                },
                icon: Icons.person,
                test: "owners_management".tr()),
            drawerItem(
                show: globalAccountData.getUserType() ==
                    AppConstants.IS_SuperAdmin,
                onTap: () {
                  pushRoute(
                    context: context,
                    route: RequestsNewUnitsScreen(
                      needBack: true,
                    ),
                  );
                },
                icon: Icons.add_business,
                test: "ownership_requests".tr()),
            drawerItem(
                show: globalAccountData.getUserType() ==
                    AppConstants.IS_SuperAdmin,
                onTap: () {
                  pushRoute(
                    context: context,
                    route: VisitAndRentScreen(
                      needBack: true,
                    ),
                  );
                },
                icon: Icons.notifications,
                test: "visit_and_rent_notifications".tr()),
            drawerItem(
                show: globalAccountData.getUserType() ==
                    AppConstants.IS_SuperAdmin,
                onTap: () {
                  pushRoute(
                    context: context,
                    route: ChairRequestsListScreen(
                      needBack: true,
                    ),
                  );
                },
                icon: Icons.chair,
                test: "chairRequest".tr()),
            drawerItem(
                show: globalAccountData.getUserType() ==
                        AppConstants.IS_SuperAdmin ||
                    globalAccountData.getUserType() ==
                        AppConstants.IS_Supervisor ||
                    globalAccountData.getUserType() ==
                        AppConstants.IS_CustomerService,
                onTap: () {
                  pushRoute(
                    context: context,
                    route: CustomerServicesListScreen(
                      needBack: true,
                    ),
                  );
                },
                icon: Icons.call,
                test: "customer_service".tr()),
            drawerItem(
                show: globalAccountData.getUserType() ==
                    AppConstants.IS_SuperAdmin,
                onTap: () {
                  pushRoute(
                    context: context,
                    route: TransactionsListScreen(
                      needBack: true,
                    ),
                  );
                },
                icon: Icons.edit_note_rounded,
                test: "transactions".tr()),
            drawerItem(
                show: globalAccountData.getUserType() ==
                        AppConstants.IS_SuperAdmin ||
                    globalAccountData.getUserType() ==
                        AppConstants.IS_CustomerService,
                onTap: () {
                  pushRoute(
                    context: context,
                    route: ComplaintListScreen(
                      needBack: true,
                    ),
                  );
                },
                icon: Icons.comment_sharp,
                test: "complaint".tr()),
            drawerItem(
                show: globalAccountData.getUserType() ==
                    AppConstants.IS_SuperAdmin,
                onTap: () {
                  pushRoute(
                    context: context,
                    route: NotificationForAdminScreen(needBack: true),
                  );
                },
                icon: Icons.messenger,
                test: "notifications".tr()),
            drawerItem(
                show: globalAccountData.getUserType() ==
                        AppConstants.IS_SuperAdmin ||
                    globalAccountData.getUserType() ==
                        AppConstants.IS_Accounting,
                onTap: () {
                  pushRoute(
                    context: context,
                    route: PaymentLogsScreen(needBack: true),
                  );
                },
                icon: Icons.cases_rounded,
                test: "Loading_Financial_Dues".tr()),
            drawerItem(
                show: globalAccountData.getUserType() ==
                    AppConstants.IS_SuperAdmin,
                onTap: () {
                  pushRoute(
                    context: context,
                    route: GateLogsScreen(
                      needBack: true,
                    ),
                  );
                },
                icon: Icons.login,
                test: "gate_logs".tr()),
            drawerItem(
                show: globalAccountData.getUserType() !=
                    AppConstants.IS_SuperAdmin,
                onTap: () {
                  pushRoute(
                    context: context,
                    route: EmployeeGenerateScanQrCodeScreen(
                      needBack: true,
                    ),
                  );
                },
                icon: Icons.lock,
                test: "scanQrCode".tr()),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(
      {required bool show,
      required void Function() onTap,
      required IconData icon,
      required String test}) {
    return show
        ? ListTile(
            leading: Icon(
              icon,
              color: Colors.white,
            ),
            title: Text(test,
                style: TextStyle(
                  color: Colors.white,
                )),
            onTap: onTap,
          )
        : SizedBox();
  }
}
