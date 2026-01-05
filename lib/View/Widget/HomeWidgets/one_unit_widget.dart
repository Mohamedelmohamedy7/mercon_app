import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../Model/UnitModelService.dart';
import '../../../Provider/HomeProvider.dart';
import '../../../helper/SnackBarScreen.dart';

class OneUnitWidget extends StatelessWidget {
  OneUnitWidget({super.key, required this.myUnit});

  List<OwnerUnit> myUnit = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: myUnit.length > 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/Home.svg",
                      color: Theme.of(context).primaryColor,
                      width: 20,
                    ),
                    5.width,
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "yourPriviteUnit".tr(),
                        style: CustomTextStyle.bold16White.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
                 10.height,
                 Container(
                   child: Card(
                    elevation: 6,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    margin:
                        const EdgeInsets.symmetric(vertical: 8,),
                    clipBehavior: Clip.antiAlias,
                    child: SizedBox(
                      height: 115,
                      child: Row(
                        children: [
                          /// IMAGE SIDE
                          Stack(
                            children: [
                              Image.asset(
                                "assets/images/home1.jpg", // غيرها حسب مشروعك
                                width: 130,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: 130,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.2),
                                      Colors.black.withOpacity(0.55),
                                    ],
                                  ),
                                ),
                              ),

                              /// STATUS
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      5.width,
                                      Icon(
                                        myUnit[0].statusName == "Active"
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        size: 14,
                                        color: myUnit[0].statusName == "Active"
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      4.width,
                                      Text(
                                        myUnit[0].statusName == "Active"
                                            ? "Active"
                                            : "Inactive",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: myUnit[0].statusName == "Active"
                                              ? Colors.green.shade800
                                              : Colors.red.shade800,
                                        ),
                                      ),
                                      5.width,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// CONTENT SIDE
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _infoRow(
                                    icon: Icons.account_balance,
                                    title: "model".tr(),
                                    value: myUnit[0].modelName,
                                  ),
                                  _infoRow(
                                    icon: Icons.home,
                                    title: "building_number".tr(),
                                    value: myUnit[0].buildingName,
                                  ),
                                  _infoRow(
                                    icon: Icons.layers_outlined,
                                    title: "levels".tr(),
                                    value: myUnit[0].levelName,
                                    trailing: Row(
                                      children: [
                                        Icon(Icons.home_work_outlined,
                                            size: 16,
                                            color:
                                                Theme.of(context).primaryColor),
                                        4.width,
                                        Text(
                                          "floor_number".tr()  + myUnit[0].unitNumber,
                                          style: CustomTextStyle.bold14black,
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
                    ),
                  ),
                )
                // GestureDetector(
                //   onTap: () {
                //     // Clipboard.setData(ClipboardData(
                //     //     text: Provider.of<HomeProvider>(context, listen: false)
                //     //         .unitModel[0]
                //     //         .nameAr));
                //     // showAwesomeSnackbar(
                //     //   context,
                //     //   'Success',
                //     //   '${tr("Text copied to clipboard")}',
                //     //   contentType: ContentType.help,
                //     // );
                //   },
                //   child: Container(
                //       height: 40,
                //       width: MediaQuery.of(context).size.width * 0.52,
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //       decoration: BoxDecoration(
                //         boxShadow: const [
                //           BoxShadow(
                //             color: lightGray,
                //             offset: Offset(0.0, 1.0),
                //             blurRadius: 3.0,
                //           ),
                //         ],
                //         color: white.withOpacity(0.8),
                //         borderRadius: BorderRadius.circular(22),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             myUnit[0].modelName,
                //             style: TextStyle(
                //               color: Theme.of(context).primaryColor,
                //               fontSize: 11,
                //               fontWeight: FontWeight.w700,
                //             ),
                //           ),
                //           Text(" : "),
                //           Text(
                //             myUnit[0].buildingName,
                //             style: TextStyle(
                //               color: Colors.orange,
                //               fontSize: 11,
                //               fontWeight: FontWeight.w700,
                //             ),
                //           ),
                //           Text(" : "),
                //           Text(
                //             myUnit[0].levelName,
                //             style: TextStyle(
                //               color: Colors.red,
                //               fontSize: 11,
                //               fontWeight: FontWeight.w700,
                //             ),
                //           ),
                //           Text(" : "),
                //           Text(
                //             myUnit[0].unitNumber,
                //             style: TextStyle(
                //               color: Colors.black,
                //               fontSize: 11,
                //               fontWeight: FontWeight.w700,
                //             ),
                //           ),
                //         ],
                //       )),
                // )
              ],
            )
          : SizedBox(),
    );
  }
}

Widget _infoRow({
  required IconData icon,
  required String title,
  required String value,
  Widget? trailing,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: 28,
        height: 28,
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade100,
          child: Icon(
            icon,
            size: 16,
            color: Colors.grey.shade700,
          ),
        ),
      ),
      2.width,
      Expanded(
        child: RichText(
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
          text: TextSpan(
            style: const TextStyle(height: 1.1),
            children: [
              TextSpan(
                text: "$title: ",
                style: CustomTextStyle.medium14Black.copyWith(height: 1.1),
              ),
              TextSpan(
                text: value,
                style: CustomTextStyle.bold14black.copyWith(height: 1.1),
              ),
            ],
          ),
        ),
      ),
      if (trailing != null) trailing,
    ],
  );

}
