import 'package:core_project/Model/SuperAdminModels/get_gate_logs_model.dart';
import 'package:core_project/Model/SuperAdminModels/payment_logs_model.dart';
import 'package:core_project/Provider/SuperAdminProviders/PaymentProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/Payment/AddLoadingFinancialDuesScreen.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/SuperAdminWidgets/build_row.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentLogsScreen extends StatefulWidget {
  PaymentLogsScreen({super.key, required this.needBack});
  final bool needBack;

  @override
  State<PaymentLogsScreen> createState() => _PaymentLogsScreenState();
}

class _PaymentLogsScreenState extends State<PaymentLogsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    catchError(p_Listeneress<PaymentProvider>(context).getPaymentLogs(context),
        'getOwnersPaymentLogs');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Loading_Financial_Dues".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<PaymentProvider>(context, listen: false)
                .getPaymentLogs(context);
          },
          child: Consumer<PaymentProvider>(builder: (context, model, _) {
            return Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            route: const AddLoadingFinancialDuesScreen(),
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
                        child: Text(
                          'Add_Expenses'.tr(),
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
                    : model.paymentLogsList.isEmpty&&model.first
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
                                    buildPaymentCard(
                                  model.paymentLogsList[index],
                                  model: model,
                                ),
                                itemCount: model.paymentLogsList.length,
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

  Widget buildPaymentCard(PaymentLog paymentLog,
      {required PaymentProvider model}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildRow("Type_Of_Receivable".tr(), paymentLog.paymentType ?? ""),
            buildRow(
              "unit".tr(),
              paymentLog.recivedType ?? "",
            ),
            buildRow("Amount".tr(), (paymentLog.amount ?? "").toString()),
            buildRow(
              "date".tr(),
              DateFormat('dd-MM-yyyy').format((DateTime.tryParse(
                      paymentLog.createdDate ?? (DateTime.now().toString())) ??
                  (DateTime.now()))),
            ),

            //   Spacer(),
          ],
        ),
      ),
    );
  }
}
