import 'package:core_project/Model/SuperAdminModels/get_gate_logs_model.dart';
import 'package:core_project/Provider/SuperAdminProviders/GetGateLogProvider.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/SuperAdminWidgets/build_row.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GateLogsScreen extends StatefulWidget {
  GateLogsScreen({super.key, required this.needBack});
  final bool needBack;

  @override
  State<GateLogsScreen> createState() => _GateLogsScreenState();
}

class _GateLogsScreenState extends State<GateLogsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    catchError(p_Listeneress<GetGateLogProvider>(context).getGateLog(context),
        'getGateLog');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "gate_logs".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<GetGateLogProvider>(context, listen: false)
                .getGateLog(context);
          },
          child: Consumer<GetGateLogProvider>(builder: (context, model, _) {
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
                    : model.gateModelList.isEmpty
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
                                itemBuilder: (context, index) => buildUserCard(
                                  model.gateModelList[index],
                                  model: model,
                                ),
                                itemCount: model.gateModelList.length,
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

  Widget buildUserCard(GateModel gateModel,
      {required GetGateLogProvider model}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildRow("name".tr(), gateModel.name ?? ""),
            buildRow("status".tr(), gateModel.statusName ?? "",
                color: (gateModel.status == 1 ||
                        gateModel.status == null &&
                            gateModel.statusName == "دخول")
                    ? Color(0xff62b051)
                    : (gateModel.status == 3 ||
                            gateModel.statusName == "مغادرة نهائية")
                        ? Color(0xffe6575e)
                        : Color(0xffef960f)),
            buildRow("type".tr(), gateModel.type ?? ""),
            buildRow(
              "phone_number".tr(),
              (gateModel.phoneNumber ?? ""),
            ),
            buildRow(
              "date".tr(),
              DateFormat('dd/MM/yyyy').format((DateTime.tryParse(
                      gateModel.checkOutDate ?? (DateTime.now().toString())) ??
                  (DateTime.now()))),
            ),
            buildRow(
              "time".tr(),
              DateFormat('hh:mm:ss a').format((DateTime.tryParse(
                      gateModel.checkOutDate ?? (DateTime.now().toString())) ??
                  (DateTime.now()))),
            ),
            buildRow(
              "unit_name".tr(),
              (gateModel.unitName ?? ""),
            ),
            //   Spacer(),
          ],
        ),
      ),
    );
  }
}
