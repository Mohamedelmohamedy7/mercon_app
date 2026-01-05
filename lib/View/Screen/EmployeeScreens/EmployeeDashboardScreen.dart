import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/View/Screen/DashBoard/ActionsScreen.dart';
import 'package:core_project/View/Screen/EmployeeScreens/EmployeeGenerateScanQrCodeScreen.dart';
import 'package:core_project/View/Screen/PartAuth/LoginScreen.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:core_project/Utill/Local_User_Data.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  const EmployeeDashboardScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeDashboardScreen> createState() =>
      _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  int selected = 0;
  List<Widget> screens = [
    EmployeeGenerateScanQrCodeScreen(),
    Center(
      child: const SizedBox(
        child: Text(
          "screen 2",
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
    ),
    Center(
      child: SizedBox(
        child: Text(
          "screen 3",
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        floatingActionButton: GestureDetector(
          onTap: () {
            // setState(() {
            //   selected = 1;
            // });
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
                "assets/images/lockIcon.png",
                width: 27,
                height: 27,
              ),
              selectedIcon: Image.asset(
                "assets/images/lockIcon.png",
                width: 25,
                height: 25,
              ),
              backgroundColor: Colors.white,
              selectedColor: Colors.white,
              title: Text('lock'.tr(),
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
        body: Stack(
          children: [
            screens[selected],
            Positioned(
              top: 80,
              child: languageToggleButton(context),
            ),
          ],
        ),
      ),
    );
  }
}

Widget floatingLogo({required BuildContext context}) {
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle),
    width: 120,
    height: 70,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: cachedImage(
          globalAccountData.getCompoundLogo().toString(),
          width: 120,
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
    ),
    //     Image.asset(
    //   "assets/images/logoFloatAction.png",
    //   width: 120,
    //   fit: BoxFit.contain,
    // ),
  );
}

Widget languageToggleButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 5,
      ),
      Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
        child: ToggleButtons(
          isSelected: [
            context.locale == Locale('ar', 'EG'),
            context.locale == Locale('en', 'US'),
          ],
          onPressed: (int index) {
            if (index == 0) {
              context.locale = Locale('ar', 'EG');
            } else {
              context.locale = Locale('en', 'US');
            }
          },
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Image.asset('assets/images/eg.png', width: 17),
                SizedBox(width: 8),
                Text("AR",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Image.asset('assets/images/us.png', width: 17),
                SizedBox(width: 8),
                Text("EN",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
          borderRadius: BorderRadius.circular(7),
          borderColor: Colors.grey.shade400,
          selectedColor: Colors.white,
          fillColor: Theme.of(context).primaryColor,
          color: Colors.black,
          selectedBorderColor: Colors.blueAccent,
        ),
      ),
    ],
  );
}
