import 'package:core_project/Model/CompoundModel.dart';
import 'package:core_project/Provider/RegisterProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/validator.dart';
import 'package:core_project/View/Screen/PartAuth/RegisterScreen.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:core_project/helper/ButtonAction.dart';
import 'package:nb_utils/nb_utils.dart';

class CheckCompoundCodeScreen extends StatefulWidget {
  @override
  State<CheckCompoundCodeScreen> createState() =>
      _CheckCompoundCodeScreenState();
}

class _CheckCompoundCodeScreenState extends State<CheckCompoundCodeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController comCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // background//color: BACKGROUNDCOLOR,
        appBar: CustomAppBar(
          title: 'createAccount'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "enterTheCompoundCode".tr(),
                    style: CustomTextStyle.semiBold12Black
                        .copyWith(fontSize: 10, color: Colors.black),
                  ),
                  10.height,
                  textFormField(
                      "compoundCode".tr(),
                      comCodeController,
                      Icon(
                        Icons.home,
                        color: Theme.of(context).primaryColor,
                      ),
                      validation: (value) => Validator.defaultValidator(value)),
                  10.height,
                  widgetWithAction.buttonAction<RegisterProvider>(
                      action: (model) {
                        if (_formKey.currentState!.validate()) {
                          model
                              .verifyCode(context, comCodeController.text)
                              .then((value) {
                            if (value != null)
                              pushRoute(
                                  context: context,
                                  route: RegisterScreen(
                                    compoundData: value,
                                  ));
                          });
                        }
                      },
                      context: context,
                      text: "Verify"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
