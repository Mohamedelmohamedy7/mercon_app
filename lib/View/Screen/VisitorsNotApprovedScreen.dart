import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../Model/VisitorsNotApprovedResponse.dart';
import '../../helper/ImagesConstant.dart';
import '../Widget/comman/CustomAppBar.dart';

class VisitorsNotApprovedScreen extends StatelessWidget {
  final VisitorsNotApprovedResponse response;

  const VisitorsNotApprovedScreen({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'visitors_not_approved'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: ListView.builder(
          itemCount: response.data.length,
          itemBuilder: (context, index) {
            final visitor = response.data[index];
            return Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${"name".tr()}: ${visitor.name ?? visitor.nameAr ?? ''}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text("${"phone".tr()}: ${visitor.phoneNumber}"),
                    Text("${"entry_date".tr()}: ${visitor.entryDateTime}"),
                    Text("${"checkout".tr()}: ${visitor.isCheckout ? 'yes'.tr() : 'no'.tr()}"),
                    Text("${"status".tr()}: ${visitor.statusName}"),
                    if (visitor.email != null)
                      Text("${"email".tr()}: ${visitor.email}"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
