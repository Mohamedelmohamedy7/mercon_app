import 'package:core_project/Model/SuperAdminModels/VisitAndRentModels/visit_and_rent_model.dart';
import 'package:core_project/Provider/SuperAdminProviders/VisitAndRentProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/VisitAndRentScreens/VisitAndRentDetailsScreen.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Widget/SuperAdminWidgets/build_row.dart';

class VisitAndRentScreen extends StatefulWidget {
  VisitAndRentScreen({super.key, required this.needBack});
  final bool needBack;

  @override
  State<VisitAndRentScreen> createState() => _VisitAndRentScreenState();
}

class _VisitAndRentScreenState extends State<VisitAndRentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<VisitAndRentProviderProvider>(context, listen: false).notify =
        false;
    catchError(
        p_Listeneress<VisitAndRentProviderProvider>(context)
            .getVisitAndRentList(context),
        'VisitAndRentProviderProvider');
    Provider.of<VisitAndRentProviderProvider>(context, listen: false).notify =
        true;
    Provider.of<VisitAndRentProviderProvider>(context, listen: false).first =
        true;
  }

  int? selectedVisitType;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "visit_and_rent_notifications".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            selectedVisitType = null;
            Provider.of<VisitAndRentProviderProvider>(context, listen: false)
                .notify = true;
            Provider.of<VisitAndRentProviderProvider>(context, listen: false)
                .getVisitAndRentList(context);
          },
          child: Consumer<VisitAndRentProviderProvider>(
              builder: (context, model, _) {
            return Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                DropdownButtonFormField(
                                  hint: Text("visit_type".tr()),
                                  value: selectedVisitType,
                                  onChanged: (value) {
                                    // Handle dropdown selection
                                    selectedVisitType = value;
                                  },
                                  items:  [
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Text("visit".tr()),
                                    ),
                                    DropdownMenuItem(
                                      value: 2,
                                      child: Text('rent'.tr()),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 12.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              model.getVisitAndRentList(context,
                                  isRent: selectedVisitType == 2);
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
                              'search'.tr(),
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
                    : model.visitAndRentList.isEmpty && model.first
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
                                    buildVisitAndRentCard(
                                  model.visitAndRentList[index],
                                  model: model,
                                ),
                                itemCount: model.visitAndRentList.length,
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

  Widget buildVisitAndRentCard(VisitAndRent user,
      {required VisitAndRentProviderProvider model}) {
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
                      route: VisitAndRentDetailsScreen(
                        needBack: true,
                        id: user.id,
                      ),
                    );
                  },
                ),
              ],
            ),
            buildRow(
                "unit_owner".tr(), user.name ?? user.nameEn ?? user.nameAr ?? ""),
            buildRow(
              "unit_model".tr(),
              user.unitModelName ?? "",
            ),
            buildRow(
              "entry_date".tr(),
              DateFormat('dd/MM/yyyy').format((DateTime.tryParse(
                      user.entryDateTime ?? (DateTime.now().toString())) ??
                  (DateTime.now()))),
            ),
            buildRow(
              "exit_date".tr(),
              DateFormat('dd/MM/yyyy').format((DateTime.tryParse(
                      user.ckeckOutDateTime ?? (DateTime.now().toString())) ??
                  (DateTime.now()))),
            ),
            buildRow(
                "visitor_count".tr(), (user.totalWithVistiorCount ?? 0).toString()),
            buildRow("visit_type_label".tr(), user.isRent == true ? "rent_label".tr() : "visit_label".tr(),
                color: user.isRent == true ? Colors.blue : Color(0xff826ad6)),
            buildRow(
              "request_status".tr(),
              user.statusName ?? "",
              color: user.statusId == 2
                  ? Color(0xff62b051)
                  : user.statusId == 3
                      ? Color(0xffe6575e)
                      : Color(0xff808080),
            )

            //   Spacer(),
          ],
        ),
      ),
    );
  }
}
