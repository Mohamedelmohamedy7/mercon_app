import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/NotificationForAdminScreens/send_notification_screen.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/date_converter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Model/SuperAdminModels/NotificationModelForAdmin/notification_model_for_admin.dart';
import '../../../../Provider/SuperAdminProviders/NotificationForAdminProvider.dart';

class NotificationForAdminScreen extends StatefulWidget {
  NotificationForAdminScreen({super.key, required this.needBack});
  final bool needBack;

  @override
  State<NotificationForAdminScreen> createState() =>
      _NotificationForAdminScreenState();
}

class _NotificationForAdminScreenState
    extends State<NotificationForAdminScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NotificationForAdminProvider>(context, listen: false).notify =
        false;
    catchError(
        p_Listeneress<NotificationForAdminProvider>(context)
            .getNotificationList(context),
        'NotificationForAdminProvider');
    Provider.of<NotificationForAdminProvider>(context, listen: false).notify =
        true;
    Provider.of<NotificationForAdminProvider>(context, listen: false).first =
        true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "notification".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<NotificationForAdminProvider>(context, listen: false)
                .notify = true;
            Provider.of<NotificationForAdminProvider>(context, listen: false)
                .getNotificationList(context);
          },
          child: Consumer<NotificationForAdminProvider>(
              builder: (context, model, _) {
            return Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                       Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              pushRoute(
                                context: context,
                                route:const SendNotificationScreen(
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 24.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child:  Text(
                              'add_item'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                model.status == LoadingStatus.LOADING
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 200.0),
                            child: Center(
                              child: Loading(),
                            ),
                          ),
                        ),
                      )
                    : model.notificationList.isEmpty && model.first
                        ? Expanded(
                            child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 120.0),
                                  child: Center(child: emptyList()),
                                )))
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                //   shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    buildNotificationCard(
                                  model.notificationList[index],
                                  model: model,
                                ),
                                itemCount: model.notificationList.length,
                              ),
                            ),
                          ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget buildNotificationCard(NotificationModel notificationModel,
      {required NotificationForAdminProvider model}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              notificationModel.titleAr??notificationModel.titleEn??"",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            subtitle: Text(
              notificationModel.descriptionAr??notificationModel.descriptionEn??"",
              textAlign: TextAlign.right,
            ),
            trailing: Text(
            DateConverter.formatDateString(notificationModel.createdDate??""),
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
