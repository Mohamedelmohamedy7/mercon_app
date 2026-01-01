import 'package:core_project/Provider/SuperAdminProviders/TransactionsProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ActionsScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/Transactions/UpdateTransactionScreen.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/SuperAdminWidgets/buildImageCard.dart';
import 'package:core_project/View/Widget/SuperAdminWidgets/build_row.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:core_project/helper/date_converter.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen(
      {super.key, required this.needBack, required this.id});
  final bool needBack;

  final int? id;
  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  bool openReason = false;

  final TextEditingController reasonController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionsProvider>(context, listen: false).notify = false;
    p_Listeneress<TransactionsProvider>(context)
        .getTransactionDetails(context, id: widget.id);
    Provider.of<TransactionsProvider>(context, listen: false).notify = true;
  }

  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "TransactionDetails".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TransactionsProvider>(builder: (context, model, _) {
            if (model.status == LoadingStatus.LOADING) {
              return Center(
                child: Loading(),
              );
            } else if (model.transaction == null && model.first) {
              return Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(child: emptyList()),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Row(
                              //   children: [
                              //     Spacer(),
                              //     IconButton(
                              //       icon: Icon(Icons.edit, color: Colors.grey),
                              //       onPressed: () {
                              //         pushRoute(
                              //           context: context,
                              //           route: UpdateTransactionScreen(
                              //             transaction: model.transaction!,
                              //           ),
                              //         );
                              //       },
                              //     ),
                              //     IconButton(
                              //       icon: Icon(Icons.delete, color: Colors.red),
                              //       onPressed: () => showDialog(
                              //         context: context,
                              //         builder: (dialogContext) =>
                              //             CustomDialogWidgetWithActions(
                              //                 context: dialogContext,
                              //                 title: "confirm".tr(),
                              //                 onYesTap: () {
                              //                   model.deleteTransaction(context,
                              //                       id: model.transaction!.id);
                              //                   Navigator.pop(context);
                              //                 },
                              //                 subtitle: "delete_confirmation".tr()),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              InkWell(
                                onTap: () {
                                  pushRoute(
                                    context: context,
                                    route: TransactionDetailsScreen(
                                      needBack: true,
                                      id: model.transaction?.id,
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(width:200,child: Container(
                                      //  elevation: 2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),

                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: cachedImage(
                                          model.transaction?.attachmentUrl,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    )),
                                    buildRow(
                                      "TransactionType".tr(),
                                      model. transaction?.title ?? "",
                                    ),
                                    buildRow(
                                      "description".tr(),
                                      model. transaction?.description ?? "",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    model. transaction?.createdDate == null ||
                                        model. transaction?.createdDate == "null"
                                        ? Container()
                                        : buildRow(
                                      "createdDate".tr(),
                                      model.transaction!.createdDate!,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
