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
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../../Utill/Comman.dart';
import '../../../helper/ImagesConstant.dart';
import '../../Widget/MyOrdersWidget/ListOrders.dart';
import '../../Widget/comman/CustomAppBar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.needBack}) : super(key: key);
  final bool needBack;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotificationProvider>(context, listen: false).getMyNotifcation(context);
    });

    _tabController.addListener(() {
      setState(() {}); // هنا كل مرة تختار Tab هيتعمل rebuild
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'notification'.tr(),
            needBack: widget.needBack,
            backgroundImage: AssetImage(ImagesConstants.backgroundImage),
            bottom: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                  indicatorPadding: EdgeInsets.zero,
                  labelColor: Colors.brown,
                  unselectedLabelColor: Colors.brown,
                  tabs: List.generate(3, (index) {
                    return _buildTab(
                      index == _tabController.index, // true إذا كانت نشطة
                      index == 0 ? 'news'.tr() : index == 1 ? 'finance'.tr() : 'events'.tr(),
                      showDivider: index != 2,
                    );
                  }),
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              buildNotificationList(Provider.of<NotificationProvider>(context).myNotification),
              buildNotificationList(dummyInstallmentsNotifications),
              Stack(
                children: [
                  buildNotificationList(dummyOccasionsNotifications),
                  Opacity(
                      opacity: 0.8,
                      child: Lottie.asset("assets/images/festival.json",repeat: false ))
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
  /// 👈 حط هذه الدالة داخل نفس الكلاس
  Widget buildNotificationList(List<NotificationModel> myNotification) {
    return Consumer<NotificationProvider>(
      builder: (context, model, _) {
        if (model.status == LoadingStatus.LOADING) {
          return ListView.separated(
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 150,
                height: 100,
                child: buildShimmer(context),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: 10,
          );
        } else {
          return model.myNotification.isEmpty
              ? Center(child: emptyList())
              : ListView.separated(
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: (context, index) {
              return containerNotification(
                  myNotification[index], context);
            },
            separatorBuilder: (context, index) =>
            const SizedBox(height: 10),
            itemCount: model.myNotification.length,
          );
        }
      },
    );
  }

  Widget _buildTab(bool isActive, String text, {bool showDivider = true}) {
    return Row(
      children: [
        Expanded(
          child: Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isActive ? Colors.brown : Colors.brown.withOpacity(0.6),
                width: isActive ? 2 : 1,
              ),
              color: isActive ? Colors.brown.withOpacity(0.1) : Colors.transparent,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: isActive ? Colors.brown : Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        if (showDivider) ...[
          const SizedBox(width: 10),
          Container(
            width: 1,
            height: 30,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 10),
        ],
      ],
    );
  }
}


// الدالة containerNotification تبقى زي ما هي (بدون تغيير)
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
          blurRadius: 4.0,
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
      child: Row(
        children: [
          cachedImage(myNotification.url, width: 60, height: 80, color: Theme.of(context).primaryColor),
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
                  condation(context) ? "${myNotification.titleEn}" : "${myNotification.titleAr}",
                  style: CustomTextStyle.regular14Black,
                ),
                Text(
                  condation(context) ? myNotification.descriptionEn ?? '' : myNotification.descriptionAr ?? '',
                  style: CustomTextStyle.semiBold12Black,
                  textAlign: TextAlign.start,
                  maxLines: null,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}Widget _buildTab(String text, {required bool isActive}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isActive ? Colors.brown : Colors.brown.withOpacity(0.3),
        width: isActive ? 2 : 1,
      ),
      color: isActive ? Colors.brown.withOpacity(0.1) : Colors.transparent,
    ),
    child: Text(
      text,
      style: TextStyle(
        color: isActive ? Colors.brown : Colors.grey,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
