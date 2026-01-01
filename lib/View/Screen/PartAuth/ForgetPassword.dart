import 'package:core_project/Provider/LoginProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Provider/RegisterProvider.dart';
import '../../../Utill/validator.dart';
import '../../../helper/ButtonAction.dart';
import '../../../helper/ImagesConstant.dart';
import '../../../helper/text_style.dart';
import '../../Widget/comman/CustomAppBar.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool successSend = false;
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'resetPassord'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Container(
          width: double.infinity,

          child: Form(
            key: _formKey,
            child: successSend
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      110.height,
                      Lottie.asset("assets/images/password.json",
                          width: 250, height: 250),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "sendGmail".tr(),
                          style: CustomTextStyle.semiBold12Black
                              .copyWith(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      20.height,
                      widgetWithAction.buttonAction<RegisterProvider>(
                          action: (model) {
                            launch("https://mail.google.com/mail/u/0/#inbox");
                          },
                          context: context,
                          text: "openApp"),
                    ],
                  )
                : ListView(
                     children: [
                      80.height,
                      Lottie.asset("assets/images/passowrd.json",
                          width: 250, height: 250),
                      20.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: textFormField(
                            "email", emailController, textFieldSvg("email.svg"),
                            validation: (value) => Validator.email(value)),
                      ),
                      30.height,
                      widgetWithAction.buttonAction<LoginProvider>(
                          action: (model) {
                            if (_formKey.currentState!.validate()) {
                              model.resetPassword(
                                context,
                                email: emailController.text,
                              ).then((value) {

                                successSend = value;
                                setState(() {});
                              });
                            }
                          },
                          context: context,
                          text: "sendRequest"),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
