import 'dart:io';
import 'package:core_project/Provider/SuperAdminProviders/BottomNavBarProvider.dart';
import 'package:core_project/View/Screen/DashBoard/NotificationScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ActionsScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/SuperAdminScreen.dart';
import 'package:core_project/View/Screen/dash_board_security.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:upgrader/upgrader.dart';

class DashBoardSuperAdmin extends StatefulWidget {
  const DashBoardSuperAdmin({Key? key}) : super(key: key);

  @override
  State<DashBoardSuperAdmin> createState() => _DashBoardSuperAdminState();
}

class _DashBoardSuperAdminState extends State<DashBoardSuperAdmin> {
  int selected = 1;
  List<Widget> screens = [
    const NotificationScreen(needBack: false),
    SuperAdminScreen(),
    // SizedBox(),
    const ActionsScreenForSuperAdmin(),
  ];

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      shouldPopScope: () => false,
      dialogStyle: Platform.isIOS
          ? UpgradeDialogStyle.cupertino
          : UpgradeDialogStyle.material,
      // upgrader: Upgrader(
      //     shouldPopScope: () => false,
      //     dialogStyle: Platform.isIOS
      //         ? UpgradeDialogStyle.cupertino
      //         : UpgradeDialogStyle.material,
      //     ),
      child: SafeArea(
        child: Consumer<BottomNavBarProvider>(
          builder: (context, model, _) {
            return Scaffold(
              extendBody: true,
              floatingActionButton: model.showBottomNavBar
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = 1;
                        });
                      },
                      child: floatingLogo(context: context),
                    )
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: model.showBottomNavBar
                  ? Container(
                      //color: BACKGROUNDCOLOR,
                      child: StylishBottomBar(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        backgroundColor: Theme.of(context).primaryColor,
                        option: AnimatedBarOptions(
                          barAnimation: BarAnimation.transform3D,
                          iconStyle: IconStyle.animated,
                        ),
                        onTap: (index) {
                          setState(() {
                            selected = index;
                          });
                        },
                        items: [
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
                                      Text('notify'.tr(),
                                          style: CustomTextStyle.semiBold12Black
                                              .copyWith(
                                                  fontSize: 8,
                                                  color: Colors.white)),
                                    ],
                                  ),
                            selectedIcon: Image.asset(
                              "assets/images/notification.png",
                              width: 25,
                              height: 25,
                            ),
                            backgroundColor: Colors.white,
                            selectedColor: Colors.white,
                            title: Text('notify'.tr(),
                                style: CustomTextStyle.semiBold12Black.copyWith(
                                    fontSize: 8, color: Colors.white)),
                          ),
                          BottomBarItem(
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).primaryColor,
                            ),
                            // backgroundColor: Colors.orange,
                            title: Text(
                              "".tr(),
                              style: CustomTextStyle.semiBold12Black
                                  .copyWith(fontSize: 10, color: Colors.white),
                            ),
                          ),
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
                                      )
                                    ],
                                  ),
                            selectedIcon: Image.asset(
                              "assets/images/myProfile.png",
                              width: 30,
                              color: Colors.white,
                              height: 25,
                            ),
                            backgroundColor: Colors.white,
                            selectedColor: Colors.white,
                            title: Text(
                              "profile".tr(),
                              style: CustomTextStyle.semiBold12Black
                                  .copyWith(fontSize: 9, color: Colors.white),
                            ),
                          ),
                        ],
                        hasNotch: false,
                        fabLocation: StylishBarFabLocation.center,
                        currentIndex: selected ?? 0,
                      ),
                    )
                  : null,
              body: screens[selected],
            );
          },
        ),
      ),
    );
  }
}
