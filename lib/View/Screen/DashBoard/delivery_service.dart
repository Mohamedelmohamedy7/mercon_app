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
import 'package:nb_utils/nb_utils.dart';
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
import 'DashBoardSCreen.dart';

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
        bottomNavigationBar: callCenterBottom(context),
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
                            itemBuilder: (context, index) {
                              final item = model.deliveryData[index];

                              return TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.1, end: 1),
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                                builder: (context, scale, child) {
                                  return Transform.scale(
                                    scale: scale,
                                    child: child,
                                  );
                                },
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    pushRoute(
                                      context: context,
                                      route: DeliveryMenusScreen(deliveryData: item),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient:  LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white,
                                          Theme.of(context).primaryColor.withOpacity(0.03),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.06),
                                          blurRadius: 14,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        /// ICON
                                        Container(
                                          height: 56,
                                          width: 56,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Theme.of(context).primaryColor,
                                                Theme.of(context).primaryColor.withOpacity(0.7),
                                              ],
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.delivery_dining_rounded,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                        ),

                                        14.width,

                                        /// INFO
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.restaurantName ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: CustomTextStyle.bold14black.copyWith(
                                                  fontSize: 17,
                                                ),
                                              ),
                                              8.height,

                                              Container(
                                                padding:
                                                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.phone, size: 14, color: Colors.grey),
                                                    6.width,
                                                    Text(
                                                      item.restaurantNumber ?? '',
                                                      style: CustomTextStyle.regular14Black.copyWith(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        /// CALL BUTTON
                                        InkWell(
                                          onTap: () async {
                                            final phone = item.restaurantNumber ?? '';
                                            if (Platform.isAndroid) {
                                              launchUrl(Uri.parse('tel:$phone'));
                                            } else {
                                              await UssdPhoneCallSms().phoneCall(phoneNumber: phone);
                                            }
                                          },
                                          child: Container(
                                            height: 44,
                                            width: 44,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Theme.of(context).primaryColor,
                                                  Theme.of(context).primaryColor.withOpacity(0.7),
                                                ],
                                              ),
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Icon(
                                              Icons.call_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },


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
