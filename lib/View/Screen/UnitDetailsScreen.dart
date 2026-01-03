import 'package:core_project/View/Screen/DashBoard/ActionsScreen.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Model/UnitPayments.dart';
import '../../Utill/Comman.dart';
import '../../generated/assets.dart';
import '../../helper/ImagesConstant.dart';
import '../../helper/date_converter.dart';
import '../../helper/text_style.dart';
import '../Widget/comman/CustomAppBar.dart';
import '../Widget/comman/comman_Image.dart';
import 'DashBoard/NotificationScreen.dart';

class UnitDetailsScreen extends StatefulWidget {
  final UnitPayments? unit;

  UnitDetailsScreen({super.key, this.unit});

  @override
  State<UnitDetailsScreen> createState() => _UnitDetailsScreenState();
}

class _UnitDetailsScreenState extends State<UnitDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        backgroundColor: BACKGROUNDCOLOR,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                5.height,
                Row(
                  children: [
                    cachedImage(ImagesConstants.logo, width: 110, height: 60),
                    Spacer(),
                    InkWell(child: Icon(Icons.close, color: Colors.white),onTap: (){
                      Navigator.pop(context);
                    },),
                    10.width,
                    InkWell(child:textFieldSvg("person.svg", color: Colors.white),onTap: (){
                     pushReplacementRoute(context: context, route: ActionsScreen());
                    },),

                    10.width,
                    InkWell(
                      onTap: (){
                        pushReplacementRoute(context: context, route: NotificationScreen(
                          adminScreen: false,needBack: true,
                        ));
                      },
                      child: Image.asset(
                        "assets/images/notification.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
                15.height,
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              "assets/images/compound.jpg",
                              width: 180,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // الظل الداخلي Gradient
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                             Theme.of(context).primaryColor
                                 .withOpacity(0.9),
                              Theme.of(context).primaryColor
                                 .withOpacity(0.2),
                              Colors.black.withOpacity(0.02),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            40.height,
                            // اسم الوحدة
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                widget.unit?.unitName ?? '',
                                style: CustomTextStyle.semiBold14Black.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            8.height,
                            // بيانات الدفع
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "totalPaid".tr() + " : ${widget.unit?.paidDone.toString()} EGP",
                                    style: CustomTextStyle.semiBold14Black.copyWith(
                                      color: Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "totalUnpaid".tr() + " : ${widget.unit?.notPaid.toString()} EGP",
                                    style: CustomTextStyle.semiBold14Black.copyWith(
                                      color: Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                10.height,
              ],
            ),
          ),
          15.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "owner_details".tr(),
              style: CustomTextStyle.semiBold12Black.copyWith(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          unitVal(),
          10.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "payments_details".tr(),
              style: CustomTextStyle.semiBold12Black.copyWith(
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ),
          10.height,
          Container(
            decoration: BoxDecoration(
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                5.height,
                Table(
                  border: TableBorder.all(
                    color: Colors.black,
                    width: 1,
                  ),

                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.6),
                            ),
                            child: Center(
                              child: Text(
                                "السنة",
                                style: CustomTextStyle.regular14Black.copyWith(
                                    color: Colors.black,fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.6),
                            ),
                            child: Center(
                              child: Text(
                                "حالة الدفع",
                                style: CustomTextStyle.regular14Black.copyWith(
                                    color: Colors.black,fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.6),
                            ),
                            child: Center(
                              child: Text(
                                'القيمة',
                                style: CustomTextStyle.regular14Black.copyWith(
                                    color: Colors.black,fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    for (var payment in widget.unit?.ownerPayments??[])...[
                      TableRow(
                        children: [
                          TableCell(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  DateConverter.isoStringToLocalDateOnly(payment.createdDate.toString()),
                                  style: CustomTextStyle.semiBold12Black,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  payment.isPaid.toString()=="true"?"paid".tr():"unpaid".tr(),
                                  style: CustomTextStyle.regular14Black,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  payment.value.toString() + "EGP".tr(),
                                  style: CustomTextStyle.regular14Black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ]

                  ],
                ),
                10.height,
                Row(
                    children: [
                      Row(
                        children: [
                          Text("totalPaid".tr(),style: CustomTextStyle.regular14Black.copyWith(
                            fontSize: 12,
                          ),),
                          Text(" : ",style: CustomTextStyle.regular14Black.copyWith(fontSize: 12,)),
                          SizedBox(width: 5,),
                          Text(widget.unit?.paidDone.toString() ?? "" + " " + "EGP".tr(),
                            style: CustomTextStyle.regular14Black,textAlign: TextAlign.start,),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text("totalUnpaid".tr(),style: CustomTextStyle.regular14Black.copyWith(
                            fontSize: 12,
                          ),),
                          Text(" : ",style: CustomTextStyle.regular14Black.copyWith(fontSize: 12,)),
                          SizedBox(width: 5,),
                          Text(widget.unit?.notPaid.toString() ?? "" + " " + "EGP".tr(),style: CustomTextStyle.regular14Black,
                            textAlign: TextAlign.start,),
                        ],
                      ),

                    ]
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget unitVal (){
    List<String> nameParts = (widget.unit?.unitName ?? '').split('-');
    return
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العناوين
            Row(
              children: [
                Expanded(
                  child: Text(
                    "model".tr(),
                    style: CustomTextStyle.semiBold14Black.copyWith(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "building".tr(),
                    style: CustomTextStyle.semiBold14Black.copyWith(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "floor_number".tr(),
                    style: CustomTextStyle.semiBold14Black.copyWith(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "levels".tr(),
                    style: CustomTextStyle.semiBold14Black.copyWith(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            // القيم
            Row(
              children: [
                Expanded(
                  child: Text(
                    nameParts.length > 0 ? nameParts[0].trim() : '',
                    style: CustomTextStyle.semiBold14Black.copyWith(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    nameParts.length > 1 ? nameParts[1].trim() : '',
                    style: CustomTextStyle.semiBold14Black.copyWith(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    nameParts.length > 2 ? nameParts[2].trim() : '',
                    style: CustomTextStyle.semiBold14Black.copyWith(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    nameParts.length > 3 ? nameParts[3].trim() : '',
                    style: CustomTextStyle.semiBold14Black.copyWith(
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        )
      );
  }
}
