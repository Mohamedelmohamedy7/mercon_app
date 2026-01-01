import 'package:core_project/Model/SuperAdminModels/Transactions/get_all_transactions.dart';
import 'package:core_project/Provider/SuperAdminProviders/TransactionsProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/ActionsScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/Transactions/AddTransactionScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/Transactions/TransactionDetailsScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/Transactions/UpdateTransactionScreen.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/SuperAdminWidgets/buildImageCard.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Widget/SuperAdminWidgets/build_row.dart';

class TransactionsListScreen extends StatefulWidget {
  TransactionsListScreen({super.key, required this.needBack});
  final bool needBack;

  @override
  State<TransactionsListScreen> createState() => _TransactionsListScreenState();
}

class _TransactionsListScreenState extends State<TransactionsListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionsProvider>(context, listen: false).notify = false;
    catchError(
        p_Listeneress<TransactionsProvider>(context)
            .getTransactionsList(context),
        'TransactionsProvider');
    Provider.of<TransactionsProvider>(context, listen: false).notify = true;
    Provider.of<TransactionsProvider>(context, listen: false).first = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "transactions".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<TransactionsProvider>(context, listen: false).notify =
                true;
            Provider.of<TransactionsProvider>(context, listen: false)
                .getTransactionsList(context);
          },
          child: Consumer<TransactionsProvider>(builder: (context, model, _) {
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
                            route: const AddTransactionScreen(),
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
                          'AddTransaction'.tr(),
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
                    : model.transactionsList.isEmpty && model.first
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
                                    //     buildCompliantCard(
                                    //   model.complaintList[index],
                                    //   model: model,
                                    // ),
                                    buildTransactionCard(
                                  model.transactionsList[index],
                                  model: model,
                                ),
                                itemCount: model.transactionsList.length,
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

  Widget buildTransactionCard(Transaction transaction,
      {required TransactionsProvider model}) {
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
                      route: UpdateTransactionScreen(
                        transaction: transaction,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (dialogContext) =>
                        CustomDialogWidgetWithActions(
                            context: dialogContext,
                            title: "confirm".tr(),
                            onYesTap: () {
                              model.deleteTransaction(context,
                                  id: transaction.id);
                              Navigator.pop(context);
                            },
                            subtitle: "delete_confirmation".tr()),
                  ),
                ),
              ],
            ),

            InkWell(
              onTap: () {
                pushRoute(
                  context: context,
                  route: TransactionDetailsScreen(
                    needBack: true,
                    id: transaction.id,
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
                        transaction.attachmentUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )),
                  buildRow(
                    "TransactionType".tr(),
                    transaction.title ?? "",
                  ),
                  // buildRow(
                  //   "description".tr(),
                  //   transaction.description ?? "",
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  transaction.createdDate == null ||
                          transaction.createdDate == "null"
                      ? Container()
                      : buildRow(
                          "createdDate".tr(),
                          transaction.createdDate!,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
