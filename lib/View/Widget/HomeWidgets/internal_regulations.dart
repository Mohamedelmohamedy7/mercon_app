import 'package:core_project/helper/text_style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Provider/HomeProvider.dart';
import '../../../Utill/Comman.dart';
import '../../Screen/DashBoard/RegulationScreen.dart';

class InternalRegulations extends StatelessWidget {
  final HomeProvider home_provider;

  InternalRegulations({super.key, required this.home_provider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushRoute(context: context, route: RegulationScreen(internalRegulationsText: home_provider.regulationResponse?.internalRegulation??""));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(5.0),
          child: Row(
            children: [
               SvgPicture.asset(
                "assets/images/book.svg",
                width: 20,
                height: 20,
                color: Theme.of(context).primaryColor,
              ),
              10.width,
              Text(
                'internalRegulation'.tr(),
                style: CustomTextStyle.bold16White.copyWith(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColor,
                size: 15,
              ),
             ],
          ),
        ),
      ),
    );
  }
}
