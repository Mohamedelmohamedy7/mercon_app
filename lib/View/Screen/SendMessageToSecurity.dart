import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../Provider/VisitorProvider.dart';
import '../../Utill/AnimationWidget.dart';
import '../../Utill/Comman.dart';
import '../../Utill/LoaderWidget/loader_widget.dart';
import '../../Utill/validator.dart';
import '../../helper/EnumLoading.dart';
import '../../helper/ImagesConstant.dart';
import '../../helper/SnackBarScreen.dart';
import '../../helper/color_resources.dart';
import '../../helper/text_style.dart';
import '../Widget/comman/CustomAppBar.dart';

class SendMessageToSecurity extends StatefulWidget {
  const SendMessageToSecurity({Key? key}) : super(key: key);

  @override
  State<SendMessageToSecurity> createState() => _SendMessageToSecurityState();
}

class _SendMessageToSecurityState extends State<SendMessageToSecurity> {
  TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            title: 'sendMessageToSecurity'.tr(),
            backgroundImage: AssetImage(ImagesConstants.backgroundImage),
          ),
          body: Container(
              //color: BACKGROUNDCOLOR,
              child: CustomAnimatedWidget(
                  child: Form(
                    key: _globalKey,
                    child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color:
                          Theme.of(context).primaryColor
                          )),
                      child: textFormField(
                          "sendMessageToSecurity",
                          messageController,
                          textFieldSvg("message.svg"),
                          maxLines: 6,
                          validation: (value) => Validator.defaultValidator(value),
                          autoFoucs: true),
                    ),
                ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child:  Consumer<VisitorProvider>(
                          builder: (context, model, _) {
                            if (model.status == LoadingStatus.LOADING) {
                              return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [LoaderWidget()]);
                            } else {
                              return InkWell(
                                onTap: () {
                                  if (_globalKey.currentState!.validate()) {
                                     model.sendMessageToSecurity(messageController.text, context).then((value){
                                       if (value["message"]=="Notifcation Sent") {
                                         showAwesomeSnackbar(context, 'Success!',
                                           '${value["message"]}', contentType: ContentType.success,);
                                         messageController.clear();
                                         setState(() {});
                                       }
                                     });
                                  }
                                }  ,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  width: w(context),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: lightGray,
                                         offset: Offset(0.0, 2.0),
                                         blurRadius: 4.0, // Specify the blur radius
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                      child: Text(
                                        "sendRequest".tr(),
                                        style: CustomTextStyle.semiBold12Black,
                                      )),
                                ),
                              );
                            }
                          },
                        ),
                      )
              ]),
                  )))),
    );
  }
}
