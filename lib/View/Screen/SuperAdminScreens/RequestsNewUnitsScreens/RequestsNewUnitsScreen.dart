import 'package:core_project/Model/SuperAdminModels/RequestsNewUnitsModel/request_list_model.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/RequestsNewUnitsScreens/RequestUnitDetailsScreen.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/SuperAdminWidgets/build_row.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Provider/SuperAdminProviders/RequestsNewUnitsProvider.dart';
import '../../DashBoard/ActionsScreen.dart';

class RequestsNewUnitsScreen extends StatefulWidget {
  RequestsNewUnitsScreen({super.key, required this.needBack});
  final bool needBack;

  @override
  State<RequestsNewUnitsScreen> createState() => _RequestsNewUnitsScreenState();
}

class _RequestsNewUnitsScreenState extends State<RequestsNewUnitsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RequestsNewUnitsProvider>(context, listen: false).notify =
        false;
    catchError(
        p_Listeneress<RequestsNewUnitsProvider>(context)
            .getOwnerUserUnits(context),
        'RequestsNewUnitsProvider');
    Provider.of<RequestsNewUnitsProvider>(context, listen: false).notify = true;
    Provider.of<RequestsNewUnitsProvider>(context, listen: false).first = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "ownership_requests".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<RequestsNewUnitsProvider>(context, listen: false)
                .notify = true;
            Provider.of<RequestsNewUnitsProvider>(context, listen: false)
                .getOwnerUserUnits(context);
          },
          child:
              Consumer<RequestsNewUnitsProvider>(builder: (context, model, _) {
            return Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                    : model.requestNewUnits.isEmpty && model.first
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
                                    buildRequestCard(
                                  model.requestNewUnits[index],
                                  model: model,
                                ),
                                itemCount: model.requestNewUnits.length,
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

  Widget buildRequestCard(RequestModel user,
      {required RequestsNewUnitsProvider model}) {
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
                      route: RequestUnitDetailsScreen(
                        needBack: true,
                        unitId: user.unitID,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (dialogContext) => CustomDialogWidgetWithActions(
                        context: dialogContext,
                        title: "confirm".tr(),
                        onYesTap: () {
                          model.deleteRequest(context, id:  user.unitID);
                          Navigator.pop(context);
                        },
                        subtitle: "delete_confirmation".tr()),
                  ),
                ),
              ],
            ),
            buildRow(
                "name".tr(), user.name ?? user.nameEn ?? user.nameAr ?? ""),
            buildRow(
                "ownership_type".tr(),
                user.unitOwnerTypeId != "1"
                    ? "sub_owner".tr()
                    : "primary_owner".tr(),
                color: user.unitOwnerTypeId != "1"
                    ? Color(0xff808080)
                    : Color(0xff2f96f3)),
            buildRow("address".tr(), user.permanentAddress ?? ""),
            buildRow(
              "phone_number".tr(),
              (user.phoneNumber ?? "") +
                  "\n" +
                  (user.additionalPhoneNumber ?? ""),
            ),




            //   Spacer(),
          ],
        ),
      ),
    );
  }
}
