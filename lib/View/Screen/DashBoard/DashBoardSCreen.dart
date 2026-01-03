import 'dart:io';
import 'package:core_project/Provider/LoginProvider.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/View/Screen/dash_board_security.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/generated/assets.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'HomeScreen.dart';
import 'QrCode/AskScanQrCode.dart';
import 'ActionsScreen.dart';
import 'MyOrders.dart';
import 'NotificationScreen.dart';

Widget callCenterBottom(context) => InkWell(
  onTap: (){
     launchUrl(Uri.parse("tel:${globalAccountData.getPhoneNumber()}"));
  },
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
     margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("connectClientSupport".tr(),style:
        CustomTextStyle.semiBold12Black.copyWith(fontSize: 14,color: Colors.white),),
       10.width,
        Icon(Icons.phone, color: Colors.white, size: 25),
      ],
    ),
  ),
);

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key,this.selected=2}) : super(key: key);

  final int selected;
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with WidgetsBindingObserver {
  int selected = 2;
  var heart = false;
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Widget> screens = [
    const AskScanQrCode(),
    const NotificationScreen(needBack: false,adminScreen: false),
    const HomeScreen(),
    const MyOrders(),
    const ActionsScreen(),
  ];

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);

    selected=widget.selected;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await globalAccountData.init();
    });
    if (globalAccountData.getCompoundId() == null) {
      Provider.of<LoginProvider>(context, listen: false)
          .getCompoundData(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await handleWillPopScopeRoot(context, false);
      },
      child: UpgradeAlert(
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
        child: Scaffold(
          extendBody: true,
          body: screens[selected],
          bottomNavigationBar: StylishBottomBar(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
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
                        "assets/images/lockIcon.png",
                        width: 25,
                        height: 25,
                        color: Colors.white,
                      )
                    : Column(
                        children: [
                          Image.asset(
                            "assets/images/lockIcon.png",
                            color: Colors.white,
                            width: 25,
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              "lock".tr(),
                              style: CustomTextStyle.semiBold12Black
                                  .copyWith(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                selectedIcon: Image.asset(
                  "assets/images/lockIcon.png",
                  width: 25,
                  height: 25,
                ),
                selectedColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    "lock".tr(),
                    style: CustomTextStyle.semiBold12Black
                        .copyWith(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
              BottomBarItem(
                icon: selected == 1
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
                                  .copyWith(fontSize: 8, color: Colors.white)),
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
                icon: selected == 3
                    ? Image.asset(
                        "assets/images/serviceClient.png",
                        width: 30,
                        height: 30,
                      )
                    : Column(
                        children: [
                          2.height,
                          Image.asset(
                            "assets/images/serviceClient.png",
                            width: 25,
                            height: 25,
                          ),
                          3.height,
                          Text(
                            "clientService".tr(),
                            style: CustomTextStyle.semiBold12Black
                                .copyWith(fontSize: 8, color: Colors.white),
                          )
                        ],
                      ),
                selectedIcon: Image.asset(
                  "assets/images/serviceClient.png",
                  width: 25,
                  height: 25,
                ),
                selectedColor: Colors.white, // unSelectedColor: Colors.purple,
                // backgroundColor: Colors.orange,
                title: Text(
                  "clientService".tr(),
                  style: CustomTextStyle.semiBold12Black
                      .copyWith(fontSize: 9, color: Colors.white),
                ),
              ),
              BottomBarItem(
                icon: selected == 4
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
                                .copyWith(fontSize: 9, color: Colors.white),
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
          floatingActionButton: GestureDetector(
            onTap: () {
              setState(() {
                selected = 2;
              });
            },
            child: floatingLogo(context: context),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
