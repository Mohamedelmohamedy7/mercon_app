import 'package:core_project/Model/ALLModelModel.dart';
import 'package:core_project/Model/SuperAdminModels/OwnerManagementModels/user_model.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/validator.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/dashboard_super_admin.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/SnackBarScreen.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Provider/SuperAdminProviders/NotificationForAdminProvider.dart';
import 'package:core_project/helper/ButtonAction.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({
    super.key,
  });

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  TextEditingController contentController = TextEditingController(),
      addressController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  ALLModelModel? selectedModel;
  User? selectOwner;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catchError(
        p_Listeneress<NotificationForAdminProvider>(context)
            .getAllModel(context),
        'getAllModel');
    catchError(
        p_Listeneress<NotificationForAdminProvider>(context)
            .getOwnerUserUnits(context),
        'getOwnerUserUnits');
  }
  bool onlyCompound = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "notification".tr(),
          needBack: true,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Consumer<NotificationForAdminProvider>(
            builder: (context, model, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("notification_msg".tr()),
                    ),
                    textFormField(
                      "address",
                      addressController,
                      null,
                      validation: (value) => Validator.defaultValidator(value),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    textFormField(
                      "content",
                      contentController,
                      null,
                      validation: (value) => Validator.defaultValidator(value),
                    ),
                    SizedBox(height: 8),
                    Text('unit_owner'.tr(),
                        style: CustomTextStyle.semiBold12Black
                            .copyWith(fontSize: 9)),
                    SizedBox(height: 8),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: DropdownButtonFormField<User>(
                        value: selectOwner,
                        decoration: InputDecoration(
                          border: InputBorder.none, // Remove underline
                        ),
                        hint: Text('unit_owner'.tr(),
                            style: CustomTextStyle.semiBold12Black),
                        items: model.ownerUserUnits.map((unitModel) {
                          return DropdownMenuItem<User>(
                            value: unitModel,
                            child: Text(
                                unitModel.name ??
                                    unitModel.nameEn ??
                                    unitModel.nameAr ??
                                    "",
                                style: CustomTextStyle.semiBold12Black),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectOwner = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('selectModel'.tr(),
                        style: CustomTextStyle.semiBold12Black
                            .copyWith(fontSize: 9)),
                    SizedBox(height: 8),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: DropdownButtonFormField<ALLModelModel>(
                        value: selectedModel,
                        decoration: InputDecoration(
                          border: InputBorder.none, // Remove underline
                        ),
                        hint: Text('selectModel'.tr(),
                            style: CustomTextStyle.semiBold12Black),
                        items: model.aLLModelModelList.map((unitModel) {
                          return DropdownMenuItem<ALLModelModel>(
                            value: unitModel,
                            child: Text(unitModel.name,
                                style: CustomTextStyle.semiBold12Black),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedModel = value;
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                     Row(
                       children: [
                        Checkbox(value: onlyCompound, onChanged: (value){
                          onlyCompound = value!;
                          setState(() {});
                        }),
                         Text("Residents of the compound only".tr(),  style: CustomTextStyle.semiBold12Black
                             .copyWith(fontSize: 12)),
                       ],
                     ),
                    const SizedBox(
                      height: 14,
                    ),

                    widgetWithAction.buttonAction<NotificationForAdminProvider>(
                        action: (model) {
                          if (_formKey.currentState!.validate()) {
                            model
                                .sendNotification(
                              context,
                              modelId: selectedModel?.id,
                              toUserId: selectOwner?.id,
                              body: contentController.text,
                              title: addressController.text,
                              onlyCompound: onlyCompound,
                            )
                                .then((value) {
                              popRoute(context: context);
                              if (value.keys.first == true) {
                                showAwesomeSnackbar(
                                  context,
                                  'Success!',
                                  '${value.values.first}',
                                  contentType: ContentType.success,
                                );
                              } else {
                                showAwesomeSnackbar(
                                  context,
                                  'Failure!',
                                  '${value.values.first}',
                                  contentType: ContentType.failure,
                                );
                              }
                            });
                          }
                        },
                        context: context,
                        text: "send"),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
