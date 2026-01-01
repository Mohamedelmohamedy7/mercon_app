import 'package:core_project/View/Screen/PartAuth/edit_account_befour_accept.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/dashboard_super_admin.dart';
import 'package:core_project/check_user_type.dart';
import 'package:core_project/helper/size_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Provider/ConfigProvider.dart';
import 'Provider/HomeProvider.dart';
import 'Utill/Comman.dart';
import 'Utill/LoaderWidget/loader_widget.dart';
import 'Utill/Local_User_Data.dart';
import 'View/Screen/DashBoard/DashBoardSCreen.dart';
import 'View/Screen/DashBoard/ActionsScreen.dart';
import 'View/Screen/blocked_screen.dart';
import 'View/Screen/dash_board_security.dart';
import 'helper/EnumLoading.dart';
import 'helper/app_constants.dart';
import 'helper/color_resources.dart';
import 'helper/text_style.dart';

class WaitingApprove extends StatefulWidget {
  const WaitingApprove({Key? key}) : super(key: key);

  @override
  State<WaitingApprove> createState() => _WaitingApproveState();
}

class _WaitingApproveState extends State<WaitingApprove> {
  @override
  void initState() {
    catchError(p_Listeneress<ConfigProvider>(context).getHotlineNumber(context),
        'loadConfigData');
    catchError(
        p_Listeneress<ConfigProvider>(context).getWhatsAppNumber(context),
        'loadConfigData');
    super.initState();
  }

  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Consumer<ConfigProvider>(builder: (context, model, _) {
          if (model.status == LoadingStatus.LOADING) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoaderWidget(),
                ],
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              //color: BACKGROUNDCOLOR,
              child: RefreshIndicator(
                backgroundColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onRefresh: () async {
                  Provider.of<ConfigProvider>(context, listen: false)
                      .refreshMyAccessibility(context)
                      .then((value) {
                    if (value == 'isBlocked') {
                      pushRemoveUntilRoute(
                          context: context, route: BlockedScreen());
                    } else if (value == 'isApprove') {
                    } else {
                      if (globalAccountData.getId() != null &&
                          globalAccountData.getId() != "" &&
                          globalAccountData.getFingerPrint() != true) {
                        navigatorManager(context: context);
                      }
                    }
                  });
                },
                child: ListView(
                  children: [
                    80.height,
                    Lottie.asset(
                      "assets/images/requestJoin.json",
                      width: 350,
                      height: 300,
                      reverse: false,
                      repeat: false,
                      fit: BoxFit.cover,
                    ),
                    30.height,
                    Padding(
                      padding:   EdgeInsetsDirectional.symmetric(horizontal: 60,vertical: 40) ,
                      child: Text(
                        "waitingApprove".tr(namedArgs: {
                          'comName': (p_Listeneress<ConfigProvider>(context)
                                  .whatsData
                                  ?.name) ??
                              ""
                        }),
                        style: CustomTextStyle.bold16White.copyWith(
                            color: Colors.white,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        // if (model.hotline.isNotEmpty) {
                        //   launchUrl(Uri.parse("tel:/${model.hotline.first.hotlineNumber}"));
                        // }
                        openWhatsApp(
                            phoneNumber: p_Listeneress<ConfigProvider>(context)
                                .whatsData
                                ?.number);
                      },
                      child: isLoad
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text("connectCustomerSupport".tr(),
                                    style: CustomTextStyle.bold16White.copyWith(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                    ),
                    10.height,
                    GestureDetector(
                      onTap: () {

                        pushRoute(context: context, route: EditAccountbefourAccept());
                        // if (model.hotline.isNotEmpty) {
                        //   launchUrl(Uri.parse("tel:/${model.hotline.first.hotlineNumber}"));
                        // }
                        // openWhatsApp(
                        //     phoneNumber: p_Listeneress<ConfigProvider>(context)
                        //         .whatsData
                        //         ?.number);
                      },
                      child: isLoad
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text("EditAccount".tr(),
                              style: CustomTextStyle.bold16White.copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                    isLoad ? 50.height : 10.height,
                    GestureDetector(
                      onTap: () {
                        handleWillPopScopeRoot(context, true);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text("Logout".tr(),
                              style: CustomTextStyle.bold16White.copyWith(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                    140.height,
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }

  void openWhatsApp({required String? phoneNumber}) async {
    setState(() {
      isLoad = true;
    });
    //final phoneNumber = '+201029229338';
    final whatsappUrl = "https://wa.me/$phoneNumber";

    // if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
    setState(() {
      isLoad = false;
    });
    // } else {
    //   setState(() {
    //     isLoad = false;
    //   });
    //   throw 'Could not launch $whatsappUrl';
    // }
  }
}
