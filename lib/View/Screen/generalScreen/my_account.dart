import 'package:core_project/Provider/UnitsProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../helper/ImagesConstant.dart';
import '../../../helper/app_constants.dart';
import '../../Widget/MyOrdersWidget/ListOrders.dart';
import '../../Widget/comman/CustomAppBar.dart';
import '../../Widget/comman/comman_Image.dart';
import '../add_new_unit.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  UnitsProvider? unitsProvider;

  @override
  void initState() {
    super.initState();
    unitsProvider = Provider.of<UnitsProvider>(context, listen: false);
    unitsProvider!.getMyUnitNumber(context);
  }

  @override
  Widget build(BuildContext context) {
    final units = Provider.of<UnitsProvider>(context).modelUnitServiceListAndContainPending;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'personAccount'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // PROFILE SECTION
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: globalAccountData.getProfilePic() == null ||
                    globalAccountData.getProfilePic() == ""
                    ? AssetImage("assets/images/person.png") as ImageProvider
                    : NetworkImage(AppConstants.BASE_URL_IMAGE + globalAccountData.getProfilePic()!),
              ),
              10.height,
              Text(globalAccountData.getUsername()??"", style: CustomTextStyle.bold18black),
              Text(globalAccountData.getEmail()??"", style: CustomTextStyle.medium14Gray),
              Text(globalAccountData.getPhoneNumber()??"", style: CustomTextStyle.medium14Gray),
              20.height,

              // UNITS HEADER
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "${'your_units'.tr()} :",
                  style: CustomTextStyle.bold14black.copyWith(fontSize: 14),
                ),
              ),
              10.height,

              // UNITS LIST
              units.isEmpty
                  ? Padding(
                padding: EdgeInsets.only(top: 40),
                child: emptyList(),
              )
                  : ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: units.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final unit = units[index];
                  return Card(
                    elevation: 6,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    clipBehavior: Clip.antiAlias,
                    child: SizedBox(
                      height: 140,
                      child: Row(
                        children: [

                          /// IMAGE SIDE
                          Stack(
                            children: [
                              Image.asset(
                                "assets/images/home1.jpg", // غيرها حسب مشروعك
                                width: 130,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: 130,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.2),
                                      Colors.black.withOpacity(0.55),
                                    ],
                                  ),
                                ),
                              ),

                              /// STATUS
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                  margin:EdgeInsets.all(10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 4),
                                  decoration: BoxDecoration(
                                    color:Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      5.width,
                                      Icon(
                                        unit.statusName == "Active"
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        size: 14,
                                        color: unit.statusName == "Active"
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      4.width,
                                      Text(
                                        unit.statusName == "Active"
                                            ? "Active"
                                            : "Inactive",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: unit.statusName == "Active"
                                              ? Colors.green.shade800
                                              : Colors.red.shade800,
                                        ),
                                      ),
                                      5.width,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// CONTENT SIDE
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  _infoRow(
                                    icon: Icons.account_balance,
                                    title: "model".tr(),
                                    value: unit.modelName,
                                  ),
                                  _infoRow(
                                    icon: Icons.home,
                                    title: "building_number".tr(),
                                    value: unit.buildingName,
                                  ),

                                  _infoRow(
                                    icon: Icons.layers_outlined,
                                    title: "levels".tr(),
                                    value: unit.levelName,
                                    trailing: Row(
                                      children: [
                                        Icon(Icons.home_work_outlined,
                                            size: 16,
                                            color: Theme.of(context).primaryColor),
                                        4.width,
                                        Text(
                                          unit.unitNumber,
                                          style: CustomTextStyle.bold14black,
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



                },
              ),
              20.height,
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16),
          child: GestureDetector(
            onTap: () {
              pushRoute(context: context, route: AddNewUnit());
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 18, color: Colors.white),
                    6.width,
                    Text(
                      "add_new_unit".tr(),
                      style: CustomTextStyle.bold14White.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
    Widget? trailing,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: Colors.grey.shade100,
          child: Icon(icon, size: 16, color: Colors.grey.shade700),
        ),
        8.width,
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title: ",
                  style: CustomTextStyle.medium14Black,
                ),
                TextSpan(
                  text: value,
                  style: CustomTextStyle.bold14black,
                ),
              ],
            ),
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

}
