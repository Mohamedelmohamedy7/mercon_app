import 'dart:io';

import 'package:core_project/Model/LevelModel.dart';
import 'package:core_project/Model/UnitModel.dart';
import 'package:core_project/Provider/VisitorProvider.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../Model/ALLModelModel.dart';
import '../../../Model/BuildingModel.dart';
import '../../../Provider/UnitsProvider.dart';
import '../../../Utill/Comman.dart';
import '../../../Utill/LoaderWidget/loader_widget.dart';
import '../../../Utill/validator.dart';
import '../../../helper/ButtonAction.dart';
import '../../../helper/FaceBookTextField.dart';
import '../../../helper/ImagesConstant.dart';
import '../../../helper/Route_Manager.dart';
import '../../../helper/SnackBarScreen.dart';
import '../../../helper/color_resources.dart';
import '../../../helper/date_converter.dart';
import '../../../helper/text_style.dart';
import '../../Model/UnitModelService.dart';
import '../../Provider/RegisterProvider.dart';
import '../../Utill/Local_User_Data.dart';
import '../Widget/DropDownWidgets.dart';
import '../Widget/comman/CustomAppBar.dart';
import 'DashBoard/DashBoardSCreen.dart';
import 'PartAuth/build_image_picker.dart';
import 'dash_board_security.dart';
class ComplaintFormScreen extends StatefulWidget {
  final bool needBack;
  final bool fromSecurity;
  const ComplaintFormScreen(
      {Key? key, required this.needBack, this.fromSecurity = false});
  @override
  _ComplaintFormScreenState createState() => _ComplaintFormScreenState();
}

class _ComplaintFormScreenState extends State<ComplaintFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  File? imageFront;

  Future<void> pickImageFrontNaionalGallery() async {
    await pickImage(ImageSource.gallery, (File imageTemp) {
      imageFront = imageTemp;
      setState(() {});
    });
  }
  String ? selectedValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = globalAccountData.getUsername() ?? "";
    unitsProvider = Provider.of<UnitsProvider>(context, listen: false);
    unitsProvider!.getAllModel(context,isLogin:true);
    unitsProvider!.getMyUnitNumber(context);
  }
  Future<void> pickImage(ImageSource source, Function(File) setImage) async {
    try {
      final image =
      await ImagePicker().pickImage(source: source, imageQuality: 50);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() {
        setImage(imageTemp);
      });

      FocusScope.of(context).unfocus();
      popRoute(context: context);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }
  UnitsProvider ? unitsProvider;
  ALLModelModel ? selectedModel;
  BuildingModel ? buildingModel;
  LevelModel ? levelModel;
  UnitModel ? unitModel;
  @override

  Future<void> pickImageCameraFront() async {
    await pickImage(ImageSource.camera, (File imageTemp) {
      imageFront = imageTemp;
      setState(() {});
    });
  }
  buildImagePicker frontImage(BuildContext context) {
    return buildImagePicker(
        label: "add_your_image".tr(),
        onTapCamera: pickImageCameraFront,
        onTapGallery: pickImageFrontNaionalGallery,
        imageFile: imageFront,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Complaints_and_Suggestions'.tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'fullName'.tr().toString(),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'error_email_regex'.tr();
                      }
                      return null;
                    },
                  ),


                  SizedBox(height: 16),


                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Complaint_Description'.tr(),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a complaint description'.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  frontImage(context),
                  SizedBox(height: 20),
                  Provider.of<UnitsProvider>(context).modelUnitServiceList.length==1 ?SizedBox() :  ModelSelectionDropdowns(
                    selectedModel: selectedModel,
                    buildingModel: buildingModel,
                    levelModel: levelModel,
                    unitModel: unitModel,
                    onSelectModel: (value) {
                      setState(() {
                        selectedModel = value;
                        buildingModel = null;
                        levelModel = null; unitModel=null;
                      });
                      unitsProvider?.getAllBuilding(context, selectedModel!.id.toString(),isLogin: true);
                    },
                    onSelectBuilding: (value) {
                      setState(() {
                        buildingModel = value;
                        levelModel = null; unitModel=null;
                      });
                      unitsProvider?.getAllLevel(context, buildingModel!.id.toString(),isLogin: true);
                    },
                    onSelectLevel: (value) {
                      setState(() {
                        levelModel = value;
                        unitModel=null;
                      });
                      unitsProvider?.getUnitModel(context, levelModel!.id.toString(),isLogin: true);
                    },
                    onSelectUnits: (value){
                      setState(() {
                        unitModel = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Consumer<RegisterProvider>(
                    builder: (context, model, _) =>
                        model.status == LoadingStatus.LOADING
                            ? LoaderWidget()
                            : widgetWithAction.buttonAction<RegisterProvider>(
                                action: (model) {
                                  if( Provider.of<UnitsProvider>(context,listen: false).modelUnitServiceList.length==1){
                                    OwnerUnit unitModel = Provider.of<UnitsProvider>(context,listen: false).modelUnitServiceList[0];
                                    selectedValue ="${unitModel.modelName} : ${unitModel.buildingName} : ${unitModel.levelName} : ${unitModel.unitNumber}";
                                     setState(() {});
                                    if (_formKey.currentState!.validate()) {
                                      model.sendComplaint(
                                        context,
                                        description: _descriptionController.text,
                                        email: _emailController.text,
                                        unitName:selectedValue ??"" ,
                                        imageFront: imageFront,
                                      ).then((value) {
                                        if (value == true) {
                                          pushRemoveUntilRoute(
                                              context: context,
                                              route: widget.fromSecurity
                                                  ? DashBoardSecurity()
                                                  : DashBoardScreen(
                                                selected: 4,
                                              ));
                                          successSnak(
                                              context,
                                              "Complaint submitted successfully!"
                                                  .tr());
                                        }
                                      });
                                    }
                                   }else{
                                    if (selectedModel == null) {
                                      showAwesomeSnackbar(
                                        context,
                                        'Error!',
                                        '${"selectModel".tr()}',
                                        contentType: ContentType.failure,
                                      );
                                    }
                                    else if (buildingModel == null) {
                                      showAwesomeSnackbar(
                                        context,
                                        'Error!',
                                        '${"please_select_building".tr()}',
                                        contentType: ContentType.failure,
                                      );
                                    }
                                    else if (levelModel == null) {
                                      showAwesomeSnackbar(
                                        context,
                                        'Error!',
                                        '${"please_select_level".tr()}',
                                        contentType: ContentType.failure,
                                      );
                                    }
                                    else if (unitModel == null) {
                                      showAwesomeSnackbar(
                                        context,
                                        'Error!',
                                        '${"selectUnit".tr()}',
                                        contentType: ContentType.failure,
                                      );
                                    }else {
                                      selectedValue = "${selectedModel!
                                          .modelName} : ${buildingModel!
                                          .BuildingModelName} : ${levelModel!
                                          .levelsName} : ${unitModel!
                                          .unitNumber}";
                                      setState(() {});
                                      if (_formKey.currentState!.validate()) {
                                        model.sendComplaint(
                                          context,
                                          description: _descriptionController.text,
                                          email: _emailController.text,
                                          unitName:selectedValue ??"" ,
                                          imageFront: imageFront,
                                        ).then((value) {
                                          if (value == true) {
                                            pushRemoveUntilRoute(
                                                context: context,
                                                route: widget.fromSecurity
                                                    ? DashBoardSecurity()
                                                    : DashBoardScreen(
                                                  selected: 4,
                                                ));
                                            successSnak(
                                                context,
                                                "Complaint submitted successfully!"
                                                    .tr());
                                          }
                                        });
                                      }
                                    }
                                  }

                                  //   return null;
                                },
                                context: context,
                                text: 'Submit_Complaint'.tr()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
