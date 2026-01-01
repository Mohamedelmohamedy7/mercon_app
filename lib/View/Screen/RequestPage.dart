import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../Model/newRequestModel.dart';
import '../../helper/ImagesConstant.dart';
import '../Widget/comman/CustomAppBar.dart';

class RequestPageScreen extends StatelessWidget {
  final RequestResponse requestPage;

  const RequestPageScreen({super.key, required this.requestPage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'requests'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: requestPage.data.isEmpty
            ? Center(child: Text("no_data".tr()))
            : ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: requestPage.data.length,
          itemBuilder: (context, index) {
            final request = requestPage.data[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow("owner_name".tr(), request.ownerName),
                    _buildRow("details".tr(), request.details),
                    _buildRow("price".tr(), "${request.price}"),
                    _buildRow("unit_id".tr(), "${request.unitID}"),
                    _buildRow("status_id".tr(), "${request.statusID}"),
                    _buildRow("created_at".tr(), request.createdDate.split("T").first),
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
