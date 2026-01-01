import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import 'package:flutter/foundation.dart';

 import '../../../helper/ImagesConstant.dart';
import '../../Widget/comman/CustomAppBar.dart';


class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool isCheckedEng = false;
  bool isCheckedArabic = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(EasyLocalization.of(context)?.currentLocale?.languageCode=='ar'){
        setState(() {
          isCheckedArabic = true;
        });
      }else{
        setState(() {
          isCheckedEng = true;
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'selectLanguage'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Container(
          //color: BACKGROUNDCOLOR,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "selectLanguage".tr(),
                      style: CustomTextStyle.semiBold14Black,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  MSHCheckbox(
                    size: 20,
                    value: isCheckedArabic,
                    checkedColor:Theme.of(context).primaryColor,
                    style: MSHCheckboxStyle.fillScaleColor,
                    onChanged: (selected) {

                        setState(() {
                          isCheckedArabic = true;
                          isCheckedEng = false;
                          context.locale = const Locale('ar', 'EG');
                        });

                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Arabic".tr(),
                    style: CustomTextStyle.semiBold14Black,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  MSHCheckbox(
                      size: 20,
                      value: isCheckedEng,
                      checkedColor:Theme.of(context).primaryColor,
                      style: MSHCheckboxStyle.fillScaleColor,
                      onChanged: (selected) {
                        setState(() {
                          isCheckedEng = true;
                          isCheckedArabic = false;
                          context.locale = const Locale('en', 'US');

                        });
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "English".tr(),
                    style: CustomTextStyle.semiBold14Black,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
