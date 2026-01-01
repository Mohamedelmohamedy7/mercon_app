import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../helper/text_style.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 230,
        child: Column(
          children: [
            Lottie.asset("assets/images/loader.json",width: 200, fit: BoxFit.cover),
             Text("dataissendpleasewait".tr(),style: CustomTextStyle.semiBold12Black
                .copyWith(fontSize: 12,fontWeight: FontWeight.w400),textAlign: TextAlign.center,)
          ],
        ));
  }
}
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(child: Lottie.asset("assets/images/loader.json",  fit: BoxFit.cover));
  }
}
