import 'package:core_project/Model/ALLModelModel.dart';
import 'package:core_project/Model/BuildingModel.dart';
import 'package:core_project/Model/SuperAdminModels/get_all_payment_type.dart';
import 'package:core_project/Model/UnitModel.dart';
import 'package:core_project/Model/LevelModel.dart';
import 'package:core_project/Provider/UnitsProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/validator.dart';
import 'package:core_project/View/Screen/SuperAdminScreens/dashboard_super_admin.dart';
import 'package:core_project/View/Widget/DropDownWidgets.dart';
import 'package:core_project/View/Widget/comman/CustomAppBar.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/SnackBarScreen.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../../../Provider/SuperAdminProviders/PaymentProvider.dart';
import 'package:core_project/helper/ButtonAction.dart';

class AddLoadingFinancialDuesScreen extends StatefulWidget {
  const AddLoadingFinancialDuesScreen({
    super.key,
  });

  @override
  State<AddLoadingFinancialDuesScreen> createState() =>
      _AddLoadingFinancialDuesScreenState();
}

class _AddLoadingFinancialDuesScreenState
    extends State<AddLoadingFinancialDuesScreen> {
  TextEditingController descriptionController = TextEditingController(),
      amountController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  UnitsProvider? unitsProvider;

  ALLModelModel? selectedModel;
  BuildingModel? buildingModel;
  LevelModel? levelModel;
  UnitModel? unitModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    unitsProvider = Provider.of<UnitsProvider>(context, listen: false);
    unitsProvider?.getAllModel(context, comId: null);
    catchError(p_Listeneress<PaymentProvider>(context).getPaymentTypes(context),
        'getPaymentTypes');
  }

  @override
  void dispose() {
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }

  bool isChecked = false;
  PaymentType? selectedPaymentType;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Add_Expenses".tr(),
          needBack: true,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Consumer<PaymentProvider>(builder: (context, model, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'select_unit'.tr(),
                      style: TextStyle(
                          fontSize: 22, color: Theme.of(context).primaryColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            selectedModel = null;
                            buildingModel = null;
                            levelModel = null;
                            unitModel = null;

                            unitsProvider?.buildingList = [];
                            unitsProvider?.levelList = [];
                            unitsProvider?.unitList = [];
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Text(
                          'all_units'.tr(),
                          style: TextStyle(fontSize: 18),
                        ),
                        if (isChecked) ...[
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Color(
                                    0xFFFFF4CC), // Light yellow background color
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                'The_allowance_will_be_sent_to_all_units'.tr(),
                                style: TextStyle(
                                  color: Colors
                                      .brown, // Text color similar to the example
                                  fontSize:
                                      16.0, // Adjust font size to match design
                                  fontWeight: FontWeight
                                      .w600, // Make text slightly bold
                                ),
                                textAlign: TextAlign
                                    .right, // Align text to the right for Arabic
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    ModelSelectionDropdowns(
                      fromLoadPaymentWidget:
                          (buildingModel == null && selectedModel != null)
                              ? Container(
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFFFFF4CC), // Light yellow background color
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    'The_expenses_will_be_charged_to_all_units_in_this_model'
                                        .tr(),
                                    style: TextStyle(
                                      color: Colors
                                          .brown, // Text color similar to the example
                                      fontSize:
                                          16.0, // Adjust font size to match design
                                      fontWeight: FontWeight
                                          .w600, // Make text slightly bold
                                    ),
                                    textAlign: TextAlign
                                        .right, // Align text to the right for Arabic
                                  ),
                                )
                              : null,
                      enable: !isChecked,
                      selectedModel: selectedModel,
                      buildingModel: buildingModel,
                      levelModel: levelModel,
                      unitModel: unitModel,
                      isRegister: true,
                      onSelectModel: (value) async {
                        setState(() {
                          selectedModel = value;
                          buildingModel = null;
                          levelModel = null;
                          unitModel = null;
                        });
                        await unitsProvider?.getAllBuilding(
                            context, selectedModel!.id.toString());
                      },
                      onSelectBuilding: (value) {
                        setState(() {
                          buildingModel = value;
                          levelModel = null;
                          unitModel = null;
                        });
                        unitsProvider?.getAllLevel(
                            context, buildingModel!.id.toString());
                      },
                      onSelectLevel: (value) {
                        setState(() {
                          levelModel = value;
                          unitModel = null;
                        });
                        unitsProvider?.getUnitModel(
                          context,
                          levelModel!.id.toString(),
                          isLogin: false,
                          addNewUnit: true,
                        );
                      },
                      onSelectUnits: (value) {
                        setState(() {
                          unitModel = value;
                          print("hhhh");
                        });
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      'add_ex'.tr(),
                      style: TextStyle(
                          fontSize: 22, color: Theme.of(context).primaryColor),
                    ),
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
                      child: DropdownButtonFormField<PaymentType>(
                        value: selectedPaymentType,
                        decoration: InputDecoration(
                          border: InputBorder.none, // Remove underline
                        ),
                        hint: Text('Type_Of_Receivable'.tr(),
                            style: CustomTextStyle.semiBold12Black),
                        items: model.paymentTypesList.map((unitModel) {
                          return DropdownMenuItem<PaymentType>(
                            value: unitModel,
                            child: Text(unitModel.name ?? "",
                                style: CustomTextStyle.semiBold12Black),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedPaymentType = value;
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    textFormField(
                      "amount".tr(),
                      amountController,
                      null,
                      validation: (value) => Validator.priceValidator(value),
                    ),
                    SizedBox(height: 8),
                    textFormField(
                      "description",
                      descriptionController,
                      null,
                      validation: (value) => Validator.defaultValidator(value),
                    ),
                    30.height,
                    widgetWithAction.buttonAction<PaymentProvider>(
                        action: (model) {
                          if (_formKey.currentState!.validate()) {
                            if (isChecked) {
                              if (selectedPaymentType == null) {
                                showAwesomeSnackbar(
                                  context,
                                  'Error!',
                                  '${"please_select_payment".tr()}',
                                  contentType: ContentType.failure,
                                );
                              } else {
                                model
                                    .addOwnerUnitPayment(
                                  context,
                                  unitModelId: selectedModel?.id,
                                  buildingNumberId: buildingModel?.id,
                                  unitId: unitModel?.id,
                                  levelId: levelModel?.id,
                                  //  recivedType: "",
                                  paymentTypeId: selectedPaymentType?.id,
                                  isAllUnits: isChecked,
                                  description: descriptionController.text,
                                  value: amountController.text,
                                )
                                    .then((value) {
                                  if (value != null) {
                                    popRoute(context: context);
                                  //  popRoute(context: context);
                                    showAwesomeSnackbar(
                                      context,
                                      'Success!',
                                      '${value}',
                                      contentType: ContentType.success,
                                    );
                                  }
                                });
                              }
                            } else {
                              if (selectedModel == null) {
                                showAwesomeSnackbar(
                                  context,
                                  'Error!',
                                  '${"selectModel".tr()}',
                                  contentType: ContentType.failure,
                                );
                              } else {
                                if (buildingModel != null) {
                                  if (levelModel == null) {
                                    showAwesomeSnackbar(
                                      context,
                                      'Error!',
                                      '${"please_select_level".tr()}',
                                      contentType: ContentType.failure,
                                    );
                                  } else if (unitModel == null) {
                                    showAwesomeSnackbar(
                                      context,
                                      'Error!',
                                      '${"selectUnit".tr()}',
                                      contentType: ContentType.failure,
                                    );
                                  }else{
                                    if (selectedPaymentType == null) {
                                      showAwesomeSnackbar(
                                        context,
                                        'Error!',
                                        '${"please_select_payment".tr()}',
                                        contentType: ContentType.failure,
                                      );
                                    } else {
                                      model
                                          .addOwnerUnitPayment(
                                        context,
                                        unitModelId: selectedModel?.id,
                                        buildingNumberId: buildingModel?.id,
                                        unitId: unitModel?.id,
                                        levelId: levelModel?.id,
                                        //  recivedType: "",
                                        paymentTypeId: selectedPaymentType?.id,
                                        isAllUnits: isChecked,
                                        description: descriptionController.text,
                                        value: amountController.text,
                                      )
                                          .then((value) {
                                        if (value != null) {
                                          popRoute(context: context);
                                          //      popRoute(context: context);
                                          showAwesomeSnackbar(
                                            context,
                                            'Success!',
                                            '${value}',
                                            contentType: ContentType.success,
                                          );
                                        }
                                      });
                                    }
                                  }
                                } else {
                                  if (selectedPaymentType == null) {
                                    showAwesomeSnackbar(
                                      context,
                                      'Error!',
                                      '${"please_select_payment".tr()}',
                                      contentType: ContentType.failure,
                                    );
                                  } else {
                                    model
                                        .addOwnerUnitPayment(
                                      context,
                                      unitModelId: selectedModel?.id,
                                      buildingNumberId: buildingModel?.id,
                                      unitId: unitModel?.id,
                                      levelId: levelModel?.id,
                                      //  recivedType: "",
                                      paymentTypeId: selectedPaymentType?.id,
                                      isAllUnits: isChecked,
                                      description: descriptionController.text,
                                      value: amountController.text,
                                    )
                                        .then((value) {
                                      if (value != null) {
                                        popRoute(context: context);
                                  //      popRoute(context: context);
                                        showAwesomeSnackbar(
                                          context,
                                          'Success!',
                                          '${value}',
                                          contentType: ContentType.success,
                                        );
                                      }
                                    });
                                  }
                                }
                              }
                            }
                          }
                        },
                        context: context,
                        text: "Add_Expenses"),
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
