 


import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';


class CustomDialog extends StatelessWidget {
  VoidCallback onTabConfirm;
  VoidCallback onTabCancel;
  bool isThereCancelButton;
  String icon, title, subtitle, confirmText;
  Widget ? dataWidget;
  double height;
  CustomDialog({super.key,
    required this.icon,
     required this.onTabConfirm,
     required this.onTabCancel,
     required this.title,
    this.dataWidget,
     required this.height,
     required this.confirmText,
    this.isThereCancelButton = true,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      // backgroundColor:Colors.black.withOpacity(0.1),
      child: StatefulBuilder(builder: (context, StateSetter setState) {
        return WidgetAnimator(
          atRestEffect: WidgetRestingEffects.wave(),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24), color: white),
              child: Container(
                padding: const EdgeInsetsDirectional.only(
                    start: 16, end: 16, top: 20, bottom: 20),
                child:  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Column(
                      mainAxisAlignment: dataWidget !=null ?
                      MainAxisAlignment.start:
                      MainAxisAlignment.center,
                      children: [
                      Image.asset(ImagesConstants.logo,width: 150,height: 150,),
                        dataWidget ??  Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 34),
                                child: Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyle.medium10Gray,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            if (subtitle != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 34),
                                child: Text(
                                  subtitle,
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyle.medium10Gray,
                                ),
                              ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: onTabConfirm,
                              child: Container(
                                height: 40,
                                margin: const EdgeInsets.symmetric(horizontal:20),
                                alignment: Alignment.center,
                                // width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                decoration: BoxDecoration(

                                  color:Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                child: Text(
                                  confirmText,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style:CustomTextStyle.medium10Gray,
                                ),
                              ),
                            ),
                          ),
                          if (isThereCancelButton)
                            Expanded(
                              child: InkWell(
                                onTap: onTabCancel,
                                child: Container(
                                  alignment: Alignment.center,
                                  // width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  margin: const EdgeInsets.symmetric(horizontal:20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    // width: MediaQuery.of(context).size.width,

                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 16),
                                    decoration: BoxDecoration(
                                      color:white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),

                                    child:   Text(
                                      tr("no"),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style:CustomTextStyle.medium10Gray,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      }),
    );
  }
}
