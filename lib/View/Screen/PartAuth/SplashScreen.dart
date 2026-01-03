import 'package:animate_do/animate_do.dart';
import 'package:core_project/Provider/LoginProvider.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/View/Screen/PartAuth/LoginScreen.dart';
import 'package:core_project/check_user_type.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import '../../../Provider/ConfigProvider.dart';
import '../../../Utill/Comman.dart';
import '../../../Utill/Notifications/notification.dart';
import '../../../helper/ImagesConstant.dart';
import '../../../helper/app_constants.dart';
import '../../../waiting_approve.dart';
import '../../Widget/comman/comman_Image.dart';
import '../blocked_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    /// support Notifications Dialogs
    Future.delayed(const Duration(seconds: 0), () async {
      await Provider.of<LoginProvider>(context, listen: false)
          .checkUserValidation(context);
    });
    getNextScreen();
    super.initState();
    appNotificationDialogFunctions(context);
  }

  getNextScreen() async {
    try {
      await globalAccountData.init();

      Provider.of<ConfigProvider>(context, listen: false)
          .refreshMyAccessibility(context)
          .then((value) {

        if (value == 'isBlocked' &&
            globalAccountData.getUserType() == AppConstants.IS_OWNER) {
          pushRemoveUntilRoute(context: context, route: BlockedScreen());
        } else if (value == 'isApprove' &&
            globalAccountData.getUserType() == AppConstants.IS_OWNER) {
          pushRemoveUntilRoute(context: context, route: WaitingApprove());
        } else {
          if (globalAccountData.getId() != null &&
              globalAccountData.getId() != "") {
            Future.delayed(const Duration(seconds: 0), () async {
              await Provider.of<LoginProvider>(context, listen: false)
                  .getCompoundData(context);
            });
          }
          if (globalAccountData.getId() != null &&
              globalAccountData.getId() != "" &&
              globalAccountData.getFingerPrint() != true) {
            navigatorManager(context: context);
          } else if (globalAccountData.getFingerPrint() == true) {
            Future.delayed(const Duration(seconds: 5), () async {
              return pushRemoveUntilRoute(
                context: context,
                route: LoginScreen(),
              );
            });
          } else {
            if (globalAccountData.getUserType() == AppConstants.IS_OWNER) {
              Future.delayed(
                  const Duration(seconds: 2),
                  () => pushRemoveUntilRoute(
                        context: context,
                        //    route: onBoardingScreen(),
                        route: LoginScreen(),
                      ));
            } else {
              pushRemoveUntilRoute(
                context: context,
                route: LoginScreen(),
              );
            }
          }
        }
      });
    } on Exception catch (e) {
      print("**********************");
      pushRemoveUntilRoute(
        context: context,
        route: LoginScreen(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Stack(
        children: <Widget>[
          cachedImage(
            "assets/images/splashScreen.png",
            width: w(context),
            height: h(context),
            fit: BoxFit.cover,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInLeft(
                  child: cachedImage(
                    "assets/images/logo_2.png",
                    width: 80,
                    height: 70,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                ),
                FadeInDown(
                  child: cachedImage(
                    "assets/images/logo_3.png",
                    width: 60,
                    height: 70,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                ),
                FadeInRight(
                  child: cachedImage(
                    "assets/images/logo_1.png",
                    width: 90,
                    height: 90,
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
           FadeInUp(
             duration: const Duration(seconds: 2),
             child: Align(
              alignment: Alignment(0, 1.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  cachedImage(
                    "assets/images/company.png",
                    width: 80,
                    height: 120, color: Colors.white
                  ),
                  Text("Powered By",style:  CustomTextStyle.semiBold12Black
                      .copyWith(fontSize: 11,  color: Colors.white),),
                ],
              ),
                       ),
           ),
        ],
      )

    );
  }
}

class EnglishUpgradeMessages extends UpgraderMessages {
  /// Override the message function to provide custom language localization.
  @override
  String message(UpgraderMessage messageKey) {
    if (languageCode == 'en') {
      switch (messageKey) {
        case UpgraderMessage.body:
          return 'A new version of {{appName}} is available!';
        case UpgraderMessage.buttonTitleIgnore:
          return 'Ignore';
        case UpgraderMessage.buttonTitleLater:
          return 'Later';
        case UpgraderMessage.buttonTitleUpdate:
          return 'Update Now';
        case UpgraderMessage.prompt:
          return 'Do you Want to update?';
        case UpgraderMessage.releaseNotes:
          return 'Release Notes';
        case UpgraderMessage.title:
          return 'Update App?';
        default:
          return super.message(messageKey)!;
      }
    }
    // Messages that are not provided above can still use the default values.
    return super.message(messageKey)!;
  }
}
