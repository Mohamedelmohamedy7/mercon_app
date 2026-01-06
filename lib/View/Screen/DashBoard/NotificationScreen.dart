import 'package:core_project/Model/NotificationModel.dart';
import 'package:core_project/Provider/HomeProvider.dart';
import 'package:core_project/Provider/NotifcationProvider.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/date_converter.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../../Model/HomeComponantModel/NewsModel.dart';
import '../../../Utill/Comman.dart';
import '../../../helper/ImagesConstant.dart';
import '../../../show_news_detials.dart';
import '../../Widget/MyOrdersWidget/ListOrders.dart';
import '../../Widget/comman/CustomAppBar.dart';
import '../Services/ServicesCategories.dart';
import '../units_owner.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen(
      {Key? key, required this.needBack, required this.adminScreen})
      : super(key: key);
  final bool needBack;
  final bool adminScreen;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotificationProvider>(context, listen: false)
          .getMyNotifcation(context);
    });

    _tabController.addListener(() {
      setState(() {}); // كل مرة تختار Tab هيتعمل rebuild
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
              padding: const EdgeInsets.all(4.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                ),
                child: widget.adminScreen
                    ? Container()
                    : TabBar(
                        controller: _tabController,
                        labelPadding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        indicatorPadding: EdgeInsets.zero,
                        labelColor: Colors.brown,
                        unselectedLabelColor: Colors.brown,
                        tabs: List.generate(4, (index) {
                          return _buildTab(
                            index == _tabController.index, // true إذا كانت نشطة
                            index == 0
                                ? 'urgent_notify'.tr()
                                : index == 1
                                    ? 'news'.tr()
                                    : index == 2
                                        ? 'finance'.tr()
                                        : 'events'.tr(),
                            showDivider: index != 3,
                          );
                        }),
                      ),
              ),
            ),
          ),
          body: widget.adminScreen
              ? buildNotificationList(
                  Provider.of<NotificationProvider>(context).myNotification)
              : TabBarView(
                  controller: _tabController,
                  children: [
                    buildNotificationList(
                      Provider.of<NotificationProvider>(context)
                          .myNotification
                          .where((element) => element.notificationTypeID == "1")
                          .toList(),
                      news:
                          false, // نضيف dummyConstructionStageNotifications هنا
                    ),
                    buildNotificationList(
                      Provider.of<NotificationProvider>(context)
                          .myNotification
                          .where((element) => element.notificationTypeID == "2")
                          .toList(),
                      news:
                          true, // نضيف dummyConstructionStageNotifications هنا
                    ),
                    buildNotificationList(dummyInstallmentsNotifications,finance: true),
                    Stack(
                      children: [
                        buildNotificationList(dummyOccasionsNotifications),
                        Opacity(
                            opacity: 0.8,
                            child: Lottie.asset("assets/images/festival.json",
                                repeat: false))
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  /// 👈 دالة إنشاء ليستة الإشعارات
  Widget buildNotificationList(List<NotificationModel> myNotification,
      {bool? news,bool ? finance}) {
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
          return myNotification.isEmpty
              ? Center(child: emptyList())
              : ListView.separated(
                  padding: const EdgeInsets.only(top: 20),
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {

                        if (news == true) {
                          final homeProvider =
                          Provider.of<HomeProvider>(context, listen: false);

                          final String? newsId =
                          myNotification[index].newsID?.toString();
                           if (newsId == null) return;

                          final NewsModel? newsModel = homeProvider.newsList
                              .cast<NewsModel?>()
                              .firstWhere(
                                (  element) {
                                   return element!.id.toString() == newsId;
                                },
                            orElse: () => null,
                          );

                          if (newsModel != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ShowNewsDetials(
                                  newsModel: newsModel,
                                ),
                              ),
                            );
                          }
                        }
                        if(finance==true){
                          pushRoute(context: context, route: const UnitsOwner());
                        }

                      },
                      child: containerNotification(
                          myNotification[index], context)),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: myNotification.length,
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
              color:
                  isActive ? Colors.brown.withOpacity(0.1) : Colors.transparent,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
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
          const SizedBox(width: 2),
          Container(
            width: 1,
            height: 30,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 2),
        ],
      ],
    );
  }
}

/// الدالة containerNotification تبقى زي ما هي
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cachedImage(myNotification.url,
              width: 50, height: 60, color: Theme.of(context).primaryColor),
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
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
