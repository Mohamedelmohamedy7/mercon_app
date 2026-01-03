import 'dart:io';
import 'package:core_project/Provider/SuperAdminProviders/BottomNavBarProvider.dart';
import 'package:core_project/View/Screen/DashBoard/NotificationScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ActionsScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/SuperAdminScreen.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:upgrader/upgrader.dart';

import '../EmployeeScreens/EmployeeDashboardScreen.dart';

class DashBoardSuperAdmin extends StatefulWidget {
  const DashBoardSuperAdmin({Key? key}) : super(key: key);

  @override
  State<DashBoardSuperAdmin> createState() => _DashBoardSuperAdminState();
}

class _DashBoardSuperAdminState extends State<DashBoardSuperAdmin> {
  /// 0 => Notification
  /// 1 => Center FAB Screen
  /// 2 => Profile
  int selected = 1;

  final List<Widget> screens = [
    const NotificationScreen(needBack: false,adminScreen: true),
    SuperAdminScreen(),
    const ActionsScreenForSuperAdmin(),
  ];

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      shouldPopScope: () => false,
      dialogStyle: Platform.isIOS
          ? UpgradeDialogStyle.cupertino
          : UpgradeDialogStyle.material,
      child: SafeArea(
        child: Consumer<BottomNavBarProvider>(
          builder: (context, model, _) {
            return Scaffold(
              extendBody: true,

              /// ===== FAB (نفس اللوجو بتاعك) =====
              floatingActionButton: model.showBottomNavBar
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: floatingLogo(context: context),
                ),
              )
                  : null,

              floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

              /// ===== Bottom Navigation =====
              bottomNavigationBar: model.showBottomNavBar
                  ? StylishBottomBar(
                backgroundColor: Theme.of(context).primaryColor,
                option: AnimatedBarOptions(
                  barAnimation: BarAnimation.transform3D,
                  iconStyle: IconStyle.animated,
                ),
                hasNotch: false,
                fabLocation: StylishBarFabLocation.center,

                onTap: (index) {
                  setState(() {
                    // 0 -> Notification
                    // 1 -> Profile
                    selected = index == 0 ? 0 : 2;
                  });
                },

                items: [
                  /// ===== Notification (LEFT) =====
                  BottomBarItem(
                    icon: selected == 0
                        ? Image.asset(
                      "assets/images/notification.png",
                      width: 25,
                      height: 25,
                    )
                        : Column(
                      children: [
                        3.height,
                        Image.asset(
                          "assets/images/notification.png",
                          width: 25,
                          height: 25,
                        ),
                        5.height,
                        Text(
                          'notify'.tr(),
                          style: CustomTextStyle.semiBold12Black
                              .copyWith(
                              fontSize: 8,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    selectedIcon: Image.asset(
                      "assets/images/notification.png",
                      width: 25,
                      height: 25,
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: Colors.white,
                    title: Text(
                      'notify'.tr(),
                      style: CustomTextStyle.semiBold12Black.copyWith(
                          fontSize: 8, color: Colors.white),
                    ),
                  ),

                  /// ===== Profile (RIGHT) =====
                  BottomBarItem(
                    icon: selected == 2
                        ? Image.asset(
                      "assets/images/myProfile.png",
                      width: 25,
                      height: 25,
                      color: Colors.white,
                    )
                        : Column(
                      children: [
                        Image.asset(
                          "assets/images/myProfile.png",
                          width: 25,
                          height: 25,
                          color: Colors.white,
                        ),
                        Text(
                          "profile".tr(),
                          style: CustomTextStyle.semiBold12Black
                              .copyWith(
                              fontSize: 9,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    selectedIcon: Image.asset(
                      "assets/images/myProfile.png",
                      width: 30,
                      height: 25,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: Colors.white,
                    title: Text(
                      "profile".tr(),
                      style: CustomTextStyle.semiBold12Black.copyWith(
                          fontSize: 9, color: Colors.white),
                    ),
                  ),
                ],

                /// ربط الـ index بالـ screen
                currentIndex: selected == 2 ? 1 : 0,
              )
                  : null,

              /// ===== Body =====
              body: screens[selected],
            );
          },
        ),
      ),
    );
  }
}
