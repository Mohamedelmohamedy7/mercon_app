import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ActionsScreen.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:core_project/helper/date_converter.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

import '../../../../Provider/SuperAdminProviders/CutomerServiceProvider.dart';
import "package:core_project/Utill/Local_User_Data.dart";

import '../SuperAdminScreen.dart';

class CustomerServiceDetailsScreen extends StatefulWidget {
  const CustomerServiceDetailsScreen(
      {super.key, required this.needBack, required this.id});

  final bool needBack;

  final int? id;

  @override
  State<CustomerServiceDetailsScreen> createState() =>
      _CustomerServiceDetailsScreenState();
}

class _CustomerServiceDetailsScreenState
    extends State<CustomerServiceDetailsScreen> {
  bool openReason = false;
  TextEditingController ServicePriceAfterTaxAmountController =
          TextEditingController(),
      EmergencyServicePriceAfterTaxAmountController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CustomerServiceProvider>(context, listen: false).notify = false;
    p_Listeneress<CustomerServiceProvider>(context)
        .getCustomerServiceDetails(context, id: widget.id);
    Provider.of<CustomerServiceProvider>(context, listen: false).notify = true;
  }

  int selectedItem = 0;

  GlobalKey<FormState> _formKey = GlobalKey();

  void showEditPriceDialog(
    BuildContext context, {
    required TextEditingController controller,
    required CustomerServiceProvider provider,
    required String field,
  }) {
    controller.clear();
    showDialog(
        context: context,
        builder: (dialogContext) => CustomDialogWidgetWithActions(
            context: dialogContext,
            title: "edit_price".tr(),
            onYesTap: () {
              if (_formKey.currentState!.validate()) {
                provider.updateServicePrice(context,
                    id: widget.id, field: field, value: controller.text);
                Navigator.of(context).pop();
              }
            },
            subtitleWidget: Form(
              key: _formKey,
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'enter_edit_price'.tr(),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            subtitle: "Save".tr()));
  }

  // {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Form(
  //         key: _formKey,
  //         child: AlertDialog(
  //           title: Text('Edit Price'),
  //           content: TextFormField(
  //             controller: controller,
  //             keyboardType: TextInputType.number,
  //             decoration: InputDecoration(
  //               labelText: 'Enter new price',
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the dialog
  //               },
  //               child: Text('Cancel'),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 if (_formKey.currentState!.validate()) {
  //                   provider.updateServicePrice(context,
  //                       id: widget.id, field: field, value: controller.text);
  //                   Navigator.of(context).pop();
  //                 }
  //               },
  //               child: Text('Save'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  DateTime? startDate1 = DateTime.now();

  DateTime? endDate1 = DateTime.now();

  DateTime? startTime;
  DateTime? endTime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "CustomersServiceDetails".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Consumer<CustomerServiceProvider>(builder: (context, model, _) {
            if (model.status == LoadingStatus.LOADING) {
              return Center(
                child: Loading(),
              );
            } else if (model.customerServiceModel == null && model.first) {
              return Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(child: emptyList()),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              "UnitOwnerInformation".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 16),

                            // Table Section
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Header Row
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            "Full_Name".tr(),
                                            style: headerStyle(),
                                            textAlign: TextAlign.center,
                                          )),
                                          Expanded(
                                              child: Text(
                                            "Phone Number".tr(),
                                            style: headerStyle(),
                                            textAlign: TextAlign.center,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                      height: 0, color: Colors.grey.shade300),

                                  // Data Row
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            model.customerServiceModel
                                                    ?.ownerName ??
                                                "",
                                            style: dataStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            model.customerServiceModel
                                                    ?.phoneNumber ??
                                                "",
                                            style: dataStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16),

                            // Table Section
                    if(model.customerServiceModel
                        ?.createdByUserName!=null)        Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Header Row
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                "CreatedBy".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),

                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                      height: 0, color: Colors.grey.shade300),

                                  // Data Row
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            model.customerServiceModel
                                                ?.createdByUserName ??
                                                "",
                                            style: dataStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              "Unit Details".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 16),

                            // Table Section
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      // Header Row
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "Unit Number".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                "Building Number".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                "Round".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                "Unit Model".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(
                                          height: 0,
                                          color: Colors.grey.shade300),

                                      // Data Row
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                model
                                                        .customerServiceModel
                                                        ?.unitDetails
                                                        ?.unitNumber ??
                                                    "",
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                model
                                                        .customerServiceModel
                                                        ?.unitDetails
                                                        ?.buildingName ??
                                                    "",
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                model
                                                        .customerServiceModel
                                                        ?.unitDetails
                                                        ?.levelName ??
                                                    "",
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                model
                                                        .customerServiceModel
                                                        ?.unitDetails
                                                        ?.modelName ??
                                                    "",
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              "Service Details".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 16),

                            // Table Section
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      // Header Row
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "Type".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                "Service Name".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                "ServicePriceAfterTax".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                "Emergency Service Price After Tax"
                                                    .tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(
                                          height: 0,
                                          color: Colors.grey.shade300),

                                      // Data Row
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                model.customerServiceModel
                                                        ?.serviceTypeName ??
                                                    "",
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                model
                                                        .customerServiceModel
                                                        ?.subServiceDTO
                                                        ?.subServicesName ??
                                                    "",
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                                child: InkWell(
                                              onTap: model.customerServiceModel
                                                              ?.statusID ==
                                                          2 &&
                                                      globalAccountData
                                                              .getUserType() ==
                                                          AppConstants
                                                              .IS_SuperAdmin
                                                  ? () {
                                                      showEditPriceDialog(
                                                          context,
                                                          controller:
                                                              ServicePriceAfterTaxAmountController,
                                                          provider: model,
                                                          field:
                                                              'servicePriceAfterTax');
                                                    }
                                                  : null,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    (model
                                                            .customerServiceModel
                                                            ?.subServiceDTO
                                                            ?.servicePriceAfterTax)
                                                        .toString(),
                                                    style: dataStyle(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  if (model.customerServiceModel
                                                              ?.statusID ==
                                                          2 &&
                                                      globalAccountData
                                                              .getUserType() ==
                                                          AppConstants
                                                              .IS_SuperAdmin)
                                                    Icon(Icons.edit)
                                                ],
                                              ),
                                            )),
                                            Expanded(
                                                child: InkWell(
                                              onTap: model.customerServiceModel
                                                              ?.statusID ==
                                                          2 &&
                                                      globalAccountData
                                                              .getUserType() ==
                                                          AppConstants
                                                              .IS_SuperAdmin
                                                  ? () {
                                                      showEditPriceDialog(
                                                          context,
                                                          controller:
                                                              EmergencyServicePriceAfterTaxAmountController,
                                                          provider: model,
                                                          field:
                                                              'emergencyServicePriceAfterTax');
                                                    }
                                                  : null,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    (model
                                                            .customerServiceModel
                                                            ?.subServiceDTO
                                                            ?.emergencyServicePriceAfterTax)
                                                        .toString(),
                                                    style: dataStyle(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  if (model.customerServiceModel
                                                              ?.statusID ==
                                                          2 &&
                                                      globalAccountData
                                                              .getUserType() ==
                                                          AppConstants
                                                              .IS_SuperAdmin)
                                                    Icon(Icons.edit)
                                                ],
                                              ),
                                            )),
                                            // Expanded(
                                            //   child: Text(
                                            //     (model
                                            //             .customerServiceModel
                                            //             ?.subServiceDTO
                                            //             ?.emergencyServicePriceAfterTax)
                                            //         .toString(),
                                            //     style: dataStyle(),
                                            //     textAlign: TextAlign.center,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      // Header Row
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "Details".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                "Request Date".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(
                                          height: 0,
                                          color: Colors.grey.shade300),

                                      // Data Row
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                model.customerServiceModel
                                                        ?.details ??
                                                    "",
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                DateConverter.formatDateTimeBasedOnLocale(
                                                    model
                                                        .customerServiceModel
                                                        ?.createdDate ??
                                                        (DateTime.now()
                                                            .toString()),context),
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Column(

                                    children: [
                                      // Header Row
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                    "UpdateDate".tr(),
                                                    style: headerStyle(),
                                                    textAlign: TextAlign.center,
                                                  )),
                                              if( model?.customerServiceModel?.modifiedByUserName!=null)      Expanded(
                                                  child: Text(
                                                    "ModifiedBy".tr(),
                                                    style: headerStyle(),
                                                    textAlign: TextAlign.center,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(
                                          height: 0,
                                          color: Colors.grey.shade300),

                                      // Data Row
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                DateConverter.formatDateTimeBasedOnLocale(
                                                    model
                                                        .customerServiceModel
                                                        ?.modifiedDate ??
                                                        (DateTime.now()
                                                            .toString()),context),
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                           if( model?.customerServiceModel?.modifiedByUserName!=null)   Expanded(
                                              child: Text(
                                               model?.customerServiceModel?.modifiedByUserName??"",
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (model.customerServiceModel?.statusID == null&&
                    model.customerServiceModel?.isApprove==null) ...[
                      Column(
                        children: [
                          /// Row لوقت البداية
                          Row(
                            children: [
                              Text(
                                "fromDate".tr(),
                                style: headerStyle(),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TimePickerSpinner(
                                            locale: const Locale('en', ''),
                                            time: startTime,
                                            is24HourMode: true,
                                            isShowSeconds: false,
                                            itemHeight: 80,
                                            normalTextStyle:
                                                const TextStyle(fontSize: 24),
                                            highlightedTextStyle:
                                                const TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.blue),
                                            isForce2Digits: true,
                                            onTimeChange: (time) {
                                              setState(() {
                                                startTime = time;
                                              });
                                            },
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                height: 50,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "select".tr(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ))),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      startTime == null
                                          ? "selectHour".tr()
                                          : "${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          /// DatePicker لليوم
                          SizedBox(height: 8),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 2.0, // Specify the blur radius
                                  )
                                ]),
                            child: DatePicker(
                              DateTime.now(),
                              initialSelectedDate: startDate1 ?? DateTime.now(),
                              selectionColor: Colors.black,
                              selectedTextColor: Colors.white,
                              onDateChange: (date) {
                                setState(() {
                                  startDate1 = date;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 19),
                          Container(
                            height: 20,
                            color: Colors.grey.shade100,
                          ),
                          SizedBox(height: 10),

                          /// Row لوقت النهاية
                          Row(
                            children: [
                              Text(
                                "toDate".tr(),
                                style: headerStyle(),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TimePickerSpinner(
                                            locale: const Locale('en', ''),
                                            time: endTime,
                                            is24HourMode: true,
                                            isShowSeconds: false,
                                            itemHeight: 80,
                                            normalTextStyle:
                                                const TextStyle(fontSize: 24),
                                            highlightedTextStyle:
                                                const TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.blue),
                                            isForce2Digits: true,
                                            onTimeChange: (time) {
                                              setState(() {
                                                endTime = time;
                                              });
                                            },
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                height: 50,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "select".tr(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ))),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      endTime == null
                                          ? "selectHour".tr()
                                          : "${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          /// DatePicker للنهاية
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 2.0, // Specify the blur radius
                                  )
                                ]),
                            height: 120,
                            child: DatePicker(
                              DateTime.now(),
                              initialSelectedDate: endDate1 ?? DateTime.now(),
                              selectionColor: Colors.black,
                              selectedTextColor: Colors.white,
                              onDateChange: (date) {
                                setState(() {
                                  endDate1 = date;
                                });
                              },
                            ),
                          ),

                          SizedBox(height: 12),
                          if (startDate1 != null && endDate1 != null)
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.green, width: 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          size: 18, color: Colors.green),
                                      SizedBox(width: 8),
                                      Text(
                                        "Start: ${DateFormat('dd/MM/yyyy').format(startDate1!)} "
                                        "at ${startTime?.hour.toString().padLeft(2, '0') ?? ""}:${startTime?.minute.toString().padLeft(2, '0') ?? ""}",
                                        style: TextStyle(
                                            color: Colors.green[800],
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today_outlined,
                                          size: 18, color: Colors.green),
                                      SizedBox(width: 8),
                                      Text(
                                        "End:   ${DateFormat('dd/MM/yyyy').format(endDate1!)} "
                                        "at ${endTime?.hour.toString().padLeft(2, '0') ?? ""}:${endTime?.minute.toString().padLeft(2, '0') ?? ""}",
                                        style: TextStyle(
                                            color: Colors.green[800],
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ],
                    SizedBox(
                      height: 10,
                    ),
                    if (model.loading)
                      Center(child: CircularProgressIndicator())
                    else if (model.customerServiceModel?.statusID == null) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            model.customerServiceModel?.isApprove!=null?SizedBox() :    Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                onTap: () {
                                  print(startTime);
                                  print(startDate1);
                                  if (startDate1 == null) {
                                    failedSnack(context,
                                        "please_select_start_date".tr());
                                  } else if (endDate1 == null) {
                                    failedSnack(
                                        context, "please_select_end_date".tr());
                                  } else if (startTime == null) {
                                    failedSnack(context,
                                        "please_select_start_time".tr());
                                  } else if (endTime == null) {
                                    failedSnack(
                                        context, "please_select_end_time".tr());
                                  } else {
                                    model.sendTimeOfService(context, body: {
                                      "Id": model.customerServiceModel?.id,
                                      "DateFrom":
                                      "${startDate1!.year.toString().padLeft(4, '0')}-${startDate1!.month.toString().padLeft(2, '0')}-${startDate1!.day.toString().padLeft(2, '0')}T${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}:00",
                                      "DateTo":
                                      "${endDate1!.year.toString().padLeft(4, '0')}-${endDate1!.month.toString().padLeft(2, '0')}-${endDate1!.day.toString().padLeft(2, '0')}T${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}:00",
                                    }).then((value){
                                      Navigator.pop(context);
                                      Provider.of<CustomerServiceProvider>(context, listen: false)
                                          .notify = true;
                                      Provider.of<CustomerServiceProvider>(context, listen: false)
                                          .getCustomerServicesList(context);                                    });
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    "sendEditesAndWaitClientResponse".tr(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                onTap: () {
                                  model
                                      .startingRequest(context,
                                          id: model.customerServiceModel?.id)
                                      .then((value) {
                                    model.getCustomerServiceDetails(context,
                                        id: widget.id);
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    "Start Service".tr(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else if (model.customerServiceModel?.statusID == 1) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: MaterialButton(
                                  color: Color(0xfff7c007),
                                  onPressed: () {
                                    model
                                        .updateServiceStatus(context,
                                            id: model.customerServiceModel?.id,
                                            statusId: 2)
                                        .then((value) {
                                      model.getCustomerServiceDetails(context,
                                          id: widget.id);
                                    });
                                  },
                                  child: Text(
                                    "Mark As Processing".tr(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else if (model.customerServiceModel?.statusID == 2) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: MaterialButton(
                                color: Color(0xff007bff),
                                onPressed: () {
                                  model
                                      .updateServiceStatus(context,
                                          id: model.customerServiceModel?.id,
                                          statusId: 4)
                                      .then((value) {
                                    model.getCustomerServiceDetails(context,
                                        id: widget.id);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 11.0),
                                  child: Text(
                                    "Finish Service Without Payment".tr(),
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: MaterialButton(
                                color: Color(0xff007bff),
                                onPressed: () {
                                  model
                                      .updateServiceStatus(context,
                                          id: model.customerServiceModel?.id,
                                          statusId: 3)
                                      .then((value) {
                                    model.getCustomerServiceDetails(context,
                                        id: widget.id);
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 11),
                                  child: Text(
                                    "Finish Service With Payment".tr(),
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: MaterialButton(
                                color: Color(0xffde4c45),
                                onPressed: () {
                                  model
                                      .updateServiceStatus(context,
                                          id: model.customerServiceModel?.id,
                                          statusId: 5)
                                      .then((value) {
                                    model.getCustomerServiceDetails(context,
                                        id: widget.id);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 11.0),
                                  child: Text(
                                    "Cancel Service".tr(),
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else if (model.customerServiceModel?.statusID == 3 ||
                        model.customerServiceModel?.statusID == 4) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Service Finished".tr(),
                          style: TextStyle(color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ] else if (model.customerServiceModel?.statusID == 3 ||
                        model.customerServiceModel?.statusID == 5) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Service has been cancelled".tr(),
                          style: TextStyle(color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  TextStyle headerStyle() {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      // color: Colors.green,
    );
  }

  TextStyle dataStyle() {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );
  }

  Widget tableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 14 : 12,
          color: isHeader ? Colors.black : Colors.grey.shade800,
        ),
      ),
    );
  }
}
