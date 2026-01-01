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
import '../../Widget/DropDownWidgets.dart';
import '../../Widget/comman/CustomAppBar.dart';
import '../PartAuth/RegisterScreen.dart';
import 'information_screen.dart';

class sendInvitetion extends StatefulWidget {
  const sendInvitetion({Key? key}) : super(key: key);

  @override
  State<sendInvitetion> createState() => _sendInvitetionState();
}

class _sendInvitetionState extends State<sendInvitetion> {
  TextEditingController nameGuest = TextEditingController();
  TextEditingController nationalNumber = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController numberOfGuests = TextEditingController();
  TextEditingController dateOfAccess = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  TextEditingController faceBookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void moveToTop() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
    FocusScope.of(context).unfocus();
  }

  UnitsProvider? unitsProvider;
  ALLModelModel? selectedModel;
  BuildingModel? buildingModel;
  LevelModel? levelModel;
  UnitModel? unitModel;
  @override
  void initState() {
    unitsProvider = Provider.of<UnitsProvider>(context, listen: false);
    unitsProvider!.getAllModel(context, isLogin: true);
    super.initState();
  }

  List<File> imageFront = [];
  List<File> imageBack = [];
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    FocusScope.of(context).unfocus();
    if (startDate == null && isStartDate == false) {
    } else {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: (isStartDate ? startDate : endDate) ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null) {
        setState(() {
          if (isStartDate) {
            startDate = pickedDate;
          } else {
            if (startDate != null && startDate!.isAfter(pickedDate)) {
              showAwesomeSnackbar(
                context,
                'On Snap!',
                '${tr("startBeforeEnd")}',
                contentType: ContentType.failure,
              );
            } else {
              endDate = pickedDate;
            }
          }
        });
        FocusScope.of(context).unfocus();
      }
      FocusScope.of(context).unfocus();
    }
  }

  Future pickImageFront() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      //setState(() => imageFront = imageTemp);
      setState(() {
        imageFront.add(imageTemp);
      });
      FocusScope.of(context).unfocus();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  Future pickImageCBack() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      // setState(() => imageBack = imageTemp);

      setState(() {
        imageBack.add(imageTemp);
      });
      FocusScope.of(context).unfocus();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
    FocusScope.of(context).unfocus();
  }

  Future pickImageBack() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      // setState(() => imageBack = imageTemp);
      setState(() {
        imageBack.add(imageTemp);
      });
      FocusScope.of(context).unfocus();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
    FocusScope.of(context).unfocus();
  }

  Future pickImageCFront() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      imageFront.add(imageTemp);
      setState(() {});
      FocusScope.of(context).unfocus();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
    FocusScope.of(context).unfocus();
  }
  // Future<void> pickImageFront() async {
  //   final picked = await ImagePicker().pickMultiImage(); // multiple selection
  //   if (picked != null) {
  //     imageFront.addAll(picked.map((e) => File(e.path)));
  //     setState(() {});
  //   }
  // }

  // Future<void> pickImageCFront() async {
  //   final picked = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (picked != null) {
  //     imageFront.add(File(picked.path));
  //     setState(() {});
  //   }
  // }
  Widget _datePickerButton(String label, bool isStartDate) {
    return TextButton(
      onPressed: () => _selectDate(context, isStartDate),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.calendar_today,
              color: Colors.white,
              size: 16,
            ),
            10.width,
            Text(
              label,
              style: CustomTextStyle.semiBold12Black.copyWith(color: white),
            ),
          ],
        ),
      ),
    );
  }

  int selectType = 5;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'sendInvention'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Stack(
          children: [
            Container(
              width: w(context),
              height: h(context),
              // color: BACKGROUNDCOLOR.withOpacity(0.7),
              child: Form(
                key: _globalKey,
                child: ListView(
                  controller: _scrollController,
                  children: [
                    5.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 280,
                          height: 55,
                          alignment: AlignmentDirectional.topStart,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage(ImagesConstants.backGroundOrder),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "sendInventionData".tr(),
                            style: CustomTextStyle.bold14White,
                          )),
                        ),
                      ],
                    ),
                    5.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectType = 1;
                            });
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            decoration: BoxDecoration(
                                color: selectType == 1
                                    ? Theme.of(context).primaryColor
                                    : white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor)),
                            child: Text(
                              "visitor".tr(),
                              style: CustomTextStyle.semiBold12Black.copyWith(
                                  color: selectType == 1
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectType = 2;
                            });
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            decoration: BoxDecoration(
                                color: selectType == 2
                                    ? Theme.of(context).primaryColor
                                    : white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor)),
                            child: Text(
                              "rent".tr(),
                              style: CustomTextStyle.semiBold12Black.copyWith(
                                  color: selectType == 2
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    17.height,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: w(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ModelSelectionDropdowns(
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
                            10.height,
                            textFormField(
                                "fullName",
                                nameGuest,
                                Icon(
                                  Icons.drive_file_rename_outline,
                                  color: Theme.of(context).primaryColor,
                                ),
                                validation: (value) => Validator.name(value)),
                            5.height,
                            textFormField(
                                "National Number",
                                nationalNumber,
                                Icon(
                                  Icons.add_card,
                                  color: Theme.of(context).primaryColor,
                                ),
                                validation: (value) => Validator.numbers(value),
                                keyboardType: TextInputType.number),
                            5.height,
                            textFormField(
                                "email",
                                emailController,
                                Icon(
                                  Icons.email_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                                validation: (value) => Validator.email(value)),
                            5.height,
                            textFormField(
                                "Phone Number",
                                phoneNumber,
                                Icon(
                                  Icons.phone_android,
                                  color: Theme.of(context).primaryColor,
                                ),
                                validation: (value) => Validator.numbers(value),
                                keyboardType: TextInputType.number),
                            20.height,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "frontImage".tr(),
                                  style: const TextStyle(
                                      color: BLACK,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                                const SizedBox(height: 10),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: imageFront.length +
                                      1, // +1 for the add button
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (index == imageFront.length) {
                                      // Add Button
                                      return InkWell(
                                        onTap: () => showModalBottomSheet(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(10))),
                                          context: context,
                                          builder: (context) => Container(
                                            margin: const EdgeInsets.all(40),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      await pickImageCFront();
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                            Icons.camera),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                            "Select From Camera",
                                                            style: CustomTextStyle
                                                                .semiBold12Black),
                                                      ],
                                                    )),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: Divider(),
                                                ),
                                                InkWell(
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      await pickImageFront();
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.photo),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                            "Select From Gallery",
                                                            style: CustomTextStyle
                                                                .semiBold12Black),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: const Icon(Icons.add),
                                        ),
                                      );
                                    } else {
                                      // Existing Image
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          imageFront[index],
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            // imageFront == null
                            //     ? InkWell(
                            //         onTap: () => showModalBottomSheet(
                            //             shape: const RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.vertical(
                            //                     top: Radius.circular(10))),
                            //             context: context,
                            //             builder: (context) => Container(
                            //                   margin: const EdgeInsets.all(40),
                            //                   child: Column(
                            //                     mainAxisSize: MainAxisSize.min,
                            //                     children: [
                            //                       // Is
                            //                       InkWell(
                            //                           onTap: () =>
                            //                               pickImageCFront(),
                            //                           child: Row(
                            //                             mainAxisAlignment:
                            //                                 MainAxisAlignment
                            //                                     .start,
                            //                             children: [
                            //                               const Icon(
                            //                                 Icons.camera,
                            //                               ),
                            //                               const SizedBox(
                            //                                 width: 10,
                            //                               ),
                            //                               Text(
                            //                                 "Select From Camera",
                            //                                 style: CustomTextStyle
                            //                                     .semiBold12Black,
                            //                               ),
                            //                             ],
                            //                           )),
                            //                       const Padding(
                            //                         padding: EdgeInsets.symmetric(
                            //                             vertical: 10),
                            //                         child: Divider(),
                            //                       ),
                            //                       InkWell(
                            //                         onTap: () => pickImageFront(),
                            //                         child: Row(
                            //                           mainAxisAlignment:
                            //                               MainAxisAlignment.start,
                            //                           children: [
                            //                             const Icon(
                            //                               Icons
                            //                                   .photo_camera_back_outlined,
                            //                             ),
                            //                             const SizedBox(
                            //                               width: 10,
                            //                             ),
                            //                             Text(
                            //                               "Select From Gallery",
                            //                               style: CustomTextStyle
                            //                                   .semiBold12Black,
                            //                             ),
                            //                           ],
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 )),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.start,
                            //           children: [
                            //
                            //             Text(
                            //               "frontImage".tr(),
                            //               style: const TextStyle(
                            //                   color: BLACK, fontWeight: FontWeight.w600, fontSize: 13),
                            //             ),
                            //             const SizedBox(
                            //               width: 10,
                            //             ),
                            //             const Spacer(),
                            //             Icon(Icons.upload_file,color: Theme.of(context).primaryColor,),
                            //             const SizedBox(
                            //               width: 10,
                            //             ),
                            //           ],
                            //         ),
                            //       )
                            //     : InkWell(
                            //       onTap: () => showModalBottomSheet(
                            //       shape: const RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.vertical(
                            //               top: Radius.circular(10))),
                            //       context: context,
                            //       builder: (context) => Container(
                            //         margin: const EdgeInsets.all(40),
                            //         child: Column(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             // Is
                            //             InkWell(
                            //                 onTap: () =>
                            //                     pickImageCFront(),
                            //                 child: Row(
                            //                   mainAxisAlignment:
                            //                   MainAxisAlignment
                            //                       .start,
                            //                   children: [
                            //                     const Icon(
                            //                       Icons.camera,
                            //                     ),
                            //                     const SizedBox(
                            //                       width: 10,
                            //                     ),
                            //                     Text(
                            //                       "Select From Camera",
                            //                       style: CustomTextStyle
                            //                           .semiBold12Black,
                            //                     ),
                            //                   ],
                            //                 )),
                            //             const Padding(
                            //               padding: EdgeInsets.symmetric(
                            //                   vertical: 10),
                            //               child: Divider(),
                            //             ),
                            //             InkWell(
                            //               onTap: () => pickImageFront(),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                 MainAxisAlignment.start,
                            //                 children: [
                            //                   const Icon(
                            //                     Icons
                            //                         .photo_camera_back_outlined,
                            //                   ),
                            //                   const SizedBox(
                            //                     width: 10,
                            //                   ),
                            //                   Text(
                            //                     "Select From Gallery",
                            //                     style: CustomTextStyle
                            //                         .semiBold12Black,
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       )),
                            //       child: Container(
                            //           width: double.infinity,
                            //           height: 150,
                            //           decoration: BoxDecoration(
                            //               borderRadius: BorderRadius.circular(15)),
                            //           child: ClipRRect(
                            //             borderRadius: BorderRadius.circular(15),
                            //             child: Image.file(
                            //               File(imageFront!.path),
                            //               fit: BoxFit.fitWidth,
                            //             ),
                            //           ),
                            //         ),
                            //     ),
                            20.height,
                            const Divider(
                              color: lightGray,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "backImage".tr(),
                                  style: const TextStyle(
                                      color: BLACK,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                                const SizedBox(height: 10),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: imageBack.length + 1,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (index == imageBack.length) {
                                      return InkWell(
                                        onTap: () => showModalBottomSheet(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(10))),
                                          context: context,
                                          builder: (context) => Container(
                                            margin: const EdgeInsets.all(40),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    await pickImageCBack();
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.camera),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        "Select From Camera",
                                                        style: CustomTextStyle
                                                            .semiBold12Black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: Divider(),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    await pickImageBack();
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.photo),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        "Select From Gallery",
                                                        style: CustomTextStyle
                                                            .semiBold12Black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: const Icon(Icons.add),
                                        ),
                                      );
                                    } else {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          imageBack[index],
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),

                            20.height,
                            const Divider(
                              color: lightGray,
                            ),
                            textFormField(
                                "numberOfGuest",
                                numberOfGuests,
                                Icon(
                                  Icons.model_training,
                                  color: Theme.of(context).primaryColor,
                                ),
                                validation: (value) =>
                                    Validator.numbers(value)),
                            20.height,
                            FacebookTextFormField(
                              controller: faceBookController,
                              labelText: 'faceBookLink'.tr(),
                              hintText: 'faceBookLink'.tr(),
                            ),
                            10.height,
                            InstaTextFormField(
                              controller: instagramController,
                              labelText: 'instaLink'.tr(),
                              hintText: 'instaLink'.tr(),
                            ),
                            20.height,
                            textFormField(
                                "relationShip",
                                relationshipController,
                                Icon(
                                  Icons.receipt_long,
                                  color: Theme.of(context).primaryColor,
                                ),
                                validation: (value) =>
                                    Validator.defaultValidator(value),
                                maxLines: 10),
                            20.height,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _datePickerButton(
                                      startDate == null
                                          ? 'startDate'.tr()
                                          : DateConverter.estimatedDate(
                                              startDate!),
                                      true),
                                  _datePickerButton(
                                      endDate == null
                                          ? 'endDate'.tr()
                                          : DateConverter.estimatedDate(
                                              endDate!),
                                      false),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    70.height,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: widgetWithAction.buttonAction<VisitorProvider>(
                    action: (model) {
                      if (_globalKey.currentState!.validate()) {
                        if (imageFront == null) {
                          showAwesomeSnackbar(
                            context,
                            'On Snap!',
                            '${tr("frontImage")}',
                            contentType: ContentType.failure,
                          );
                          moveToTop();
                        } else if (imageBack == null) {
                          showAwesomeSnackbar(
                            context,
                            'On Snap!',
                            '${tr("backImage")}',
                            contentType: ContentType.failure,
                          );
                        } else if (startDate == null) {
                          showAwesomeSnackbar(
                            context,
                            'On Snap!',
                            '${tr("startDate")}',
                            contentType: ContentType.failure,
                          );
                        } else if (endDate == null) {
                          showAwesomeSnackbar(
                            context,
                            'On Snap!',
                            '${tr("endDate")}',
                            contentType: ContentType.failure,
                          );
                          moveToTop();
                        } else if (selectType == 5) {
                          showAwesomeSnackbar(
                            context,
                            'On Snap!',
                            '${tr("rentOrVisitor")}',
                            contentType: ContentType.failure,
                          );
                          moveToTop();
                        } else if (selectedModel == null) {
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => InformationScreen(
                                  name: nameGuest.text,
                                  relationship: relationshipController.text,
                                  nationalId: nationalNumber.text,
                                  imageNationalIdFrontFile: imageFront,
                                  email: emailController.text,
                                  imageNationalIdBackFile: imageBack,
                                  isRent: selectType == 2 ? true : false,
                                  isVisitor: selectType == 1 ? true : false,
                                  entryDateTime: startDate!,
                                  checkOutDateTime: endDate!,
                                  facebookLink: faceBookController.text,
                                  instagramLink: instagramController.text,
                                  totalWithVisitorCount: numberOfGuests.text,
                                  unitId: unitModel!.id.toString(),
                                  phoneNumber: phoneNumber.text)));
                        }
                      }
                    },
                    context: context,
                    text: "sendRequest"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
