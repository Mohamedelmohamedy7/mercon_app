import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../Model/VisitorsNotExitResponse.dart';
import '../../helper/ImagesConstant.dart';
import '../Widget/comman/CustomAppBar.dart';

class VisitorsNotExitScreen extends StatelessWidget {
  final VisitorsNotExitResponse response;

  const VisitorsNotExitScreen({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'visitors_not_exit'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: response.data == null || response.data!.isEmpty
            ? Center(child: Text("no_data".tr()))
            : ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: response.data!.length,
          itemBuilder: (context, index) {
            final visitor = response.data![index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow("name".tr(), visitor.nameAr ?? visitor.nameEn ?? visitor.name ?? ""),
                    _buildRow("phone".tr(), visitor.phoneNumber ?? "-"),
                    if (visitor.nationalId != null)
                      _buildRow("national_id".tr(), visitor.nationalId!),
                    _buildRow("entry_date".tr(), visitor.entryDateTime?.split("T").first ?? "-"),
                    _buildRow("checkout_date".tr(), visitor.ckeckOutDateTime?.split("T").first ?? "-"),
                    _buildRow("status".tr(), visitor.statusName ?? "-"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
