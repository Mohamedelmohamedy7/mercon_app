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
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        color: Theme.of(context).primaryColor, fontSize: 12),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // Clipboard.setData(ClipboardData(
                    //     text: Provider.of<HomeProvider>(context, listen: false)
                    //         .unitModel[0]
                    //         .nameAr));
                    // showAwesomeSnackbar(
                    //   context,
                    //   'Success',
                    //   '${tr("Text copied to clipboard")}',
                    //   contentType: ContentType.help,
                    // );
                  },
                  child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.52,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: lightGray,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 3.0,
                          ),
                        ],
                        color: white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            myUnit[0].modelName,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(" : "),
                          Text(
                            myUnit[0].buildingName,
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(" : "),
                          Text(
                            myUnit[0].levelName,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(" : "),
                          Text(
                            myUnit[0].unitNumber,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )),
                )
              ],
            )
          : SizedBox(),
    );
  }
}
