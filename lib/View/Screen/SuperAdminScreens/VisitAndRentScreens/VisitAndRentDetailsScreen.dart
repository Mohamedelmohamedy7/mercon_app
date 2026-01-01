import 'package:core_project/Provider/SuperAdminProviders/VisitAndRentProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/SuperAdminWidgets/buildImageCard.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class VisitAndRentDetailsScreen extends StatefulWidget {
  const VisitAndRentDetailsScreen(
      {super.key, required this.needBack, required this.id});
  final bool needBack;

  final int? id;
  @override
  State<VisitAndRentDetailsScreen> createState() =>
      _VisitAndRentDetailsScreenState();
}

class _VisitAndRentDetailsScreenState extends State<VisitAndRentDetailsScreen> {
  bool openReason = false;

  final TextEditingController reasonController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<VisitAndRentProviderProvider>(context, listen: false).notify =
        false;
    p_Listeneress<VisitAndRentProviderProvider>(context)
        .getNoticeVisitAndRentDetails(context, id: widget.id);
    Provider.of<VisitAndRentProviderProvider>(context, listen: false).notify =
        true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Visit Or Rent Details".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<VisitAndRentProviderProvider>(
              builder: (context, model, _) {
            if (model.status == LoadingStatus.LOADING) {
              return Center(
                child: Loading(),
              );
            } else if (model.noticeVisitAndRentDetails == null && model.first) {
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
                                                "Unit Details".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                "unit_model".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                "unit_type".tr(),
                                                style: headerStyle(),
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                  child: Text(
                                                "Building Number".tr(),
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
                                                model.noticeVisitAndRentDetails
                                                        ?.name ??
                                                    model
                                                        .noticeVisitAndRentDetails
                                                        ?.nameEn ??
                                                    model
                                                        .noticeVisitAndRentDetails
                                                        ?.nameAr ??
                                                    "",
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                model.noticeVisitAndRentDetails
                                                        ?.unitModelName ??
                                                    "",
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                model.noticeVisitAndRentDetails
                                                        ?.unitTypeName ??
                                                    "",
                                                style: dataStyle(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                model.noticeVisitAndRentDetails
                                                        ?.buildingName ??
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
                              "visitor_renter_details".tr(),
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
                                            "visitor_renter".tr(),
                                            style: headerStyle(),
                                            textAlign: TextAlign.center,
                                          )),
                                          Expanded(
                                              child: Text(
                                            "visit_type".tr(),
                                            style: headerStyle(),
                                            textAlign: TextAlign.center,
                                          )),
                                          Expanded(
                                              child: Text(
                                            "visitor_count".tr(),
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
                                            model.noticeVisitAndRentDetails
                                                    ?.name ??
                                                model.noticeVisitAndRentDetails
                                                    ?.nameEn ??
                                                model.noticeVisitAndRentDetails
                                                    ?.nameAr ??
                                                "",
                                            style: dataStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            model.noticeVisitAndRentDetails
                                                        ?.isRent ==
                                                    true
                                                ? "rent".tr()
                                                : "visit".tr(),
                                            style: dataStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            (model.noticeVisitAndRentDetails
                                                        ?.totalWithVistiorCount ??
                                                    0)
                                                .toString(),
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

                            SizedBox(
                              height: 10,
                            ),
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
                                            "National Number".tr(),
                                            style: headerStyle(),
                                            textAlign: TextAlign.center,
                                          )),
                                          Expanded(
                                              child: Text(
                                            "phone_number".tr(),
                                            style: headerStyle(),
                                            textAlign: TextAlign.center,
                                          )),
                                          Expanded(
                                              child: Text(
                                            "entry_time".tr(),
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
                                            model.noticeVisitAndRentDetails
                                                    ?.nationalId ??
                                                "",
                                            style: dataStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            model.noticeVisitAndRentDetails
                                                    ?.phoneNumber ??
                                                "",
                                            style: dataStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                (DateTime.tryParse(model
                                                            .noticeVisitAndRentDetails
                                                            ?.entryDateTime ??
                                                        (DateTime.now()
                                                            .toString())) ??
                                                    (DateTime.now()))),
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

                            SizedBox(
                              height: 10,
                            ),
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
                                            "exit_time".tr(),
                                            style: headerStyle(),
                                            textAlign: TextAlign.center,
                                          )),
                                          Expanded(
                                              child: Text(
                                            "request_status".tr(),
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
                                            DateFormat('dd/MM/yyyy').format(
                                                (DateTime.tryParse(model
                                                            .noticeVisitAndRentDetails
                                                            ?.isCheckoutQrCodeGenerated ??
                                                        (DateTime.now()
                                                            .toString())) ??
                                                    (DateTime.now()))),
                                            style: dataStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            model.noticeVisitAndRentDetails
                                                    ?.statusName ??
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
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                        (model.noticeVisitAndRentDetails?.imageNationalIdList ??
                                [])
                            .length,
                        (index) => buildImageCard(
                          (model.noticeVisitAndRentDetails
                                  ?.imageNationalIdList ??
                              [])[index],
                          context: context,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (model.loading)
                      Center(child: CircularProgressIndicator())
                    else if (model.noticeVisitAndRentDetails?.statusId ==
                        1) ...[
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
                                  color: Colors.green,
                                  onPressed: () {
                                    model
                                        .acceptNoticeVisitAndRent(context,
                                            id: (model.noticeVisitAndRentDetails
                                                        ?.id ??
                                                    0)
                                                .toString(),
                                            statusId: 2.toString())
                                        .then((value) =>
                                            model.getNoticeVisitAndRentDetails(
                                                context,
                                                id: widget.id));
                                  },
                                  child: Text(
                                    "قبول الطلب",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: MaterialButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    reasonController.clear();
                                    openReason = !openReason;
                                    setState(() {});
                                  },
                                  child: Text(
                                    "رفض الطلب",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (openReason) ...[
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.red,
                              ),
                            ),
                            child: textFormField("reason for rejection".tr(),
                                reasonController, null)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: MaterialButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              if (reasonController.text.isEmpty) {
                                toast("Enter Reason".tr());
                              } else {
                                model.saveReasonOfRefuseAdmin(context,
                                    userID: (model.noticeVisitAndRentDetails
                                                ?.userID ??
                                            0)
                                        .toString(),
                                    saveReasonOfRefuseAdmin:
                                        reasonController.text);
                                model
                                    .acceptNoticeVisitAndRent(context,
                                        id: (model.noticeVisitAndRentDetails
                                                    ?.id ??
                                                0)
                                            .toString(),
                                        statusId: 3.toString())
                                    .then((value) {
                                  reasonController.clear();
                                  openReason = false;
                                  model.getNoticeVisitAndRentDetails(context,
                                      id: widget.id);
                                });
                              }
                            },
                            child: Text(
                              "send".tr(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
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
