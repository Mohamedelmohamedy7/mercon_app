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
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // MODEL
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                                child: Icon(Icons.account_balance, color: Theme.of(context).primaryColor, size: 16),
                              ),
                              8.width,
                              Text("model".tr() + ": ", style: CustomTextStyle.medium14Black),
                              Flexible(child: Text(unit.modelName, style: CustomTextStyle.bold14black, overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                          8.height,

                          // BUILDING
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                                child: Icon(Icons.home_outlined, color: Theme.of(context).primaryColor, size: 16),
                              ),
                              8.width,
                              Text("builds".tr() + ": ", style: CustomTextStyle.medium14Black),
                              Flexible(child: Text(unit.buildingName, style: CustomTextStyle.bold14black, overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                          8.height,

                          // LEVELS & UNITS
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                                child: Icon(Icons.add_business_outlined, color: Theme.of(context).primaryColor, size: 16),
                              ),
                              8.width,
                              Text("levels".tr() + ": ", style: CustomTextStyle.medium14Black),
                              Text(unit.levelName, style: CustomTextStyle.bold14black),
                              Spacer(),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                                child: Icon(Icons.ad_units, color: Theme.of(context).primaryColor, size: 16),
                              ),
                              8.width,
                              Text("units".tr() + ": ", style: CustomTextStyle.medium14Black),
                              Text(unit.unitNumber, style: CustomTextStyle.bold14black),
                            ],
                          ),
                          8.height,

                          // STATUS
                          Row(
                            children: [
                              Text("case".tr() + ": ", style: CustomTextStyle.medium14Black),
                              SizedBox(width: 6),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: unit.statusName == "Active" ? Colors.green.shade100 : Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  unit.statusName == "Active" ? "Active ✅" : "Inactive ❌",
                                  style: TextStyle(
                                    color: unit.statusName == "Active" ? Colors.green.shade800 : Colors.red.shade800,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
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
}
