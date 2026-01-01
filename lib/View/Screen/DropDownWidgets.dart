import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../Model/ALLModelModel.dart';
import '../../Model/BuildingModel.dart';
import '../../Model/LevelModel.dart';
import '../../Model/UnitModel.dart';
import '../../Provider/UnitsProvider.dart';
import '../../Utill/Comman.dart';
import '../../helper/text_style.dart';
import '../Screen/DashBoard/HomeScreen.dart'; // Import your provider

Color newColor = const Color(0xFFF6EFE7);


InputDecoration inputDecoration = InputDecoration(
  filled: true,
  fillColor: newColor,
  border: InputBorder.none, // Remove underline
);
TextStyle textStyle = const TextStyle(
    fontFamily: 'NewFonts',
    color: const Color(0xFF695C4C),
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5);

class ModelSelectionDropdowns extends StatefulWidget {
  final ALLModelModel? selectedModel;
  final BuildingModel? buildingModel;
  final LevelModel? levelModel;
  final UnitModel? unitModel;
  bool? isRegister = false;
  final bool enable;
  final Widget? fromLoadPaymentWidget;
  final Function(ALLModelModel?) onSelectModel;
  final Function(BuildingModel?) onSelectBuilding;
  final Function(LevelModel?) onSelectLevel;
  final Function(UnitModel?) onSelectUnits;

  ModelSelectionDropdowns({
    Key? key,
    required this.selectedModel,
    required this.buildingModel,
    required this.levelModel,
    required this.unitModel,
    required this.onSelectModel,
    this.isRegister,
    required this.onSelectBuilding,
    required this.onSelectLevel,
    required this.onSelectUnits,
    this.enable = true,
    this.fromLoadPaymentWidget,
  }) : super(key: key);

  @override
  State<ModelSelectionDropdowns> createState() =>
      _ModelSelectionDropdownsState();
}

class _ModelSelectionDropdownsState extends State<ModelSelectionDropdowns> {
  @override
  Widget build(BuildContext context) {
    final unitsProvider = Provider.of<UnitsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
  //      SizedBox(height: 15),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: newColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: DropdownButtonFormField<ALLModelModel>(
            icon:SvgPicture.asset("assets/images/arrow.svg",
              color: unitsProvider.aLLModelModelList.isEmpty
              ? Colors.grey // اللون الرمادي لو الليست فاضية
              : null, // لون طبيعي لو فيها عناصر
            ),
            value: widget.selectedModel,
            decoration: inputDecoration,
            hint: Text('selectModel'.tr(), style: textStyle),
            items: unitsProvider.aLLModelModelList.map((unitModel) {
              return DropdownMenuItem<ALLModelModel>(
                value: unitModel,
                child: Text(unitModel.name, style: textStyle),
              );
            }).toList(),
            onChanged: widget.enable == true ? widget.onSelectModel : null,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding:   EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: newColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: DropdownButtonFormField<BuildingModel>(
            icon:SvgPicture.asset("assets/images/arrow.svg",
              color: unitsProvider.buildingList.isEmpty
                  ? Colors.grey // اللون الرمادي لو الليست فاضية
                  : null, //
            ),
            value: widget.buildingModel,
            decoration: inputDecoration,
            hint: Text('buildingNumber'.tr(), style: textStyle),
            items: unitsProvider.buildingList.map((buildModel) {
              return DropdownMenuItem<BuildingModel>(

                value: buildModel,
                child: Text(buildModel.BuildingModelName, style: textStyle),
              );
            }).toList(),
            onChanged: widget.enable == true ? widget.onSelectBuilding : null,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding:    EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: newColor,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                child: DropdownButtonFormField<LevelModel>(
                  value: widget.levelModel,
                  icon:SvgPicture.asset("assets/images/arrow.svg",
                    color: unitsProvider.levelList.isEmpty
                        ? Colors.grey // اللون الرمادي لو الليست فاضية
                        : null,
                  ),
                  decoration: inputDecoration,
                  hint: Text('levelsNum'.tr(), style: textStyle),
                  items: unitsProvider.levelList.map((levelModel) {
                    return DropdownMenuItem<LevelModel>(
                      value: levelModel,
                      child: Text(levelModel.levelsName, style: textStyle),
                    );
                  }).toList(),
                  onChanged:
                      widget.enable == true ? widget.onSelectLevel : null,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: newColor,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                child: DropdownButtonFormField<UnitModel>(
                  icon:SvgPicture.asset("assets/images/arrow.svg",
                    color: unitsProvider.unitList.isEmpty
                        ? Colors.grey // اللون الرمادي لو الليست فاضية
                        : null,
                  ),
                  value: widget.unitModel,
                  decoration: inputDecoration,
                  hint: Text('unitsNum'.tr(), style: textStyle),
                  items: unitsProvider.unitList.map((unitModels) {
                    return DropdownMenuItem<UnitModel>(
                      value: unitModels,
                      child: Text(unitModels.unitNumber, style: textStyle),
                    );
                  }).toList(),
                  onChanged:
                      widget.enable == true ? widget.onSelectUnits : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ModelSelectionAlert extends StatefulWidget {
  final ALLModelModel? selectedModel;
  final BuildingModel? buildingModel;
  final LevelModel? levelModel;
  final UnitModel? unitModel;
  bool? isRegister = false;
  final Function(ALLModelModel?) onSelectModel;
  final Function(BuildingModel?) onSelectBuilding;
  final Function(LevelModel?) onSelectLevel;
  final Function(UnitModel?) onSelectUnits;

  ModelSelectionAlert({
    Key? key,
    required this.selectedModel,
    required this.buildingModel,
    required this.levelModel,
    required this.unitModel,
    required this.onSelectModel,
    this.isRegister,
    required this.onSelectBuilding,
    required this.onSelectLevel,
    required this.onSelectUnits,
  }) : super(key: key);

  @override
  _ModelSelectionAlertState createState() => _ModelSelectionAlertState();
}

class _ModelSelectionAlertState extends State<ModelSelectionAlert> {
  @override
  Widget build(BuildContext context) {
    final unitsProvider = Provider.of<UnitsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      3.width,
                      Text("1.", style: textStyle.copyWith(fontSize: 12)),
                      Text('selectModel'.tr(),
                          style: textStyle.copyWith(fontSize: 10)),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      _showModelDialog(
                          context, unitsProvider.aLLModelModelList);
                    },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: lightBrown.withOpacity(0.4),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('selectModel'.tr() + " : ",
                                    style: textStyle.copyWith(fontSize: 10)),
                                Text(widget.selectedModel?.name ?? '---'.tr(),
                                    style: textStyle.copyWith(fontSize: 10)),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: InkWell(
                  onTap: () {
                    _showBuildingDialog(context, unitsProvider.buildingList);
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          3.width,
                          Text("2.", style: textStyle.copyWith(fontSize: 12)),
                          Text('buildingNumber'.tr(),
                              style: textStyle.copyWith(fontSize: 10)),
                        ],
                      ),
                      Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: lightBrown.withOpacity(0.4),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Text('buildingNumber'.tr() + " : ",
                                    style: textStyle.copyWith(fontSize: 9)),
                                Text(widget.buildingModel?.BuildingModelName ??
                                    '---'.tr()),
                              ],
                            ),
                          )),
                    ],
                  )),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    children: [
                      3.width,
                      Text("3.", style: textStyle.copyWith(fontSize: 12)),
                      Text('levelsNum'.tr(),
                          style: textStyle.copyWith(fontSize: 10)),
                    ],
                  ),
                  5.height,
                  InkWell(
                      onTap: () {
                        _showLevelDialog(context, unitsProvider.levelList);
                      },
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: lightBrown.withOpacity(0.4),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Text('levelsNum'.tr() + " : ",
                                    style: textStyle.copyWith(fontSize: 9)),
                                Text(
                                    widget.levelModel?.levelsName ?? '---'.tr(),
                                    style: textStyle.copyWith(fontSize: 10))
                              ],
                            ),
                          ))),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  _showUnitDialog(context, unitsProvider.unitList);
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        3.width,
                        Text("4.", style: textStyle.copyWith(fontSize: 12)),
                        Text('unitsNum'.tr(),
                            style: textStyle.copyWith(fontSize: 10)),
                      ],
                    ),
                    5.height,
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: lightBrown.withOpacity(0.4),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Text('unitsNum'.tr() + " : ",
                                  style: textStyle.copyWith(fontSize: 9)),
                              Text(widget.unitModel?.unitNumber ?? '---'.tr(),
                                  style: textStyle.copyWith(fontSize: 9))
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showModelDialog(BuildContext context, List<ALLModelModel> items) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 2),
        insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        titlePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Container(
          height: 60,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Row(
              children: [
                10.width,
                Icon(
                  Icons.fireplace_outlined,
                  color: Colors.white,
                ),
                5.width,
                Text('please_select_model'.tr(),
                    style:
                        textStyle.copyWith(fontSize: 12, color: Colors.white)),
              ],
            ),
          ),
        ),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: items.map((item) {
                return Column(
                  children: [
                    Center(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            10.width,
                            Text(item.name,
                                style: textStyle.copyWith(fontSize: 14)),
                          ],
                        ),
                        onTap: () {
                          widget.onSelectModel(item);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Divider(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        thickness: 1),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _showBuildingDialog(BuildContext context, List<BuildingModel> items) {
    if (widget.selectedModel == null) {
      failedSnack(context, "please_select_model".tr());
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 2),
          insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Container(
            height: 60,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.apartment, color: Colors.white),
                  SizedBox(width: 5),
                  Text('buildingNumber'.tr(),
                      style: textStyle.copyWith(
                        fontSize: 12,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: items.isEmpty
                    ? [
                        20.height,
                        Lottie.asset("assets/images/MXxGLf5x75.json",
                            height: 140, width: 140, fit: BoxFit.contain),
                        Text(
                          "sorry_no_building_in_this_model".tr(),
                          style: textStyle.copyWith(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        20.height,
                      ]
                    : items.map((item) {
                        return Column(
                          children: [
                            Center(
                              child: ListTile(
                                title: Text(item.BuildingModelName,
                                    style: textStyle.copyWith(
                                      fontSize: 14,
                                    )),
                                onTap: () {
                                  widget.onSelectBuilding(item);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Divider(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              thickness: 1,
                            ),
                          ],
                        );
                      }).toList(),
              ),
            ),
          ),
        ),
      );
    }
  }

  void _showLevelDialog(BuildContext context, List<LevelModel> items) {
    if (widget.buildingModel == null) {
      failedSnack(context, "please_select_building".tr());
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 2),
          insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Container(
            height: 60,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.layers, color: Colors.white),
                  SizedBox(width: 5),
                  Text('levelsNum'.tr(),
                      style: textStyle.copyWith(
                        fontSize: 12,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: items.isEmpty
                    ? [
                        20.height,
                        Lottie.asset("assets/images/MXxGLf5x75.json",
                            height: 140, width: 140, fit: BoxFit.contain),
                        Text(
                          "sorry_no_level_in_this_building".tr(),
                          style: textStyle.copyWith(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        20.height,
                      ]
                    : items.map((item) {
                        return Column(
                          children: [
                            Center(
                              child: ListTile(
                                title: Text(item.levelsName,
                                    style: textStyle.copyWith(
                                      fontSize: 14,
                                    )),
                                onTap: () {
                                  widget.onSelectLevel(item);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Divider(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              thickness: 1,
                            ),
                          ],
                        );
                      }).toList(),
              ),
            ),
          ),
        ),
      );
    }
  }

  void _showUnitDialog(BuildContext context, List<UnitModel> items) {
    if (widget.levelModel == null) {
      failedSnack(context, "please_select_level".tr());
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 2),
          insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Container(
            height: 60,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.widgets, color: Colors.white),
                  SizedBox(width: 5),
                  Text('unitsNum'.tr(),
                      style: textStyle.copyWith(
                        fontSize: 12,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: items.isEmpty
                    ? [
                        20.height,
                        Lottie.asset("assets/images/MXxGLf5x75.json",
                            height: 140, width: 140, fit: BoxFit.contain),
                        Text(
                          "sorry_no_unit_in_this_level".tr(),
                          style: textStyle.copyWith(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        20.height,
                      ]
                    : items.map((item) {
                        return Column(
                          children: [
                            Center(
                              child: ListTile(
                                title: Text(item.unitNumber,
                                    style: textStyle.copyWith(
                                      fontSize: 14,
                                    )),
                                onTap: () {
                                  widget.onSelectUnits(item);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Divider(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              thickness: 1,
                            ),
                          ],
                        );
                      }).toList(),
              ),
            ),
          ),
        ),
      );
    }
  }
}
