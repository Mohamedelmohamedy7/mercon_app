import 'package:core_project/Model/UnitModel.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../Model/ALLModelModel.dart';
import '../../Model/BuildingModel.dart';
import '../../Model/LevelModel.dart';
import '../../Provider/RegisterProvider.dart';
import '../../Provider/UnitsProvider.dart';
import '../../helper/ButtonAction.dart';
import '../../helper/ImagesConstant.dart';
import '../../helper/SnackBarScreen.dart';
import '../../helper/text_style.dart';
import '../Widget/DropDownWidgets.dart';
import '../Widget/comman/CustomAppBar.dart';

class AddNewUnit extends StatefulWidget {
  const AddNewUnit({Key? key}) : super(key: key);

  @override
  _AddNewUnitState createState() => _AddNewUnitState();
}

class _AddNewUnitState extends State<AddNewUnit> {
  UnitsProvider? unitsProvider;
  ALLModelModel? selectedModel;
  BuildingModel? buildingModel;
  LevelModel? levelModel;
  UnitModel? unitModel;
  @override
  void initState() {
    unitsProvider = Provider.of<UnitsProvider>(context, listen: false);
    unitsProvider?.getAllModel(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        title: 'add_new_unit'.tr(),
        backgroundImage: AssetImage(ImagesConstants.backgroundImage),
      ),
      body: Container(
        //color: BACKGROUNDCOLOR,
        child: ListView(
          children: [
            30.height,
            cachedImage('', width: 130, height: 130),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "*" + "addNewWidgetRequestText".tr() + "*",
                  style: CustomTextStyle.medium10Black.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            10.height,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ModelSelectionDropdowns(
                    selectedModel: selectedModel,
                    buildingModel: buildingModel,
                    levelModel: levelModel,
                    unitModel: unitModel,
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
                      });
                    },
                  ),
                  30.height,
                  widgetWithAction.buttonAction<UnitsProvider>(
                      action: (model) {
                        if (selectedModel == null) {
                          showAwesomeSnackbar(
                            context,
                            'Error!',
                            '${"selectModel".tr()}',
                            contentType: ContentType.failure,
                          );
                        } else if (buildingModel == null) {
                          showAwesomeSnackbar(
                            context,
                            'Error!',
                            '${"please_select_building".tr()}',
                            contentType: ContentType.failure,
                          );
                        } else if (levelModel == null) {
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
                        } else {
                          model
                              .addUnitModel(
                            context,
                            unitID: unitModel!.id.toString(),
                            userID: globalAccountData.getId(),
                            ownerID: globalAccountData.getId()!,
                          )
                              .then((value) {
                            if (value != null) {
                              popRoute(context: context);
                              popRoute(context: context);
                              showAwesomeSnackbar(
                                context,
                                'Success!',
                                '${value}',
                                contentType: ContentType.success,
                              );
                            }
                          });
                        }
                      },
                      context: context,
                      text: "add_new_unit"),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
