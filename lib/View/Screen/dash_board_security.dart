import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import '../../Utill/Comman.dart';
import '../../helper/text_style.dart';
import 'DashBoard/ActionsScreen.dart';
import 'DashBoard/NotificationScreen.dart';
import 'SecurityScreen.dart';
import 'package:core_project/Utill/Local_User_Data.dart';

class DashBoardSecurity extends StatefulWidget {
  const DashBoardSecurity({Key? key}) : super(key: key);

  @override
  State<DashBoardSecurity> createState() => _DashBoardSecurityState();
}

class _DashBoardSecurityState extends State<DashBoardSecurity> {
  int selected = 1;
  List<Widget> screens = [
    const NotificationScreen(needBack: false, adminScreen: false),
    const SecurityScreen(),
    SizedBox(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        floatingActionButton: GestureDetector(
          onTap: () {
            setState(() {
              selected = 1;
            });
          },
          child: floatingLogo(context: context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: StylishBottomBar(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          backgroundColor: Theme.of(context).primaryColor,
          option: AnimatedBarOptions(
            padding: EdgeInsets.symmetric(horizontal: 10),
            barAnimation: BarAnimation.transform3D,
            iconStyle: IconStyle.animated,
          ),
          onTap: (index) async {
            if (index == 0) {
              setState(() {
                selected = index;
              });
            } else {
              await handleWillPopScopeRoot(context, true);
            }
          },
          items: [
            BottomBarItem(
              icon: Image.asset(
                "assets/images/notification.png",
                width: 27,
                height: 27,
              ),
              selectedIcon: Image.asset(
                "assets/images/notification.png",
                width: 25,
                height: 25,
              ),
              backgroundColor: Colors.white,
              selectedColor: Colors.white,
              title: Text('notify'.tr(),
                  style: CustomTextStyle.semiBold12Black
                      .copyWith(fontSize: 8, color: Colors.white)),
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
              icon: textFieldSvg(
                "logout.svg",
                color: Colors.white,
                width: 40,
                height: 40,
              ),
              selectedIcon: textFieldSvg(
                "logout.svg",
                color: Colors.white,
                width: 40,
                height: 40,
              ),
              selectedColor: Colors.white,
              title: Text(
                "logout".tr(),
                style: CustomTextStyle.semiBold12Black
                    .copyWith(fontSize: 10, color: Colors.white),
              ),
            ),
          ],
          hasNotch: false,
          fabLocation: StylishBarFabLocation.center,
          currentIndex: selected ?? 0,
        ),
        body: screens[selected],
      ),
    );
  }
}

Widget floatingLogo({required BuildContext context}) {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle),
    width: 120,
    height: 70,
    child: Center(
      child: cachedImage(
        globalAccountData.getCompoundLogo().toString(),
        width: 110,
        height: 50,
        fit: BoxFit.contain,
      ),
    ),
    //     Image.asset(
    //   "assets/images/logoFloatAction.png",
    //   width: 120,
    //   fit: BoxFit.contain,
    // ),
  );
}
