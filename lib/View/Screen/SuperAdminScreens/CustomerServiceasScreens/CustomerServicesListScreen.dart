import 'package:core_project/Model/CustomerServices/customer_services_list_model.dart';
import 'package:core_project/Provider/SuperAdminProviders/CutomerServiceProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/Services/ServicesCategories.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/CustomerServiceasScreens/CustomerServiceDetailsScreen.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../helper/text_style.dart';
import '../../../Widget/SuperAdminWidgets/build_row.dart';
import "package:core_project/Utill/Local_User_Data.dart";

class CustomerServicesListScreen extends StatefulWidget {
  CustomerServicesListScreen({super.key, required this.needBack});
  final bool needBack;

  @override
  State<CustomerServicesListScreen> createState() =>
      _CustomerServicesListScreenState();
}

class _CustomerServicesListScreenState
    extends State<CustomerServicesListScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CustomerServiceProvider>(context, listen: false).notify = false;
    catchError(
        p_Listeneress<CustomerServiceProvider>(context)
            .getCustomerServicesList(context),
        'CustomerServiceProvider');
    Provider.of<CustomerServiceProvider>(context, listen: false).notify = true;
    Provider.of<CustomerServiceProvider>(context, listen: false).first = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "customer_service".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<CustomerServiceProvider>(context, listen: false)
                .notify = true;
            Provider.of<CustomerServiceProvider>(context, listen: false)
                .getCustomerServicesList(context);
          },
          child:
              Consumer<CustomerServiceProvider>(builder: (context, model, _) {
            return Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 10,
                ),
          if( globalAccountData.getUserType() ==
              AppConstants.IS_SuperAdmin ||
              globalAccountData.getUserType() ==
                  AppConstants.IS_Supervisor||
              globalAccountData.getUserType() ==
                  AppConstants.IS_CustomerService)      Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          pushRoute(
                              context: context,
                              route: const ServicesCategories());
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
                        child: Text(
                          'Add_Service'.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    : model.customerServicesList.isEmpty && model.first
                        ? Expanded(
                            child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 100.0),
                                  child: Center(child: emptyList()),
                                )))
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                //   shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    buildCustomerServiceCard(
                                      key: Key(index.toString()),
                                  model.customerServicesList[index],
                                  model: model,
                                ),
                                itemCount: model.customerServicesList.length,
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

  String getStatusLabel(int? statusId, {String lang = "ar"}) {
    switch (statusId) {
      case null:
        return "NewRequest".tr();
      case 1:
        return "not_executed".tr();
      case 2:
        return "in_process".tr();
      case 3:
        return "finished_with_payment".tr();
      case 4:
        return "finished_without_payment".tr();
      case 5:
        return "cancel_request".tr();
      default:
        return "not_executed".tr();
    }
  }

  Color getStatusColor(
    int? statusId,
  ) {
    switch (statusId) {
      case null:
        return Color(0xffb64a78);
      case 1:
        return Color(0xffdf4b3b);
      case 2:
        return Color(0xfff1a819);
      case 3:
        return Color(0xff308cd9);
      case 4:
        return Color(0xff70ca70);
      case 5:
        return Color(0xffb64a78);
      default:
        return Color(0xffdf4b3b);
    }
  }

  Widget buildCustomerServiceCard(CustomerServiceModel user,
      {required CustomerServiceProvider model,Key ? key}) {
    print( model.customerServiceModel?.dateFrom );
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {
                    pushRoute(
                      context: context,
                      route: CustomerServiceDetailsScreen(
                        needBack: true,
                        id: user.id,
                      ),
                    );
                  },
                ),
              ],
            ),
            buildRow(
              "unit_name".tr(),
              user.unitName ?? "",
            ),
            buildRow(
              "service_type".tr(),
              user.serviceType?.name ?? "",
            ),
            buildRow(
              "order_status".tr(),
              getStatusLabel(user.statusID),
              color: getStatusColor(user.statusID),
            ),
            buildRow(
              "order_date".tr(),
              DateFormat('dd/MM/yyyy').format((DateTime.tryParse(
                      user.createdDate ?? (DateTime.now().toString())) ??
                  (DateTime.now()))),
            ),
            SizedBox(height: 10,),
            user?.dateFrom == null||
                user?.dateFrom == "null"
                ? Container()
                : buildRow(
              "fromDate".tr(),
              user!.dateFrom!,
            ),
            user?.dateTo == null||
              user?.dateTo == "null"
                ? Container()
                : buildRow(
              "toDate".tr(),
              user!.dateTo!,
            ),


          ],
        ),
      ),
    );
  }
}
