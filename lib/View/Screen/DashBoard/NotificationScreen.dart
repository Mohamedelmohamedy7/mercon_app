import 'package:core_project/Model/NotificationModel.dart';
import 'package:core_project/Provider/NotifcationProvider.dart';
import 'package:core_project/View/Screen/Services/ServicesCategories.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/date_converter.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../../Utill/Comman.dart';
import '../../../helper/ImagesConstant.dart';
import '../../Widget/MyOrdersWidget/ListOrders.dart';
import '../../Widget/comman/CustomAppBar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.needBack})
      : super(key: key);
  final bool needBack;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NotificationProvider>(context, listen: false)
          .getMyNotifcation(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'notification'.tr(),
            needBack: widget.needBack,
            backgroundImage: AssetImage(ImagesConstants.backgroundImage),
          ),
          body: Container(
            // color: BACKGROUNDCOLOR,
            child: Consumer<NotificationProvider>(
              builder: (context, model, _) {
                if (model.status == LoadingStatus.LOADING) {
                  return ListView.separated(
                      padding: const EdgeInsets.only(top: 20),
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: 150,
                            height: 100,
                            child: buildShimmer(context));
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: 10);
                } else {
                  return
                    model.myNotification.length <= 0?Center(child: emptyList()):
                    ListView.separated(
                        padding: const EdgeInsets.only(top: 20),
                        itemBuilder: (context, index) {
                          return containerNotification(
                              model.myNotification[index], context);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: model.myNotification.length);
                }
              },
            ),
          ),
        ));
  }
}

Container containerNotification(NotificationModel myNotification, context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15)),
      boxShadow: [
        BoxShadow(
          color: lightGray,
          offset: Offset(0.0, 2.0),
          blurRadius: 4.0, // Specify the blur radius
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              cachedImage(myNotification.url,width: 100,height: 100,color: Theme.of(context).primaryColor),
              10.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${DateConverter.localDateToIsoString(myNotification.createdDate)}",
                      style: CustomTextStyle.semiBold12Black,
                    ),
                    Text(
                      condation(context)
                          ? "${myNotification.titleEn}"
                          : "${myNotification.titleAr}",
                      style: CustomTextStyle.regular14Black,
                    ),
                    Text(
                      condation(context)
                          ? myNotification.descriptionEn ?? ''
                          : myNotification.descriptionAr ?? '',
                      style: CustomTextStyle.semiBold12Black,
                      textAlign: TextAlign.start,
                      maxLines: null, // مهم
                      softWrap: true, // مهم
                      overflow: TextOverflow.visible, // مهم
                    ),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    ),
  );
}
