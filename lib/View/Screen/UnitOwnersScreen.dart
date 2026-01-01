import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../Model/NotApprovedUnitOwnersResponse.dart';
import '../../helper/ImagesConstant.dart';
import '../Widget/comman/CustomAppBar.dart';

class UnitOwnersScreen extends StatelessWidget {
  final NotApprovedUnitOwnersResponse data;

  const UnitOwnersScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'not_approved_unit_owners'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: data.data.isEmpty
            ? Center(child: Text("no_data".tr()))
            : ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: data.data.length,
          itemBuilder: (context, index) {
            final owner = data.data[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow("name".tr(), owner.name ?? ""),
                    _buildRow("phone".tr(), owner.phoneNumber ?? ""),
                    _buildRow("additional_phone".tr(), owner.additionalPhoneNumber ?? ""),
                    _buildRow("address".tr(), owner.permanentAddress ?? ""),
                    _buildRow("active".tr(), owner.isActive == true ? "yes".tr() : "no".tr()),
                    _buildRow("blocked".tr(), owner.isBlocked == true ? "yes".tr() : "no".tr()),
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
