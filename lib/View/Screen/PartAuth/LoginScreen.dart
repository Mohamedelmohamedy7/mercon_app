// ignore: must_be_immutable
import 'package:core_project/Utill/AnimationWidget.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/View/Screen/PartAuth/CheckCompoundCodeScreen.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';

import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Widget/PhoneAuthWidget.dart';
import '../../Widget/comman/CustomAppBar.dart';
import 'RegisterScreen.dart';
import 'RegisterScreenSub.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
  //      resizeToAvoidBottomInset: false,
        // appBar: CustomAppBar(
        //   title: 'login'.tr(),
        //   needBack: false,
        //   backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        // ),
        body:  CustomAnimatedWidget(
          child: Container(
            //color: BACKGROUNDCOLOR,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                45.height,
                // languageToggleButton(context),
                25.height,
                Column(
                  children: [
                    10.height,
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        padding:   EdgeInsetsDirectional.only(start: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:   EdgeInsetsDirectional.only(start: 10),
                              child: Text("Welcome".tr(),style:
                              CustomTextStyle.bold14black.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 26,
                              ),),
                            ),
                            Image.asset(
                              ImagesConstants.logo,
                              color: Theme.of(context).primaryColor,
                              width: 300,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const PhoneAuthWidget(),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "don't have an account".tr(),
                            style: CustomTextStyle.regular14Gray.copyWith(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isDismissible: false,
                                isScrollControlled: true,
                                builder: (context) => StatefulBuilder(
                                  builder: (context, state) =>
                                      Container(
                                        color: Colors.white,
                                        height: MediaQuery.of(context)
                                            .size
                                            .height,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 60,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "selectLanguage".tr() +
                                                      " : ",
                                                  style: CustomTextStyle
                                                      .semiBold14Black,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                ToggleButtons(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  disabledColor:
                                                  Colors.transparent,
                                                  highlightColor:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  fillColor:
                                                  Theme.of(context)
                                                      .primaryColor,
                                                  // splashColor:
                                                  // BACKGROUNDCOLOR,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      30),
                                                  borderWidth: 0,
                                                  selectedColor:
                                                  Colors.white,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal:
                                                          20),
                                                      child: Text("EN"),
                                                    ),
                                                    Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            20),
                                                        child: Text("AR")),
                                                  ],
                                                  onPressed: (int index) {
                                                    if (index == 0) {
                                                      context.locale =
                                                      const Locale(
                                                          'en', 'US');
                                                    } else {
                                                      context.locale =
                                                      const Locale(
                                                          'ar', 'EG');
                                                    }
                                                  },
                                                  isSelected: [
                                                    context.locale ==
                                                        const Locale(
                                                            "en", "US"),
                                                    context.locale !=
                                                        const Locale(
                                                            "en", "US")
                                                  ],
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets.all(8),
                                                    decoration:
                                                    BoxDecoration(
                                                        shape: BoxShape
                                                            .circle,
                                                        color: Colors
                                                            .white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Theme.of(
                                                                context)
                                                                .primaryColor
                                                                .withOpacity(
                                                                0.2),
                                                            spreadRadius: 5,
                                                            blurRadius: 7,
                                                            offset: const Offset(
                                                                0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ]),
                                                    child: Center(
                                                        child: Icon(
                                                          Icons.close,
                                                          color:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                          size: 23,
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Lottie.asset(
                                                "assets/images/register.json",
                                                height: 230,
                                                width: 250),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 25),
                                              child: Text(
                                                "selectTypeAccount".tr(),
                                                style: CustomTextStyle
                                                    .regular14Gray
                                                    .copyWith(
                                                    fontSize: 14,
                                                    color:
                                                    Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {

                                                pushRoute(
                                                    context: context,
                                                    route:
                                                    CheckCompoundCodeScreen());
                                              },
                                              child: Container(
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.9,
                                                height:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.3,
                                                decoration: BoxDecoration(
                                                  color:
                                                  Theme.of(context).primaryColor.withOpacity(0.1),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      15),
                                                ),
                                                child:
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                  Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      cachedImage(
                                                          "assets/images/man.png",
                                                          height: 90,
                                                          width: 130,
                                                          fit: BoxFit
                                                              .contain),
                                                      Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                          Text(
                                                              "(${"Main Owner".tr()} )",
                                                              style: CustomTextStyle
                                                                  .regular14Gray
                                                                  .copyWith(
                                                                  fontSize:
                                                                  14,
                                                                  color:
                                                                  Colors.black)),
                                                          Text(
                                                              "(${"The Owner Named in the Contract".tr()})",
                                                              style: CustomTextStyle
                                                                  .regular14Gray
                                                                  .copyWith(
                                                                  fontSize:
                                                                  14,
                                                                  color:
                                                                  Colors.black)),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                pushRoute(
                                                    context: context,
                                                    route:
                                                    RegisterScreenSub());
                                              },
                                              child: Container(
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.9,
                                                height:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.3,
                                                decoration: BoxDecoration(
                                                  color:  Theme.of(context).primaryColor.withOpacity(0.1),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      15),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: cachedImage(
                                                            "assets/images/family.png",
                                                            height: 120,
                                                            width: 130,
                                                            fit: BoxFit
                                                                .contain)),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            "(${"Sub Owner".tr()})",
                                                            style: CustomTextStyle
                                                                .regular14Gray
                                                                .copyWith(
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .black),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          Text(
                                                            "(${"A Family Member of the Owner (wife - son - daughter)".tr()})",
                                                            style: CustomTextStyle
                                                                .regular14Gray
                                                                .copyWith(
                                                                fontSize:
                                                                14,
                                                                color: Colors
                                                                    .black),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                ));
                          },
                          child: Center(
                              child: Text(
                                "Register Now".tr(),
                                style: CustomTextStyle.regular14Gray.copyWith(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ],
                    ),
                    10.height,
                  ],
                ),
                100.height,


              ],
            ),
          ),
        ),

      ),
    );
  }

}
Widget languageToggleButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [

      SizedBox(width: 5,),
      Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),

        ),
        child: ToggleButtons(
          isSelected: [
            context.locale == Locale('ar', 'EG'),
            context.locale == Locale('en', 'US'),
          ],
          onPressed: (int index) {
            if (index == 0) {
              context.locale = Locale('ar', 'EG');
            } else {
              context.locale = Locale('en', 'US');
            }
          },
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                Image.asset('assets/images/eg.png', width: 17),
                SizedBox(width: 8),
                Text("AR", style: TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
                SizedBox(width: 10,),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 10,),
                Image.asset('assets/images/us.png', width: 17),
                SizedBox(width: 8),
                Text("EN", style: TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
                SizedBox(width: 10,),
              ],
            ),
          ],
          borderRadius: BorderRadius.circular(7),
          borderColor: Colors.grey.shade400,
          selectedColor: Colors.white,
          fillColor:Theme.of(context).primaryColor,
          color: Colors.black,
          selectedBorderColor: Colors.blueAccent,
        ),
      ),
    ],
  );
}