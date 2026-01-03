import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../Provider/HomeProvider.dart';
import '../../../Utill/Comman.dart';
import '../../../helper/text_style.dart';
import '../../Screen/DashBoard/RegulationScreen.dart';
import '../../Screen/DashBoard/delivery_service.dart';

class DeliveryCard extends StatelessWidget {
  final HomeProvider home_provider;

  DeliveryCard({super.key, required this.home_provider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushRoute(context: context, route: DeliveryService());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(5.0),
          child: Row(
            children: [
              5.width,
              Lottie.asset("assets/images/delivery.json",width: 100,height:110),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'deliveryServices'.tr(),
                    style: CustomTextStyle.bold16White.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    width:MediaQuery.of(context).size.width*0.6,
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'MenuFood'.tr(),
                      style: CustomTextStyle.bold16White.copyWith(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),


              SizedBox(width: 10,)
            ],
          ),
        ),
      ),
    );
  }

}
