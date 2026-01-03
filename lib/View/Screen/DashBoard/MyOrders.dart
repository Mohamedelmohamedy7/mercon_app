import 'package:core_project/Provider/ServicesProvider.dart';
import 'package:core_project/Utill/AnimationWidget.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/View/Screen/Services/ServicesCategories.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ServicesProvider>(context, listen: false)
          .getAllMyServices(context);

      Provider.of<ServicesProvider>(context, listen: false)
          .getAllServicesRateData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          needBack: false,
          title: 'clientService'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: CustomAnimatedWidget(
          child: Container(
              // color: BACKGROUNDCOLOR.withOpacity(0.7),
              child: Column(
                children: [
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: TabBarHeader(context, tabController)),
                      InkWell(
                        onTap: () {
                          pushRoute(
                              context: context,
                              route: const ServicesCategories());
                        },
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 20, end: 20),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 4.0,
                                ),
                              ],
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.height,

                  20.height,
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Consumer<ServicesProvider>(
                          builder: (context, state, _) {
                            if (state.status == LoadingStatus.LOADING) {
                              return shimmerList();
                            } else {
                              return BodyTabView(state.servicesRequestRequested,
                                  rateList: state.listRateModel);
                            }
                          },
                        ),
                        Consumer<ServicesProvider>(
                          builder: (context, state, _) {
                            if (state.status == LoadingStatus.LOADING) {
                              return shimmerList();
                            } else {
                              return BodyTabView(
                                  state.servicesRequestProccessing,
                                  rateList: state.listRateModel);
                            }
                          },
                        ),
                        Consumer<ServicesProvider>(
                            builder: (context, state, _) {
                          if (state.status == LoadingStatus.LOADING) {
                            return shimmerList();
                          } else {
                            return BodyTabView(state.servicesRequestFinished,
                                isFinished: true,
                                rateList: state.listRateModel);
                          }
                        }),

                        // Consumer<ServicesProvider>(
                        //     builder: (context, state, _) {
                        //   if (state.status == LoadingStatus.LOADING) {
                        //     return shimmerList();
                        //   } else {
                        //     return BodyTabView(state.servicesRequestCancelled);
                        //   }
                        // }),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
