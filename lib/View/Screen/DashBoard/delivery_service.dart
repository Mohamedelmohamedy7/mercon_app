import 'dart:io';

import 'package:core_project/Provider/DeliveryProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/View/Screen/delivery_menus.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:ussd_phone_call_sms/ussd_phone_call_sms.dart';
import 'package:widget_zoom/widget_zoom.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../../../helper/ImagesConstant.dart';
import '../../../helper/text_style.dart';
import '../../Widget/MyOrdersWidget/ListOrders.dart';
import '../../Widget/comman/CustomAppBar.dart';

class DeliveryService extends StatefulWidget {
  DeliveryService({Key? key}) : super(key: key);

  @override
  State<DeliveryService> createState() => _DeliveryServiceState();
}

class _DeliveryServiceState extends State<DeliveryService> {
  // bool isLoad = false;

  @override
  initState() {
    Provider.of<DeliveryProvider>(context, listen: false)
        .getDeliveryDataFunction(context);
    super.initState();
  }
  //
  // List<String> menuList = [
  //   "assets/images/1menu.jpeg",
  //   "assets/images/2menu.jpeg",
  //   "assets/images/3menu.jpeg",
  //   "assets/images/4menu.jpeg",
  //   "assets/images/5menu.jpeg",
  //   "assets/images/6menu.jpeg",
  //   "assets/images/7menu.jpeg",
  //   "assets/images/8menu.jpeg",
  // ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'deliveryServices'.tr(),
          needBack: true,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Container(
          //color: BACKGROUNDCOLOR,
          height: MediaQuery.of(context).size.height,
          child: Consumer<DeliveryProvider>(
            builder: (context, model, _) {
              if (model.status == LoadingStatus.LOADING) {
                return shimmerList();
                ;
              } else {
                return Container(
                  //color: BACKGROUNDCOLOR,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    pushRoute(
                                        context: context,
                                        route: DeliveryMenusScreen(
                                          deliveryData:
                                              model.deliveryData[index],
                                        ));
                                  },
                                  child: Container(
                                    //   height: 85,
                                    margin: const EdgeInsets.all(10),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.5),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Lottie.asset(
                                            'assets/images/deliverymenu.json',
                                            height: 60),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${model.deliveryData[index].restaurantName}",
                                                  style: CustomTextStyle
                                                      .bold14black
                                                      .copyWith(
                                                    fontSize: 16,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'deliveryNumber'.tr(),
                                              style: CustomTextStyle
                                                  .regular14Black
                                                  .copyWith(
                                                fontSize: 13,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${model.deliveryData[index].restaurantNumber}",
                                                  style: CustomTextStyle
                                                      .regular14Black
                                                      .copyWith(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                      onTap: () async {
                                                        if (Platform
                                                            .isAndroid) {
                                                          launchUrl(Uri.parse(
                                                              'tel:${model.deliveryData[index].restaurantNumber}'));
                                                        } else {
                                                          await UssdPhoneCallSms()
                                                              .phoneCall(
                                                                  phoneNumber:
                                                                      '${model.deliveryData[index].restaurantNumber}');
                                                        }
                                                      },
                                                      child: Icon(Icons.call,
                                                          size: 30)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) => SizedBox(),
                            itemCount: model.deliveryData.length),
                        // ListView.separated(
                        //     physics: NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     itemBuilder: (context, index) => WidgetZoom(
                        //       heroAnimationTag: index.toString(),
                        //       zoomWidget: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: ClipRRect(
                        //           borderRadius:
                        //           BorderRadius.circular(15),
                        //           child:
                        //           cachedImage("${menuList[index]}"),
                        //         ),
                        //       ),
                        //     ),
                        //     separatorBuilder: (context, index) =>
                        //         SizedBox(),
                        //     itemCount: menuList.length),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
