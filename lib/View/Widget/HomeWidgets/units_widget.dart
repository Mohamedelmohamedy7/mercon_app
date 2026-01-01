import 'package:core_project/Provider/UnitsProvider.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../helper/text_style.dart';

class UnitsWidget extends StatelessWidget {
  const UnitsWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitsProvider>(builder: (context, model, _) {
      if (model.status == LoadingStatus.LOADING) {
        return SizedBox();
      } else {
        return model.modelUnitServiceList.length > 1
            ? Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/Home.svg",
                                color: Theme.of(context).primaryColor,
                              ),
                              5.width,
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "yourPriviteUnit".tr(),
                                  style: CustomTextStyle.bold16White.copyWith(
                                      color: Theme.of(context).primaryColor, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            " " + "descyourPriviteUnit".tr(),
                            style: CustomTextStyle.semiBold12Black.copyWith(
                                color: Colors.black.withOpacity(0.4), fontSize: 9.5),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1/0.3,
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemCount: model.modelUnitServiceList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              // Clipboard.setData(ClipboardData(
                              //     text:   currentLangIsEng(context)?
                              //     model.modelUnitServiceList[index].nameEn: model.modelUnitServiceList[index].nameAr));
                              // showAwesomeSnackbar(
                              //   context,
                              //   'Success',
                              //   '${tr("Text copied to clipboard")}',
                              //   contentType: ContentType.help,
                              // );
                            },
                            child: Container(
                              height: 20,
                               padding: EdgeInsets.symmetric(horizontal: 1),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: lightGray,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 1.0,
                                  ),
                                ],
                                color: white,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                   model.modelUnitServiceList[index].modelName,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(" : "),
                                  Text(
                                   model.modelUnitServiceList[index].buildingName,
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 9,fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(" : "),
                                  Text(
                                   model.modelUnitServiceList[index].levelName,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize:9,fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(" : "),
                                  Text(
                                   model.modelUnitServiceList[index].unitNumber,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 9,fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )

                    ],
                  ),
                ),
              )
            : SizedBox();
      }
    });
  }
}
