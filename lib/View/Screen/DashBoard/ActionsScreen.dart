import 'dart:io';

import 'package:core_project/Provider/ConfigProvider.dart';
import 'package:core_project/Provider/LoginProvider.dart';
import 'package:core_project/View/Screen/AllComplsinsScreen.dart';
import 'package:core_project/View/Screen/ComplainScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ChairRequest/ChairRequestsListScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ChairRequest/CreateOrUpdateChairRequestScreen.dart';
import 'package:core_project/View/Screen/generalScreen/my_account.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/Route_Manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../../Utill/AnimationWidget.dart';
import '../../../Utill/Comman.dart';

import '../../../Utill/Local_User_Data.dart';
import '../../../helper/ImagesConstant.dart';
import '../../../helper/SnackBarScreen.dart';
import '../../../helper/color_resources.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../Widget/comman/CustomAppBar.dart';
import '../PartAuth/edit_account.dart';
import '../SendMessageToSecurity.dart';
import '../complaintsand_suggestions.dart';
import '../generalScreen/ChangePassword.dart';
import '../generalScreen/GuestAccess.dart';
import '../generalScreen/LanguageScreen.dart';
import '../PartAuth/LoginScreen.dart';
import '../generalScreen/sendInvitetion.dart';
import '../units_owner.dart';

class ActionsScreen extends StatefulWidget {
  const ActionsScreen({Key? key}) : super(key: key);

  @override
  State<ActionsScreen> createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen>
    with SingleTickerProviderStateMixin {
  bool switchValue = false;
  final LocalAuthentication auth = LocalAuthentication();
  late bool canCheckBiometrics;
  _SupportState supportState = _SupportState.unknown;

  Future checkBiometrics() async {
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      print(canCheckBiometrics);
      return canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    _getStatusSwitch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        needBack: false,
        title: 'personAccount'.tr(),
        backgroundImage: AssetImage(ImagesConstants.backgroundImage),
      ),
      body: Container(
        //color: BACKGROUNDCOLOR,
        child: CustomAnimatedWidget(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    6.width,
                    Container(
                         decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 0.4),
                        ),
                        child: ClipRRect(  borderRadius: BorderRadius.circular(10),child: cachedImage(globalAccountData.getProfilePic()??"", height: 60, width: 60,fit: BoxFit.cover,))),
                    10.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(globalAccountData.getUsername() ?? "",
                            style: CustomTextStyle.semiBold14Black
                                .copyWith(height: 1.4)),
                        Text(globalAccountData.getEmail() ?? "",
                            style: CustomTextStyle.regular14Black
                                .copyWith(height: 1.4)),
                        Text(
                            globalAccountData.getPhoneNumber()! + "(02+)" ?? "",
                            style: CustomTextStyle.regular14Black
                                .copyWith(height: 1.7)),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          pushRoute(context: context, route: EditAccount());
                        },
                        icon: SvgPicture.asset(
                          "assets/images/edit.svg",
                          color: Theme.of(context).primaryColor,
                        )),
                  ],
                ),
              ),
              15.height,
              containerNotification(
                  context,
                  "language",
                  textFieldSvg("langouage.svg"),
                  () => pushRoute(
                      context: context, route: const LanguageScreen())),
              10.height,
              widgetScreens(
                  onTap: () {},
                  text: "fingerPrint".tr(),
                  image: Icon(
                    Icons.fingerprint_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 26,
                  ),
                  context: context),
              5.height,
              Container(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                height: 1,
                width: w(context),
              ),
              20.height,
              containerNotification(
                  context,
                  "personAccount",
                  textFieldSvg("person.svg"),
                  () => pushRoute(context: context, route: const MyAccount())),
              20.height,
              containerNotification(
                  context,
                  "changePassword",
                  textFieldSvg("lock.svg"),
                  () => pushRoute(
                      context: context, route: const ChangePassword())),
              20.height,
              containerNotification(
                  context,
                  "Complaints_and_Suggestions",
                  textFieldSvg("message.svg"),
                      () => pushRoute(
                      context: context, route: AllComplaintsScreen(needBack: true,)// ComplaintFormScreen(needBack: true,),
              )),
              20.height,
              containerNotification(
                  context,
                  "guestAccess",
                  textFieldSvg("guest.svg"),
                  () =>
                      pushRoute(context: context, route: const GuestAccess())),
              20.height,
              containerNotification(
                  context,
                  "sendMessageToSecurity",
                  textFieldSvg("message.svg"),
                  () => pushRoute(
                      context: context, route: const SendMessageToSecurity())),


              20.height,
              containerNotification(
                  context,
                  "chairRequest",
                  Icon(Icons.chair_outlined,color: Theme.of(context).primaryColor,),
                      () => pushRoute(
                      context: context, route:  ChairRequestsListScreen(needBack: true,admin: false,))),

              20.height,
              containerNotification(
                  context,
                  "invitationrequest",
                  textFieldSvg("invite.svg"),
                  () => pushRoute(
                      context: context, route: const sendInvitetion())),
              20.height,
              containerNotification(
                  context,
                  "Ownedunits",
                  textFieldSvg("compound.svg"),
                  () => pushRoute(context: context, route: const UnitsOwner())),
              20.height,
              //  containerNotification(
              //     context,
              //     "Complaints_and_Suggestions",
              //     textFieldSvg("message.svg"),
              //         () => pushRoute(
              //         context: context, route: const ComplaintsandSuggestions())),
              // 20.height,

              Provider.of<ConfigProvider>(
                context,
              ).hotline.length >
                  1
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  containerNotification(context, "hotlineNumber",
                      textFieldSvg("hotline.svg"), () {}),
                  10.height,
                  Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: Provider.of<ConfigProvider>(context,
                          listen: false)
                          .hotline
                          .map((e) {
                        return GestureDetector(
                          onTap: () {
                            launch("tel:/${e.hotlineNumber}");
                          },
                          child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 5),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: lightGray,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 3.0,
                                  ),
                                ],
                                color: white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  e.hotlineNumber,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        );
                      }).toList()),
                ],
              )
                  : containerNotification(
                  context, "hotlineNumber", textFieldSvg("hotline.svg"),
                      () {
                    launch(
                        "tel:/${Provider.of<ConfigProvider>(context, listen: false).hotline[0].hotlineNumber}");
                  }),

              20.height,
              containerNotification(context, "deleteAccount", Icon(Icons.delete_outline_sharp,color:Color(0xFF695c4c).withOpacity(0.8)),
                  () {
                  handleWillPopScopeRootDelete(context,true);
                  }),
              20.height,
              containerNotification(
                  context, "Logout", textFieldSvg("logout.svg"), () {
                handleWillPopScopeRoot(context, true);
              }),
              20.height,
            ],
          ),
        ),
      ),
    ));
  }

  InkWell widgetScreens(
      {required onTap,
      required Widget image,
      required String text,
      required BuildContext context}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        title: Row(
          children: [
            image,
            10.width,
            Text(
              text,
              style: context.locale == Locale("ar", "EG")
                  ? CustomTextStyle.semiBold12Black
                  : CustomTextStyle.semiBold12Black,
            ),
          ],
        ),
        trailing: text == "fingerPrint".tr()
            ? Switch(
                activeColor: Theme.of(context).primaryColor,
                value: switchValue,
                onChanged: (val) async {
                  if (supportState == _SupportState.supported) {
                    print(val);
                    globalAccountData.setFingerAvalible(val);
                    setState(() {
                      switchValue = val;
                    });
                  } else {
                    globalAccountData.setFingerAvalible(false);
                    showAwesomeSnackbar(
                      context,
                      'On Snap!',
                      'your device not Supported !',
                      contentType: ContentType.failure,
                    );
                  }
                })
            : const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
      ),
    );
  }

  _getStatusSwitch() {
    setState(() {
      switchValue = globalAccountData.getFingerPrint() ?? false;
    });
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

InkWell containerNotification(
  context,
  title,
  Widget image,
  Function function,
) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            image,
            const SizedBox(
              width: 10,
            ),
            Text(
              "$title".tr(),
              style:  CustomTextStyle.regular14Gray.copyWith(color: Colors.black,fontSize: 14),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).primaryColor,
              size: 14,
            ),
          ],
        ),
      ),
    ),
  );
}

CustomDialogWidgetWithActions({
  required BuildContext context,
  required String title,
  required String subtitle,
  bool isThereYesAndNo = true,
  required VoidCallback onYesTap,
// ignore: dead_code
}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      width: MediaQuery.of(context).size.width,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WidgetAnimator(
            atRestEffect: WidgetRestingEffects.wave(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24), color: white),
                    child: Container(
                      padding: const EdgeInsetsDirectional.only(
                          start: 16, end: 16, top: 20, bottom: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: CustomTextStyle.bold14black,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            subtitle,
                            style: CustomTextStyle.regular12Black,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          isThereYesAndNo
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        child: Text(
                                          "no".tr(),
                                          style: CustomTextStyle.medium10Gray
                                              .copyWith(color: white),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: onYesTap,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                top: 6, bottom: 6),
                                        decoration: BoxDecoration(
                                            // color: Theme.of(context).accentColor,
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        child: Text(
                                          "yes".tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                                //  color: CREAM
                                              ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: onYesTap,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                top: 6, bottom: 6),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        child: Text(
                                          "ok".tr(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

handleWillPopScopeRoot(context, bool isLogout) {
  return showDialog(
      context: context,

       builder: (dialogContext) => CustomDialogWidgetWithActions(
          context: dialogContext,
          title: "ensureExit".tr(),
          onYesTap: () {
            if (isLogout) {
              Provider.of<LoginProvider>(context, listen: false)
                  .logout(context)
                  .then((value) async {
                if (value != null) {
                  await globalAccountData.clearSharedPreferencesForLogOut();
                  Provider.of<LoginProvider>(context, listen: false)
                      .showNavBar(false);
                  pushNamedAndRemoveUntilRoute(
                      context: context, route: Routes.loginRoute);
                }
              });
            } else {
              exit(0);
            }
          },
          subtitle: "ensureExitSubtitle".tr()));
}
handleWillPopScopeRootDelete(context, bool isLogout) {
  return showDialog(
      context: context,

      builder: (dialogContext) => CustomDialogWidgetWithActions(
          context: dialogContext,
          title: "ensureDelete".tr(),
          onYesTap: () {
            if (isLogout) {
              Provider.of<LoginProvider>(context, listen: false)
                  .deleteAccount(context)
                  .then((value) async {
                if (value != null) {
                  await globalAccountData.clearSharedPreferencesForLogOut();
                  Provider.of<LoginProvider>(context, listen: false)
                      .showNavBar(false);
                  pushNamedAndRemoveUntilRoute(
                      context: context, route: Routes.loginRoute);
                }
              });
            } else {
              exit(0);
            }
          },
          subtitle: "ensureDeleteSubtitle".tr()));
}
