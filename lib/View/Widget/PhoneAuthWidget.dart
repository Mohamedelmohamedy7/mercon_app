import 'dart:async';

import 'package:core_project/Model/user_info_model.dart';
import 'package:core_project/Provider/LoginProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/dashboard_super_admin.dart';
import 'package:core_project/View/Screen/blocked_screen.dart';
import 'package:core_project/check_user_type.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import '../../Utill/LoaderWidget/loader_widget.dart';
import '../../Utill/validator.dart';
import '../../helper/Route_Manager.dart';
import '../../helper/app_constants.dart';
import '../../waiting_approve.dart';
import '../Screen/DashBoard/DashBoardSCreen.dart';
import '../Screen/PartAuth/ForgetPassword.dart';
import '../Screen/dash_board_security.dart';

class PhoneAuthWidget extends StatefulWidget {
  const PhoneAuthWidget({Key? key}) : super(key: key);

  @override
  State<PhoneAuthWidget> createState() => _PhoneAuthWidgetState();
}

class _PhoneAuthWidgetState extends State<PhoneAuthWidget> {
  bool showPasswordAndEmail = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool rememberMe = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool timerNeeded = false;
  Timer? _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timerNeeded = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _authenticateWithBiometrics() async {
    if (timerNeeded == true) {
    } else {
      bool authenticated = false;
      try {
        setState(() {});
        authenticated = await auth.authenticate(
          authMessages: [],
          localizedReason:
              'Scan your fingerprint to authenticate and Enter to Application',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
        if (authenticated == true) {
          Navigator.pushReplacementNamed(context, Routes.dashBoard);
        }
        setState(() {});
      } on PlatformException catch (e) {
        print(e);
        if (e.code == auth_error.biometricOnlyNotSupported) {
        } else {
          startTimer();
          setState(() {
            timerNeeded = true;
          });
        }
        return;
      }
      if (!mounted) {
        return;
      }

      final String message = authenticated ? 'Authorized' : 'Not Authorized';
      setState(() {});
    }
  }

  final GlobalKey<FormFieldState> _emailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _globalKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: [
                  // Email Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6EFE7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          key: _emailKey,
                          controller: emailController,
                          decoration: InputDecoration(
                            // errorStyle: null,
                            hintText: "email".tr(),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            errorMaxLines: 1,
                            errorText: '',
                            errorStyle: TextStyle(
                              color: Colors.transparent,
                              fontSize: 0,
                            ),
                          ),
                          validator: (value) => Validator.email(value),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Builder(
                        builder: (context) {
                          final errorText = _emailKey.currentState?.errorText;
                          return errorText != null
                              ? Text(
                                  errorText,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                  10.height,

                  // Password Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6EFE7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(

                          cursorColor: Colors.black,

                          key: _passwordKey,
                          controller: passwordController,
                          decoration: InputDecoration(

                            hintText: "password".tr(),
                            border: InputBorder.none,
                            suffixIcon: textFieldSvg("lock.svg"),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            errorMaxLines: 1,
                            errorText: '',
                            errorStyle: TextStyle(
                              color: Colors.transparent,
                              fontSize: 0,
                            ),
                          ),
                          validator: (value) => Validator.password(value),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Builder(
                        builder: (context) {
                          final errorText =
                              _passwordKey.currentState?.errorText;
                          return errorText != null
                              ? Text(
                                  errorText,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 12),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: rememberMe,
                  checkColor: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value ?? false;
                    });
                  },
                ),
                Text('rememberMe'.tr()),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    pushRoute(context: context, route: ForgetPassword());
                  },
                  child: Text(
                    "forgetPassword".tr(),
                    style:
                        CustomTextStyle.semiBold12Black.copyWith(fontSize: 11),
                  ),
                ),
                10.width,
              ],
            ),
          ),
          20.height,
          timerNeeded == true
              ? Text(
                  "you enter the fingerPrint false 5 times \n you can try again after $_start sec",
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.medium10Gray.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                      fontSize: 12),
                )
              : Consumer<LoginProvider>(
                  builder: (context, model, _) => GestureDetector(
                    onTap: () {
                      setState(() {});
                      if (_globalKey.currentState!.validate()) {
                        model
                            .login(context,
                                email: emailController.text,
                                password: passwordController.text,
                                type: "UintOwner")
                            // type: globalAccountData.getUserType().toString() == "0" ? "UintOwner" : "SecurityOfficer")
                            .then((value) async {
                          if (value != null) {
                            if (rememberMe == true) {
                              await saveUserData(value);
                            } else {
                              await globalAccountData
                                  .setId(value.id.toString());
                              await globalAccountData.SetExpiredTime(
                                  value.expiresIn.toString());
                              await globalAccountData.SetRefreshToken(
                                  value.refreshToken.toString());
                              await globalAccountData.SetAccessToken(
                                  value.accessToken.toString());
                              await globalAccountData
                                  .setUsername(value.fName ?? "");
                              await globalAccountData.setEmail(value.email!);
                              await globalAccountData
                                  .setPhoneNumber(value.phone!);
                              await globalAccountData
                                  .setOwnerUserId(value.ownerUserId.toString());
                              await globalAccountData.setLoginInState(false);
                              await globalAccountData
                                  .setUserType(value.roleType);
                            }
                            model.getCompoundData(context);
                            await globalAccountData.init().then((_) {
                              if (globalAccountData.getUserType() ==
                                  AppConstants.IS_OWNER) {
                                if (value.isBlocked == true) {
                                  return pushRemoveUntilRoute(
                                    context: context,
                                    route: BlockedScreen(),
                                  );
                                } else if (value.isApprove == false ||
                                    value.isApprove == null) {
                                  return pushRemoveUntilRoute(
                                    context: context,
                                    route: WaitingApprove(),
                                  );
                                } else {
                                  return pushRemoveUntilRoute(
                                    context: context,
                                    route: DashBoardScreen(),
                                  );
                                }
                              }
                              navigatorManager(context: context);
                            });
                          }
                        });
                      } else {}
                    },
                    child: model.status == LoadingStatus.LOADING
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const LoaderWidget(),
                            ],
                          )
                        : Container(
                            height: 55,
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 70,
                                    height: 49,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle),
                                    child: SizedBox()),
                                Text(
                                  "login".tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontFamily: "NewFonts",
                                          fontSize: 15,
                                          color: WHITE),
                                ),
                                globalAccountData.getFingerPrint() == true
                                    ? GestureDetector(
                                        onTap: _authenticateWithBiometrics,
                                        child: Container(
                                          width: 55,
                                          height: 55,
                                          margin: EdgeInsetsDirectional.only(
                                              start: 10, end: 0),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadiusDirectional.only(
                                                      topEnd:
                                                          Radius.circular(13),
                                                      bottomEnd:
                                                          Radius.circular(13))),
                                          child: Center(
                                            child: Icon(
                                              Icons.fingerprint_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 70,
                                        height: 49,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            shape: BoxShape.circle),
                                        child: SizedBox()),
                              ],
                            ),
                          ),
                  ),
                ),
        ],
      ),
    );
  }
}
