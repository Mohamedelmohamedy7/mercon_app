import 'package:core_project/Model/SuperAdminModels/unit_details_model.dart';
import 'package:core_project/Provider/SuperAdminProviders/OwnersManagementProvider.dart';
import 'package:core_project/Provider/SuperAdminProviders/RequestsNewUnitsProvider.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ActionsScreen.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/View/Widget/comman/show_full_image.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestUnitDetailsScreen extends StatefulWidget {
  const RequestUnitDetailsScreen(
      {super.key, required this.needBack, required this.unitId});
  final bool needBack;

  final int? unitId;
  @override
  State<RequestUnitDetailsScreen> createState() =>
      _RequestUnitDetailsScreenState();
}

class _RequestUnitDetailsScreenState extends State<RequestUnitDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RequestsNewUnitsProvider>(context, listen: false).notify =
        false;
    p_Listeneress<RequestsNewUnitsProvider>(context)
        .getRequestUnitOwnerDetails(context, unitId: widget.unitId);
    Provider.of<RequestsNewUnitsProvider>(context, listen: false).notify = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "detailsRequestTitle".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Consumer<RequestsNewUnitsProvider>(builder: (context, model, _) {
          if (model.status == LoadingStatus.LOADING) {
            return Center(
              child: Loading(),
            );
          } else if (model.unitDetailsModel?.data == null) {
            return Center(child: emptyList());
          } else {
            return Consumer<OwnersManagementProvider>(
                builder: (context, oModel, _) {
              Data? data = model.unitDetailsModel?.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                "Property applicant data".tr(),
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
                                        : 'https://via.placeholder.com/150'), // Replace with actual image URL
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
                                            Expanded(
                                              child: Text(
                                                data?.address ?? "",
                                              ),
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
                                  buildImageCard(data?.imageNationalIdFrontURL),
                                  buildImageCard(data?.imageNationalIdBackURL),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (data?.oldOwnerName != null ||
                          data?.oldPhoneNumber != null ||
                          data?.oldAddress != null ||
                          data?.oldImageNationalIdBackURL != null ||
                          data?.oldImageNationalIdFrontURL != null)
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
                                  "Current Unit Owner Information".tr(),
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data?.oldOwnerName ?? "",
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
                                                data?.oldPhoneNumber ?? "",
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on,
                                                  size: 16, color: Colors.red),
                                              const SizedBox(width: 4),
                                              Text(
                                                data?.oldAddress ?? "",
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
                                        data?.oldImageNationalIdFrontURL),
                                    buildImageCard(
                                        data?.oldImageNationalIdBackURL),
                                  ],
                                ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
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
                                                          "Building Number",
                                                          style: headerStyle(),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                        Expanded(
                                                            child: Text(
                                                          "levels".tr(),
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
                                                    color:
                                                        Colors.grey.shade300),

                                                // Data Row
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 12.0,
                                                      horizontal: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          unitDetails
                                                                  .modelName ??
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
                                                          unitDetails
                                                                  .levelName ??
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
                                                          "unitsNum".tr(),
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
                                                          "Show Receivables"
                                                              .tr(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.red),
                                                          textAlign:
                                                              TextAlign.right,
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                    height: 0,
                                                    color:
                                                        Colors.grey.shade300),

                                                // Data Row
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
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
                                                          unitDetails
                                                                  .unitType ??
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
                                                                  "5"
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (dialogContext) => CustomDialogWidgetWithActions(
                                                                              context: dialogContext,
                                                                              title: "confirm".tr(),
                                                                              onYesTap: () {
                                                                                oModel
                                                                                    .statusForOwnerAndUnit(
                                                                                      context,
                                                                                      ownerUnitOldID: null,
                                                                                      ownerID: unitDetails.ownerUnitsID,
                                                                                      unitID: unitDetails.unitID,
                                                                                      statusID: 3,
                                                                                    )
                                                                                    .then((value) => model.getRequestUnitOwnerDetails(context, unitId: widget.unitId));

                                                                                Navigator.pop(context);
                                                                              },
                                                                              subtitle: "confirm_accept_unit".tr()),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Icon(
                                                                            Icons
                                                                                .close,
                                                                            color:
                                                                                Colors.red,
                                                                            size: 30),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            20),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (dialogContext) => CustomDialogWidgetWithActions(
                                                                              context: dialogContext,
                                                                              title: "confirm".tr(),
                                                                              onYesTap: () {
                                                                                Navigator.pop(context);
                                                                                oModel.checkUnitBelongingToAnotherOwner(context, unitId: unitDetails.unitID).then((value) {
                                                                                  print("hereeeee ${value?.toJson()}");
                                                                                  if (value?.data.toString() == "2") {
                                                                                    oModel
                                                                                        .statusForOwnerAndUnit(
                                                                                          context,
                                                                                          ownerUnitOldID: null,
                                                                                          ownerID: unitDetails.ownerUnitsID,
                                                                                          unitID: unitDetails.unitID,
                                                                                          statusID: 2,
                                                                                        )
                                                                                        .then((value) => model.getRequestUnitOwnerDetails(context, unitId: widget.unitId));
                                                                                  } else if (value?.data.toString() == "1") {
                                                                                    showDialog(
                                                                                      context: context,
                                                                                      builder: (dialogContext) => CustomDialogWidgetWithActions(
                                                                                          context: dialogContext,
                                                                                          title: "confirm".tr(),
                                                                                          onYesTap: () {
                                                                                            oModel
                                                                                                .statusForOwnerAndUnit(
                                                                                                  context,
                                                                                                  ownerUnitOldID: value?.data2,
                                                                                                  ownerID: unitDetails.ownerUnitsID,
                                                                                                  unitID: unitDetails.unitID,
                                                                                                  statusID: 2,
                                                                                                )
                                                                                                .then((value) => model.getRequestUnitOwnerDetails(context, unitId: widget.unitId));
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          subtitle: "confirm_transfer".tr()),
                                                                                    );
                                                                                  }
                                                                                });
                                                                              },
                                                                              subtitle: "are_you_sure_you_want_to_assign_this_unit".tr()),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child: Icon(
                                                                            Icons
                                                                                .check,
                                                                            color:
                                                                                Colors.green,
                                                                            size: 30),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Container()),
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
                            ],
                          );
                        },
                        itemCount: (data?.unitDetails ?? []).length,
                      ),
                    ],
                  ),
                ),
              );
            });
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

  Widget buildImageCard(String? imageUrl) {
    return GestureDetector(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: cachedImage(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
      onTap: () {
        showImagePopup(context, imageUrl);
      },
    );
  }
}
