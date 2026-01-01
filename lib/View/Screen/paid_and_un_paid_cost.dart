import 'package:core_project/Model/PaymentModel.dart';
import 'package:core_project/Provider/ServicesProvider.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaidAndUnPaidCost extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
          border: Border.fromBorderSide(
        BorderSide(color: Colors.black, width: 0),
      )),
      child: Row(
        children: [
          Spacer(),
          Text("Total_payments".tr(),
              style: CustomTextStyle.regular14Black
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600)),
          Text(": ${Provider.of<ServicesProvider>(context).isPaidCost}",
              style: CustomTextStyle.regular14Black
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600)),
          Spacer(),
          Container(
            width: 1,
            decoration: BoxDecoration(color: Colors.black),
          ),
          Spacer(),
          Text("Total_non_payments".tr(),
              style: CustomTextStyle.regular14Black
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600)),
          Text(": ${Provider.of<ServicesProvider>(context).isNotPaidCost}",
              style: CustomTextStyle.regular14Black
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w600)),
          Spacer(),
        ],
      ),
    );
  }
}
