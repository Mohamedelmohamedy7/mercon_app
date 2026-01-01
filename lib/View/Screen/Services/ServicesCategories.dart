import 'dart:developer';

import 'package:core_project/Model/ServicesComponantModel.dart';
import 'package:core_project/Provider/ServicesProvider.dart';
import 'package:core_project/View/Screen/Services/serviceRequest.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Utill/AnimationWidget.dart';
import '../../../Utill/Comman.dart';

import '../../../helper/ImagesConstant.dart';
import '../../../helper/app_constants.dart';
import '../../../helper/color_resources.dart';
import '../../Widget/comman/CustomAppBar.dart';
import '../../Widget/comman/comman_Image.dart';
import "package:core_project/Utill/Local_User_Data.dart";

class ServicesCategories extends StatefulWidget {
  const ServicesCategories({Key? key}) : super(key: key);

  @override
  State<ServicesCategories> createState() => _ServicesCategoriesState();
}

class _ServicesCategoriesState extends State<ServicesCategories> {
  @override
  void initState() {
    super.initState();
    Provider.of<ServicesProvider>(context, listen: false)
        .getAllServices(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            title: 'clientService'.tr(),
            backgroundImage: AssetImage(ImagesConstants.backgroundImage),
          ),
          body: CustomAnimatedWidget(
            child: Container(
              height: MediaQuery.of(context).size.height,
              // color: BACKGROUNDCOLOR.withOpacity(0.7),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.height,
                    Container(
                      width: 220,
                      height: 48,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImagesConstants.backGroundOrder),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        "selectService".tr(),
                        style: CustomTextStyle.bold14White,
                      )),
                    ),
                    17.height,
                    Consumer<ServicesProvider>(
                      builder: (context, model, _) {
                        if (model.status == LoadingStatus.LOADING) {
                          return AnimationLimiter(
                              child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 30.0,
                                    mainAxisSpacing: 20.0,
                                    childAspectRatio: 1.6),
                            itemCount: 8,
                            // Total number of items
                            itemBuilder: (BuildContext context, int index) {
                              return buildShimmer(context);
                            },
                          ));
                        } else {
                          return AnimationLimiter(
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 30.0,
                                      mainAxisSpacing: 20.0,
                                      childAspectRatio: 1.6),
                              itemCount: model.services.length,
                              // Total number of items
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(seconds: 1),
                                    columnCount: 2,
                                    child: ScaleAnimation(
                                        duration: Duration(seconds: 1),
                                        child: FadeInAnimation(
                                          child: MyGridItem(
                                              model.services[index], model),
                                        )));
                              },
                            ),
                          );
                        }
                      },
                    ),
                    20.height,
                    if (!(
                        globalAccountData.getUserType() == AppConstants.IS_SuperAdmin||
                        globalAccountData.getUserType() == AppConstants.IS_FullSuperAdmin||
                        globalAccountData.getUserType() ==
                            AppConstants.IS_Supervisor||
                        globalAccountData.getUserType() ==
                            AppConstants.IS_CustomerService))
                      InkWell(
                        onTap: () {
                          pushRoute(
                              context: context,
                              route: ServiceRequest(
                                  servicesModel: null, isOther: true));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 17),
                          width: w(context),
                          height: 55,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: lightGray,
                                  // Specify the shadow color
                                  offset: Offset(0.0, 2.0),
                                  // Specify the offset of the shadow
                                  blurRadius: 4.0, // Specify the blur radius
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Center(
                              child: Text(
                            "other".tr(),
                            style: CustomTextStyle.semiBold12Black,
                          )),
                        ),
                      ),
                    45.height,
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

Padding buildShimmer(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 140,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
        )),
  );
}

class MyGridItem extends StatelessWidget {
  final ServicesModel itemNumber;
  ServicesProvider provider;
  MyGridItem(this.itemNumber, this.provider, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        pushRoute(
            context: context, route: ServiceRequest(servicesModel: itemNumber));
      },
      child: Container(
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: lightGray,
            offset: Offset(0.0, 2.0),
            blurRadius: 2.0, // Specify the blur radius
          ),
        ], borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Card(
          elevation: 0.0,
          color: white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cachedImage(itemNumber.iconURLPath, width: 35, height: 35),
              const SizedBox(height: 6.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  itemNumber.name,
                  style: CustomTextStyle.semiBold12Black.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Padding buildShimmer1(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 140,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
        )),
  );
}
