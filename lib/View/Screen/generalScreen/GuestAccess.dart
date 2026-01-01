import 'package:core_project/Provider/UnitsProvider.dart';
import 'package:core_project/View/Screen/Services/ServicesCategories.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:core_project/helper/date_converter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../helper/ImagesConstant.dart';
import '../../../helper/color_resources.dart';
import '../../../helper/size_utils.dart';
import '../../../helper/size_utils.dart';
import '../../../helper/text_style.dart';
import '../../Widget/MyOrdersWidget/ListOrders.dart';
import '../../Widget/comman/CustomAppBar.dart';
import '../../Widget/comman/comman_Image.dart';

class GuestAccess extends StatefulWidget {
  const GuestAccess({Key? key}) : super(key: key);

  @override
  State<GuestAccess> createState() => _GuestAccessState();
}

class _GuestAccessState extends State<GuestAccess> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UnitsProvider>(context, listen: false).getAllGuest(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        title: 'guestAccess'.tr(),
        backgroundImage: AssetImage(ImagesConstants.backgroundImage),
      ),
      body: Container(
        //color: BACKGROUNDCOLOR,
        child: Container(
          margin:
              const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
          ),
          child: Consumer<UnitsProvider>(
            builder: (context, model, _) {
              if (model.status == LoadingStatus.LOADING) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return buildShimmer(context);
                  },
                  itemCount: 10,
                );
              } else {
                return model.guestsList.isEmpty ? Center(child: emptyList()): ListView.separated(
                  separatorBuilder: (context, index) => 10.height,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Lottie.asset("assets/images/qrcode.json",
                                  width: 120, height: 120, fit: BoxFit.contain),
                              20.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(model.guestsList[index].name),
                                    2.height,
                                    Text(model.guestsList[index].phoneNumber),
                                    2.height,
                                    Text(DateConverter.estimatedDate(
                                        model.guestsList[index].entryDateTime)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemCount: model.guestsList.length,
                );
              }
            },
          ),
        ),
      ),
    ));
  }
}
