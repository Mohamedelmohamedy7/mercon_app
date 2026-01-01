import 'package:core_project/Provider/ConfigProvider.dart';
import 'package:core_project/Provider/HomeProvider.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/PartAuth/edit_account_befour_accept.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/dashboard_super_admin.dart';
import 'package:core_project/check_user_type.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/waiting_approve.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utill/Comman.dart';
import '../../Utill/Local_User_Data.dart';
import '../../helper/EnumLoading.dart';
import '../../helper/app_constants.dart';
import '../../helper/text_style.dart';
import 'DashBoard/DashBoardSCreen.dart';
import 'DashBoard/ActionsScreen.dart';
import 'dash_board_security.dart';

class BlockedScreen extends StatefulWidget {
  const BlockedScreen({Key? key}) : super(key: key);

  @override
  _BlockedScreenState createState() => _BlockedScreenState();
}

class _BlockedScreenState extends State<BlockedScreen> {
  bool isLoad = false;
  @override
  void initState() {
    catchError(p_Listeneress<ConfigProvider>(context).getHotlineNumber(context),
        'loadConfigData');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          alignment: Alignment.center,
          //color: BACKGROUNDCOLOR,
          child: RefreshIndicator(
            // backgroundColor: Colors.white,
            color: Theme.of(context).primaryColor,
            onRefresh: () async {
              Provider.of<ConfigProvider>(context, listen: false)
                  .refreshMyAccessibility(context)
                  .then((value) {
                if (value == 'isBlocked') {
                } else if (value == 'isApprove') {
                  pushRemoveUntilRoute(
                      context: context, route: WaitingApprove());
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
                150.height,
                Lottie.asset(
                  "assets/images/blocked.json",
                  width: 230,
                  height: 230,
                  reverse: false,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "blockUser".tr(),
                    style: CustomTextStyle.bold16White.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                100.height,
                // Consumer<ConfigProvider>(builder: (context,model,_){
                //   if(model.status==LoadingStatus.LOADING){
                //     return Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         LoaderWidget(),
                //       ],
                //     );
                //   }else{
                //   return  ;
                //   }
                // }),
                GestureDetector(
                  onTap: () {
                    // if (model.hotline.isNotEmpty) {
                    //   launchUrl(Uri.parse("tel:/${model.hotline.first.hotlineNumber}"));
                    // }
                    openWhatsApp();
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
                    pushRoute(
                        context: context, route: EditAccountbefourAccept());
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
                10.height,
                Consumer<ConfigProvider>(builder: (context, model, _) {
                  if (model.status == LoadingStatus.LOADING) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoaderWidget(),
                      ],
                    );
                  } else {
                    return GestureDetector(
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
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openWhatsApp() async {
    setState(() {
      isLoad = true;
    });
    final phoneNumber = '+201029229338';
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
