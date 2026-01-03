import 'dart:io';

import 'package:core_project/Model/LevelModel.dart';
import 'package:core_project/Model/UnitModel.dart';
import 'package:core_project/Provider/VisitorProvider.dart';
import 'package:core_project/View/Screen/DropDownWidgets.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
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

  String? selectedValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF695C4C), // اللون
    statusBarIconBrightness: Brightness.light, // Android
    statusBarBrightness: Brightness.dark, // iOS
    ),
    );
    _emailController.text = globalAccountData.getUsername() ?? "";
    unitsProvider = Provider.of<UnitsProvider>(context, listen: false);
    unitsProvider!.getAllModel(context, isLogin: true);
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
     // popRoute(context: context);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  UnitsProvider? unitsProvider;
  ALLModelModel? selectedModel;
  BuildingModel? buildingModel;
  LevelModel? levelModel;
  UnitModel? unitModel;
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
          needBack: true,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        // appBar: AppBar(
        //
        //   backgroundColor: Theme.of(context).primaryColor,
        //   elevation: 0,
        //   centerTitle: false,
        //   automaticallyImplyLeading: false,
        //   titleSpacing: 16,
        //   title: Row(
        //     children: [
        //       InkWell(
        //         onTap: () {
        //           popRoute(context: context);
        //         },
        //         child: Icon(
        //           Icons.arrow_back_ios_sharp,
        //           color: Color(0xffCCB6A1),
        //           size: 25,
        //         ),
        //       ),
        //       const SizedBox(width: 14),
        //       Expanded(
        //         child: FittedBox(
        //           fit: BoxFit.scaleDown,
        //           alignment: Alignment.centerRight,
        //           child: Text(
        //             'Complaints_and_Suggestions'.tr(),
        //             style: TextStyle(
        //               color: Color(0xffCCB6A1),
        //               fontSize: 16,
        //               fontWeight: FontWeight.w500,
        //             ),
        //             maxLines: 1,
        //           ),
        //         ),
        //       ),
        //
        //       const SizedBox(width: 20),
        //       Image.asset(
        //         'assets/images/logo_m.png',
        //          height: 28,
        //           fit: BoxFit.contain,
        //       ),
        //     ],
        //   ),
        //
        // ),
        // CustomAppBar(
        //   title: 'Complaints_and_Suggestions'.tr(),
        //   needBack: widget.needBack,
        //   backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        // ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// الاسم
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: newColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'fullName'.tr(),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'error_email_regex'.tr();
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 12),

                    Container(
                        // padding:
                        // const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          //     color: const Color(0xFFF6EFE7),

                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ModelSelectionDropdowns(
                          selectedModel: selectedModel,
                          buildingModel: buildingModel,
                          levelModel: levelModel,
                          unitModel: unitModel,
                          onSelectModel: (value) {
                            setState(() {
                              selectedModel = value;
                              buildingModel = null;
                              levelModel = null;
                              unitModel = null;
                            });
                            unitsProvider?.getAllBuilding(
                                context, selectedModel!.id.toString(),
                                isLogin: true);
                          },
                          onSelectBuilding: (value) {
                            setState(() {
                              buildingModel = value;
                              levelModel = null;
                              unitModel = null;
                            });
                            unitsProvider?.getAllLevel(
                                context, buildingModel!.id.toString(),
                                isLogin: true);
                          },
                          onSelectLevel: (value) {
                            setState(() {
                              levelModel = value;
                              unitModel = null;
                            });
                            unitsProvider?.getUnitModel(
                                context, levelModel!.id.toString(),
                                isLogin: true);
                          },
                          onSelectUnits: (value) {
                            setState(() {
                              unitModel = value;
                            });
                          },
                        ),
                      ),

                const SizedBox(height: 12),

                /// وصف الشكوى
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6EFE7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Complaint_Description'.tr(),
                      hintStyle: textStyle,
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a complaint description'.tr();
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 16),

                /// رفع صورة / فيد
              if(imageFront==null)
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: pickImageCameraFront,
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6EFE7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'upload_image_camera'.tr(),
                                      // 'تحميل صورة\nلوصف مشكلتك',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10),
                                    child: SvgPicture.asset(
                                      "assets/images/camira.svg",
                                      //    color: BLACK,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: pickImageFrontNaionalGallery,
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6EFE7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'upload_image_gallery'.tr(),
                                      // 'تحميل صورة\nلوصف مشكلتك',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10),
                                    child: SvgPicture.asset(
                                      "assets/images/gallery.svg",
                                      //    color: BLACK,
                                    ),

                                    // Icon(Icons.image_outlined,
                                    //     size: 32, color: Color(0xFF8D7B68)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                else
                if (imageFront != null)
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            imageFront!,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),

                      /// Remove icon
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              imageFront = null;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                const SizedBox(height: 24),

              ],
            ),
          ),
        ),
        bottomNavigationBar:    Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Consumer<RegisterProvider>(
            builder: (context, model, _) => model.status ==
                LoadingStatus.LOADING
                ?Container(height:50,child: Center(child: const Loading()))
                : widgetWithAction.buttonAction<RegisterProvider>(
                 fontSize: 14,
                action: (model) {
                  if (Provider.of<UnitsProvider>(context,
                      listen: false)
                      .modelUnitServiceList
                      .length ==
                      1) {
                    OwnerUnit unitModel = Provider.of<UnitsProvider>(
                        context,
                        listen: false)
                        .modelUnitServiceList[0];
                    selectedValue =
                    "${unitModel.modelName} : ${unitModel.buildingName} : ${unitModel.levelName} : ${unitModel.unitNumber}";
                    setState(() {});
                    if (_formKey.currentState!.validate()) {
                      model
                          .sendComplaint(
                        context,
                        description: _descriptionController.text,
                        email: _emailController.text,
                        unitName: selectedValue ?? "",
                        imageFront: imageFront,
                      )
                          .then((value) {
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
                  } else {
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
                      selectedValue =
                      "${selectedModel!.modelName} : ${buildingModel!.BuildingModelName} : ${levelModel!.levelsName} : ${unitModel!.unitNumber}";
                      setState(() {});
                      if (_formKey.currentState!.validate()) {
                        model
                            .sendComplaint(
                          context,
                          description: _descriptionController.text,
                          email: _emailController.text,
                          unitName: selectedValue ?? "",
                          imageFront: imageFront,
                        )
                            .then((value) {
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
        ),
      ),
    );
  }
}
