import 'package:core_project/Provider/ServicesProvider.dart';
import 'package:core_project/View/Screen/paid_and_un_paid_cost.dart';
import 'package:core_project/helper/date_converter.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../Model/PaymentModel.dart';
import '../Widget/MyOrdersWidget/ListOrders.dart';

class TableItem extends StatefulWidget {
  UnitPayment? payment;
  TableItem({
    required this.payment,
  });

  @override
  State<TableItem> createState() => _TableItemState();
}

class _TableItemState extends State<TableItem> {
  void addCosts() {
    for (var e in widget.payment!.ownerPayments) {
      if (e.isPaid.toString() == "true") {
        Provider.of<ServicesProvider>(context, listen: false)
            .addingPaidCost(int.parse(e.value.toString()));
      } else {
        Provider.of<ServicesProvider>(context, listen: false)
            .addingNotPaidCost(int.parse(e.value.toString()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    addCosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    '${widget.payment?.ownerPayments[0].unitName}',
                    style: CustomTextStyle.regular14Black
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        5.height,
       Column(
          children: [
            Table(
              border: TableBorder.all(
                color: Colors.black,
                width: 1,
              ),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "السنة",
                            style: CustomTextStyle.bold14White
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "حالة الدفع",
                            style: CustomTextStyle.bold14White
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'القيمة',
                            style: CustomTextStyle.bold14White
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Table(
              border: TableBorder.all(
                color: Colors.black,
              ),
              children: widget.payment!.ownerPayments.map((e) {
                return TableRow(
                  children: [
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DateConverter.estimatedDate(
                                DateTime.tryParse(e.createdDate)!),
                            style: CustomTextStyle.medium14LightBlack,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e.isPaid.toString() == "true"
                                ? "paid".tr()
                                : "unpaid".tr(),
                            style: CustomTextStyle.medium14LightBlack,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e.value.toString(),
                            style: CustomTextStyle.medium14LightBlack,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }).toList(),
            ),
          ],
        ),
        PaidAndUnPaidCost()
      ]),
    );
  }
}
