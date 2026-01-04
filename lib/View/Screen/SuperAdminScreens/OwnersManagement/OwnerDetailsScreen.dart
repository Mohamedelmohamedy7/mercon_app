import 'package:core_project/Model/SuperAdminModels/OwnerManagementModels/payment_model.dart';
import 'package:core_project/Model/SuperAdminModels/unit_details_model.dart';
import 'package:core_project/Provider/SuperAdminProviders/OwnersManagementProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ActionsScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/OwnersManagement/ContractPdfButton.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/OwnersManagement/reject_reason.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/SuperAdminWidgets/buildImageCard.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:core_project/helper/date_converter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../../../Widget/SuperAdminWidgets/build_row.dart';

class OwnerDetailsScreen extends StatefulWidget {
  const OwnerDetailsScreen(
      {super.key, required this.needBack, required this.id});

  final bool needBack;

  final int? id;

  @override
  State<OwnerDetailsScreen> createState() => _OwnerDetailsScreenState();
}

class _OwnerDetailsScreenState extends State<OwnerDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OwnersManagementProvider>(context, listen: false).notify =
        false;
    catchError(
        p_Listeneress<OwnersManagementProvider>(context)
            .getUnitOwnerDetails(context, id: widget.id),
        'OwnersManagementProvider');
    Provider.of<OwnersManagementProvider>(context, listen: false).notify = true;
  }

  bool openReason = false;
  bool openPaymentData = false;

  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Owner Details".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Consumer<OwnersManagementProvider>(builder: (context, model, _) {
          if (model.status == LoadingStatus.LOADING) {
            return Center(
              child: Loading(),
            );
          } else if (model.unitDetailsModel?.data == null) {
            return Center(child: emptyList());
          } else {
            Data? data = model.unitDetailsModel?.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // sub Owner Data Section
                    if (model.unitDetailsModel?.data?.subOwnerDetails != null)
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
                              Text(
                                "Sub Owner Information".tr(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 16),
                              //sub Owner Information Section
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(model
                                                .unitDetailsModel
                                                ?.data
                                                ?.subOwnerDetails
                                                ?.profileImagePath !=
                                            null
                                        ? (AppConstants.BASE_URL_IMAGE +
                                            (model
                                                        .unitDetailsModel
                                                        ?.data
                                                        ?.subOwnerDetails
                                                        ?.profileImagePath ??
                                                    "")
                                                .toString())
                                        : 'https://via.placeholder.com/150'),
                                    // Replace with actual image URL
                                    backgroundColor: Colors.grey.shade200,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data?.subOwnerDetails?.ownerName ??
                                              "",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.phone,
                                                size: 16, color: Colors.blue),
                                            const SizedBox(width: 4),
                                            Text(
                                              data?.subOwnerDetails
                                                      ?.phoneNumber ??
                                                  "",
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,
                                                size: 16, color: Colors.red),
                                            const SizedBox(width: 4),
                                            Text(
                                              data?.subOwnerDetails?.address ??
                                                  "",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Images Section
                              GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  buildImageCard(
                                      data?.subOwnerDetails
                                          ?.imageNationalIdFrontURL,
                                      context: context),
                                  buildImageCard(
                                      data?.subOwnerDetails
                                          ?.imageNationalIdBackURL,
                                      context: context),
                                ],
                              ),

                              if (model.showAcceptOrRejectOwnerUnit &&
                                  (data?.subOwnerDetails?.isApproved != true &&
                                      data?.subOwnerDetails?.isConfirmed !=
                                          true)) ...[
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: MaterialButton(
                                          color: Colors.green,
                                          onPressed: () {
                                            model
                                                .accept(
                                              context,
                                              id: data?.subOwnerDetails?.id,
                                            )
                                                .then((value) {
                                              model.getUnitOwnerDetails(context,
                                                  id: widget.id);
                                            });
                                          },
                                          child: Text(
                                            "Accept request".tr(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: MaterialButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            reasonController.clear();
                                            openReason = !openReason;
                                            setState(() {});
                                          },
                                          child: Text(
                                            "Reject request".tr(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      child: textFormField(
                                          " سبب رفض ", reasonController, null)),
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
                                          model
                                              .sendReason(context,
                                                  userId:
                                                      data?.subOwnerDetails?.id,
                                                  reason: reasonController.text)
                                              .then((value) {
                                            reasonController.clear();
                                            openReason = false;
                                            model.getUnitOwnerDetails(context,
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
                              ]
                            ],
                          ),
                        ),
                      ),
                    // Unit Owner Data Section
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
                            Text(
                              "Primary Owner Information".tr(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Owner Information Section
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(model
                                              .unitDetailsModel
                                              ?.data
                                              ?.profileImagePath !=
                                          null
                                      ? (AppConstants.BASE_URL_IMAGE +
                                          (model.unitDetailsModel?.data
                                                      ?.profileImagePath ??
                                                  "")
                                              .toString())
                                      : 'https://via.placeholder.com/150'),
                                  // Replace with actual image URL
                                  backgroundColor: Colors.grey.shade200,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data?.ownerName ?? "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.phone,
                                              size: 16, color: Colors.blue),
                                          const SizedBox(width: 4),
                                          Text(
                                            data?.phoneNumber ?? "",
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              size: 16, color: Colors.red),
                                          const SizedBox(width: 4),
                                          Text(
                                            data?.address ?? "",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            //  const SizedBox(height: 16),

                            if (model.unitDetailsModel?.data?.denialReason !=
                                null) ...[
                              const SizedBox(height: 16),
                              RejectionMessageWidget(
                                  rejectionReason: model.unitDetailsModel?.data
                                          ?.denialReason ??
                                      ""),
                            ],
                            const SizedBox(height: 16),
                            // Images Section
                            GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                buildImageCard(data?.imageNationalIdFrontURL,
                                    context: context),
                                buildImageCard(data?.imageNationalIdBackURL,
                                    context: context),
                              ],
                            ),

                            if (model.showAcceptOrRejectOwnerUnit &&
                                (data?.isApproved != true &&
                                    data?.isConfirmed != true)) ...[
                              const SizedBox(height: 16),
                              Row(
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
                                          // if(!model.showAcceptOrRejectOwnerUnit)
                                          // {
                                          //   toast("accept_or_reject_units".tr(),);
                                          // }else
                                          model
                                              .accept(
                                            context,
                                            id: data?.id,
                                          )
                                              .then((value) {
                                            model.getUnitOwnerDetails(context,
                                                id: widget.id);
                                          });
                                        },
                                        child: Text(
                                          "Accept request".tr(),
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
                                          "Reject request".tr(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                                    child: textFormField(
                                        "reason for rejection".tr(),
                                        reasonController,
                                        null)),
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
                                        model
                                            .sendReason(context,
                                                userId: data?.id,
                                                reason: reasonController.text)
                                            .then((value) {
                                          reasonController.clear();
                                          openReason = false;
                                          model.getUnitOwnerDetails(context,
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
                            ]
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Unit Data Section
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        UnitDetails unitDetails = data!.unitDetails![index];
                        return Column(
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    topRight:
                                                        Radius.circular(12),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                        "Unit Model".tr(),
                                                        style: headerStyle(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                      Expanded(
                                                          child: Text(
                                                        "Building Number".tr(),
                                                        style: headerStyle(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                      Expanded(
                                                          child: Text(
                                                        "Round".tr(),
                                                        style: headerStyle(),
                                                        textAlign:
                                                            TextAlign.center,
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        unitDetails.modelName ??
                                                            "",
                                                        style: dataStyle(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        unitDetails
                                                                .buildingName ??
                                                            "",
                                                        style: dataStyle(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        unitDetails.levelName ??
                                                            "",
                                                        style: dataStyle(),
                                                        textAlign:
                                                            TextAlign.center,
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
                                          Column(
                                            children: [
                                              // Header Row
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    topRight:
                                                        Radius.circular(12),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                        "Unit Number".tr(),
                                                        style: headerStyle(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                      Expanded(
                                                          child: Text(
                                                        "Unit type".tr(),
                                                        style: headerStyle(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                      Expanded(
                                                          child: Text(
                                                        "Show Receivables".tr(),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red),
                                                        textAlign:
                                                            TextAlign.right,
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        unitDetails
                                                                .unitNumber ??
                                                            "",
                                                        style: dataStyle(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        unitDetails.unitType ??
                                                            "",
                                                        style: dataStyle(),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: unitDetails
                                                                      .statusID
                                                                      .toString()
                                                                      .trim() ==
                                                                  "1" ||
                                                              unitDetails
                                                                      .statusID
                                                                      .toString()
                                                                      .trim() ==
                                                                  "3"
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                unitDetails.statusID
                                                                            .toString()
                                                                            .trim() ==
                                                                        "3"
                                                                    ? Expanded(
                                                                        child:
                                                                            Text(
                                                                          "access denied"
                                                                              .tr(),
                                                                          style:
                                                                              TextStyle(color: Colors.red),
                                                                        ),
                                                                      )
                                                                    : InkWell(
                                                                        onTap:
                                                                            () {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (dialogContext) => CustomDialogWidgetWithActions(
                                                                                context: dialogContext,
                                                                                title: "confirm".tr(),
                                                                                onYesTap: () {
                                                                                  catchError(
                                                                                      model
                                                                                          .statusForOwnerAndUnit(
                                                                                            context,
                                                                                            ownerUnitOldID: null,
                                                                                            ownerID: unitDetails.ownerUnitsID,
                                                                                            unitID: unitDetails.unitID,
                                                                                            statusID: 3,
                                                                                          )
                                                                                          .then((value) => model.getUnitOwnerDetails(context, id: widget.id)),
                                                                                      "statusForOwnerAndUnit");

                                                                                  Navigator.pop(context);
                                                                                },
                                                                                subtitle: "Are you sure you don't want to accept this unit to this owner?".tr()),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              4.0),
                                                                          child: Icon(
                                                                              Icons.close,
                                                                              color: Colors.red,
                                                                              size: 30),
                                                                        ),
                                                                      ),
                                                                SizedBox(
                                                                    width: 20),
                                                                InkWell(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder: (dialogContext) => CustomDialogWidgetWithActions(
                                                                          context: dialogContext,
                                                                          title: "confirm".tr(),
                                                                          onYesTap: () {
                                                                            Navigator.pop(context);
                                                                            model.checkUnitBelongingToAnotherOwner(context, unitId: unitDetails.unitID).then((value) {
                                                                              print("${widget.id} hereeeee ${value?.toJson()}");
                                                                              if (value?.data.toString() == "2") {
                                                                                model
                                                                                    .statusForOwnerAndUnit(
                                                                                      context,
                                                                                      ownerUnitOldID: null,
                                                                                      ownerID: unitDetails.ownerUnitsID,
                                                                                      ownerDataID: widget.id,
                                                                                      unitID: unitDetails.unitID,
                                                                                      statusID: 2,
                                                                                    )
                                                                                    .then((value) => model.getUnitOwnerDetails(context, id: widget.id))
                                                                                    .catchError((err) {
                                                                                  model.getUnitOwnerDetails(context, id: widget.id);
                                                                                });
                                                                              } else if (value?.data.toString() == "1") {
                                                                                showDialog(
                                                                                  context: context,
                                                                                  builder: (dialogContext) => CustomDialogWidgetWithActions(
                                                                                      context: dialogContext,
                                                                                      title: "confirm".tr(),
                                                                                      onYesTap: () {
                                                                                        model
                                                                                            .statusForOwnerAndUnit(
                                                                                              context,
                                                                                              ownerUnitOldID: value?.data2,
                                                                                              ownerID: unitDetails.ownerUnitsID,
                                                                                              unitID: unitDetails.unitID,
                                                                                              statusID: 2,
                                                                                            )
                                                                                            .then((value) => model.getUnitOwnerDetails(context, id: widget.id));
                                                                                        // Navigator.pop(context);
                                                                                      },
                                                                                      subtitle: "Unit Ali Malik Other Do you want to transfer ownership?".tr()),
                                                                                );
                                                                              }
                                                                            });
                                                                          },
                                                                          subtitle: "Are you sure you want to assign this unit to this owner?".tr()),
                                                                    );
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                    child: Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: Colors
                                                                            .green,
                                                                        size:
                                                                            30),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : InkWell(
                                                              onTap: () {
                                                                openPaymentData =
                                                                    !openPaymentData;
                                                                setState(() {});

                                                                if (openPaymentData) {
                                                                  model.getPaymentData(
                                                                      context,
                                                                      id: unitDetails
                                                                          .unitID,
                                                                      ownerId:
                                                                          unitDetails
                                                                              .ownerID);
                                                                }
                                                              },
                                                              child: Icon(
                                                                  Icons
                                                                      .remove_red_eye_outlined,
                                                                  //color: Colors.red,
                                                                  size: 30),
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
                            if (openPaymentData)
                              model.loading
                                  ? Loading()
                                  : model?.paymentModel?.data == null ||
                                          (model?.paymentModel?.data ?? [])
                                              .isEmpty
                                      ? Text(model.paymentModel?.message ?? "")
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            Payment payment = model!
                                                .paymentModel!.data![index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade200,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          12),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        8.0,
                                                                    horizontal:
                                                                        8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Text(
                                                                      "Type Of Receivable"
                                                                          .tr(),
                                                                      style:
                                                                          headerStyle(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    )),
                                                                    Expanded(
                                                                        child:
                                                                            Text(
                                                                      "Amount"
                                                                          .tr(),
                                                                      style:
                                                                          headerStyle(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    )),
                                                                    Expanded(
                                                                        child:
                                                                            Text(
                                                                      "unit_name"
                                                                          .tr(),
                                                                      style:
                                                                          headerStyle(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    )),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Divider(
                                                                height: 0,
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),

                                                            // Data Row
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          12.0,
                                                                      horizontal:
                                                                          8.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      payment.paymentType ??
                                                                          "",
                                                                      style:
                                                                          dataStyle(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      (payment.value ??
                                                                              "")
                                                                          .toString(),
                                                                      style:
                                                                          dataStyle(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      payment.unitName ??
                                                                          "",
                                                                      style:
                                                                          dataStyle(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
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
                                                        Column(
                                                          children: [
                                                            // Header Row
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade200,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          12),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        8.0,
                                                                    horizontal:
                                                                        8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Text(
                                                                      "Date"
                                                                          .tr(),
                                                                      style:
                                                                          headerStyle(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    )),
                                                                    Expanded(
                                                                        child:
                                                                            Text(
                                                                      "Paid"
                                                                          .tr(),
                                                                      style:
                                                                          headerStyle(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    )),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Divider(
                                                                height: 0,
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),

                                                            // Data Row
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          12.0,
                                                                      horizontal:
                                                                          8.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      payment.createdDate !=
                                                                              null
                                                                          ? (DateConverter.estimatedDate(payment.createdDate!) ?? "")
                                                                              .toString()
                                                                          : "",
                                                                      style:
                                                                          dataStyle(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Switch(
                                                                      value: payment
                                                                              .isPaid ??
                                                                          false,
                                                                      onChanged:
                                                                          (value) {
                                                                        if (value) {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (dialogContext) => CustomDialogWidgetWithActions(
                                                                                context: dialogContext,
                                                                                title: "PaymentConfirmation".tr(),
                                                                                onYesTap: () {
                                                                                  model
                                                                                      .paidOwnerPayment(
                                                                                        context,
                                                                                        id: payment.id,
                                                                                      )
                                                                                      .then(
                                                                                        (value) => model.getPaymentData(context, id: unitDetails.unitID, ownerId: unitDetails.ownerID),
                                                                                      );

                                                                                  Navigator.pop(context);
                                                                                },
                                                                                subtitle: "Are you sure you want to pay this due amount?".tr()),
                                                                          );
                                                                        } else {
                                                                          toast(
                                                                              "Paid".tr());
                                                                        }
                                                                      },
                                                                      activeColor:
                                                                          Colors
                                                                              .blue,
                                                                      activeTrackColor:
                                                                          Colors
                                                                              .lightBlueAccent,
                                                                      inactiveThumbColor:
                                                                          Colors
                                                                              .grey,
                                                                      inactiveTrackColor:
                                                                          Colors
                                                                              .grey[300],
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
                                            );
                                          },
                                          itemCount:
                                              (model.paymentModel?.data ?? [])
                                                  .length,
                                        ),
                          ],
                        );
                      },
                      itemCount: (data?.unitDetails ?? []).length,
                    ),
                    const SizedBox(height: 16),
                    buildRow(
                      "CreatedDate".tr(),
                      (DateConverter.formatDateTimeBasedOnLocale(
                                  data?.createdDate.toString() ?? "",
                                  context) ??
                              "")
                          .toString(),
                    ),
                    data?.modifiedDate == null
                        ? Container()
                        : buildRow(
                            "ModifiedDate".tr(),
                            (data?.modifiedDate ?? ""),
                          ),
                    data?.modifiedByUserName == null
                        ? Container()
                        : buildRow(
                            "ModifiedByUserName".tr(),
                            (data?.modifiedByUserName ?? ""),
                          ),
                    SizedBox(
                      height: 20,
                    ),

                    if (data?.ownershipContract != null &&
                        (!data!.ownershipContract!.contains("No files")))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (data!.ownershipContract!.contains(".pdf")) ...[
                            ContractPdfButton(
                              pdfUrl: data.ownershipContract == null
                                  ? null
                                  : "${AppConstants.BASE_URL_IMAGE}${data.ownershipContract ?? ""}",
                            ),
                          ] else
                            InkWell(
                              onTap: () {
                                showBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: WidgetZoom(
                                          heroAnimationTag: 'tag',
                                          zoomWidget: cachedImage(
                                            data?.ownershipContract ?? "",
                                            width: 150,
                                            height: 150,
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                  width: 180,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrangeAccent,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(child: Text("صورة العقد"))),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          }
        }),
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
