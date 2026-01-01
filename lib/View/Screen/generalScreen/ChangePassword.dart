import 'package:core_project/Utill/validator.dart';
import 'package:core_project/View/Screen/DashBoard/DashBoardSCreen.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../../Provider/RegisterProvider.dart';
import '../../../Utill/Comman.dart';
import '../../../Utill/LoaderWidget/loader_widget.dart';
import '../../../helper/ButtonAction.dart';
import '../../../helper/ImagesConstant.dart';
import '../../../helper/SnackBarScreen.dart';
import '../../../helper/color_resources.dart';
import '../../Widget/comman/CustomAppBar.dart';
import '../PartAuth/RegisterScreen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            title: 'changePassword'.tr(),
            backgroundImage: AssetImage(ImagesConstants.backgroundImage),
          ),
          body: Container(
              width: w(context),
              height: h(context),
              // color: BACKGROUNDCOLOR.withOpacity(0.7),
              child: SingleChildScrollView(
                child: Form(
                  key: _globalKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.height,
                        Container(
                          width: 220,
                          height: 48,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage(ImagesConstants.backGroundOrder),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "changePassword".tr(),
                            style: CustomTextStyle.bold14White,
                          )),
                        ),
                        17.height,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: w(context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.height,
                                textFormField(
                                    "oldPassword",
                                    oldPassword,
                                    Icon(
                                      Icons.lock_open_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    validation: (value) =>
                                        Validator.password(value)),
                                10.height,
                                textFormField(
                                    "newPassword",
                                    newPassword,
                                    Icon(
                                      Icons.lock_open_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    validation: (value) =>
                                        Validator.password(value)),
                                10.height,
                                textFormField(
                                    "confirmPassword",
                                    confirmPassword,
                                    Icon(
                                      Icons.lock_open_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    validation: (value) =>
                                        Validator.password(value)),
                                10.height,
                              ],
                            ),
                          ),
                        ),
                        10.height,
                        widgetWithAction.buttonAction<RegisterProvider>(
                            action: (model) {
                              if (_globalKey.currentState!.validate()) {
                                if (newPassword.text != confirmPassword.text) {
                                  showAwesomeSnackbar(context, 'On Snap!', '${tr("error_wrong_password_confirm")}', contentType: ContentType.help,);
                                } else {
                                  model.updatePassword(oldPassword: oldPassword.text, password: newPassword.text, context: context).then((value){
                                    if(value==true){
                                      pushRemoveUntilRoute(context: context, route: DashBoardScreen());
                                      successSnak(context, "requestSend");
                                    }
                                  });
                                }
                              }
                            },
                            context: context,text: "sendRequest")
                      ]),
                ),
              ))),
    );
  }
}

