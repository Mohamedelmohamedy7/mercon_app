import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../Model/RentRequestModel.dart';
import '../../helper/ImagesConstant.dart';
import '../Widget/comman/CustomAppBar.dart';

class RentRequestsScreen extends StatelessWidget {
  final RentNotApprovedResponse rentData;

  const RentRequestsScreen({super.key, required this.rentData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'rents_not_approved'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: rentData.data == null || rentData.data!.isEmpty
            ? Center(child: Text("no_data".tr()))
            : ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: rentData.data!.length,
          itemBuilder: (context, index) {
            final item = rentData.data![index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow("name".tr(), item.nameAr ?? item.nameEn ?? "-"),
                    _buildRow("phone".tr(), item.phoneNumber ?? "-"),
                    _buildRow("national_id".tr(), item.nationalId ?? "-"),
                    _buildRow("status".tr(), item.statusName ?? "-"),
                    _buildRow("entry_date".tr(), item.entryDateTime?.split('T').first ?? "-"),
                    _buildRow("checkout_date".tr(), item.ckeckOutDateTime?.split('T').first ?? "-"),
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
          Text(
            "$title: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
