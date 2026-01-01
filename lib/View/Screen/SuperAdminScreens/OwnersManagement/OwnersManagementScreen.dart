import 'package:core_project/Model/SuperAdminModels/OwnerManagementModels/search_model.dart';
import 'package:core_project/Model/SuperAdminModels/OwnerManagementModels/user_model.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/Utill/validator.dart';
import 'package:core_project/View/Screen/DashBoard/ActionsScreen.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/OwnersManagement/OwnerDetailsScreen.dart';
import 'package:core_project/View/Widget/MyOrdersWidget/ListOrders.dart';
import 'package:core_project/View/Widget/SuperAdminWidgets/build_row.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../Provider/SuperAdminProviders/OwnersManagementProvider.dart';

class OwnersManagementScreen extends StatefulWidget {
  OwnersManagementScreen({super.key, required this.needBack});
  final bool needBack;

  @override
  State<OwnersManagementScreen> createState() => _OwnersManagementScreenState();
}

class _OwnersManagementScreenState extends State<OwnersManagementScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OwnersManagementProvider>(context, listen: false).notify =
        false;
    catchError(
        p_Listeneress<OwnersManagementProvider>(context)
            .getOwnerUserUnits(context),
        'OwnersManagementProvider');
    Provider.of<OwnersManagementProvider>(context, listen: false).notify = true;
    Provider.of<OwnersManagementProvider>(context, listen: false).first = true;
    nameController.addListener(() {
      Provider.of<OwnersManagementProvider>(context, listen: false)
          .changeSearchKey();
    });
    phoneController.addListener(() {
      Provider.of<OwnersManagementProvider>(context, listen: false)
          .changeSearchKey();
    });
    nIdController.addListener(() {
      Provider.of<OwnersManagementProvider>(context, listen: false)
          .changeSearchKey();
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "owners_management".tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<OwnersManagementProvider>(context, listen: false)
                .changeSearchKey();
            nameController.clear();
            phoneController.clear();
            nIdController.clear();
            Provider.of<OwnersManagementProvider>(context, listen: false)
                .notify = true;
            Provider.of<OwnersManagementProvider>(context, listen: false)
                .getOwnerUserUnits(context);
          },
          child:
              Consumer<OwnersManagementProvider>(builder: (context, model, _) {
            return Column(
              //  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    textFormField(
                      "First name".tr(),
                      nameController,
                      null,
                      validation: (value) => Validator.name(value),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: textFormField(
                            "Phone Number".tr(),
                            phoneController,
                            null,
                            validation: (value) => Validator.numbers(value),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: textFormField(
                            "National Number".tr(),
                            nIdController,
                            null,
                            validation: (value) => Validator.numbers(value),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: model.search
                              ? IconButton(
                                  onPressed: () {
                                    nIdController.clear();
                                    nameController.clear();
                                    phoneController.clear();
                                    model.getOwnerUserUnits(
                                      context,
                                    );
                                  },
                                  icon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Icon(Icons.close,
                                        color: Colors.white),
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    model.getOwnerUserUnitsSearch(context,
                                        model: SearchModel(
                                          name: nameController.text,
                                          nationalId: nIdController.text,
                                          phoneNumber: phoneController.text,
                                        ));
                                  },
                                  icon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Icon(Icons.search,
                                        color: Colors.white),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
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
                    : model.ownerUserUnits.isEmpty && model.first
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
                                itemBuilder: (context, index) => buildUserCard(
                                  model.ownerUserUnits[index],
                                  model: model,
                                ),
                                itemCount: model.ownerUserUnits.length,
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

  Widget buildUserCard(User user, {required OwnersManagementProvider model}) {
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
                      route: OwnerDetailsScreen(
                        needBack: true,
                        id: user.id,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (dialogContext) => CustomDialogWidgetWithActions(
                        context: dialogContext,
                        title: "confirm".tr(),
                        onYesTap: () {
                          model.deleteUser(context, id: user.id);
                          Navigator.pop(context);
                        },
                        subtitle: "delete_confirmation".tr()),
                  ),
                ),
              ],
            ),
            buildRow("name".tr(), user.name ?? ""),
            buildRow("ownership_type".tr(),
                user.unitOwnerTypeId != "1" ? "sub_owner".tr() : "primary_owner".tr(),
                color: user.unitOwnerTypeId != "1"
                    ? Color(0xff808080)
                    : Color(0xff2f96f3)),
            buildRow("address".tr(), user.permanentAddress ?? ""),
            buildRow(
              "phone_number".tr(),
              (user.phoneNumber ?? "") +
                  "\n" +
                  (user.additionalPhoneNumber ?? ""),
            ),
            buildRow(
              "status".tr(),
              user.isBlocked == true
                  ? "blocked".tr()
                  : user.isApproved == true
                      ? "active".tr()
                      : "pending".tr(),
              color: user.isBlocked == true
                  ? Color(0xffe6575e)
                  : user.isApproved == true
                      ? Color(0xff62b051)
                      : Color(0xffef960f),
              onTap: () => user.isBlocked == true || user.isApproved == true
                  ? showDialog(
                      context: context,
                      builder: (dialogContext) => CustomDialogWidgetWithActions(
                          context: dialogContext,
                          title: user.isBlocked == true
                              ? "unblock_user".tr()
                              : "block_user".tr(),
                          onYesTap: () {
                            model.blockOrUnBlockUser(context, id: user.id);
                            Navigator.pop(context);
                          },
                          subtitle: user.isBlocked == true
                              ? "unblock_confirmation".tr()
                              : "block_confirmation".tr()),
                    )
                  : null,
            ),

            //   Spacer(),
          ],
        ),
      ),
    );
  }
}
