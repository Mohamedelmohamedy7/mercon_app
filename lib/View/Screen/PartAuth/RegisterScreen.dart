import 'dart:io';
import 'package:core_project/Model/CompoundModel.dart';
import 'package:core_project/Model/UnitModel.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/View/Screen/PartAuth/BuildPdfPicker.dart';
import 'package:core_project/View/Screen/PartAuth/LoginScreen.dart';
import 'package:core_project/View/Screen/PartAuth/build_image_picker.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../../Model/ALLModelModel.dart';
import '../../../Model/BuildingModel.dart';
import '../../../Model/LevelModel.dart';
import '../../../Model/SharedTypeSelected.dart';
import '../../../Model/UnitUserFull.dart';
import '../../../Provider/RegisterProvider.dart';
import '../../../Provider/UnitsProvider.dart';
import '../../../Utill/ExpandableContainer.dart';
import '../../../Utill/validator.dart';
import '../../../helper/ButtonAction.dart';
import '../../../helper/SnackBarScreen.dart';
import '../../../helper/color_resources.dart';
import '../../Widget/DropDownWidgets.dart';
import '../../Widget/comman/CustomAppBar.dart';
import '__register_screen_state_intl_phone_field.dart';

class RegisterScreen extends StatefulWidget {
  final CompoundData compoundData;
  const RegisterScreen({Key? key, required this.compoundData})
      : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fNameController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmPasswordController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      emailController = TextEditingController(),
      addressController = TextEditingController(),
      nationalIdNumberController = TextEditingController(),
      carPlateNumberController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  File? imageFront;
  File? imageBack;
  File? imageContract;
  File? imageAccount;
  UnitsProvider? unitsProvider;
  ALLModelModel? selectedModel;
  BuildingModel? buildingModel;
  LevelModel? levelModel;
  UnitModel? unitModel;

  @override
  void dispose() {
    fNameController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // File? pdfFile;

  Future<void> pickPdfFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          imageContract = File(result.files.single.path!);
        });
        showAwesomeSnackbar(
          context,
          "تم التحميل",
          "تم اختيار ملف PDF بنجاح",
          contentType: ContentType.success,
        );
      } else {
        showAwesomeSnackbar(
          context,
          "لم يتم اختيار ملف",
          "الرجاء اختيار ملف PDF صالح",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      if (kDebugMode) print("Error picking PDF: $e");
      showAwesomeSnackbar(
        context,
        "خطأ",
        "حدث خطأ أثناء اختيار الملف",
        contentType: ContentType.failure,
      );
    }
  }

  bool isAnyEmpty(List<UnitUserFull> userList) {
    if (userList.isEmpty) {
      return true;
    } else {
      for (UnitUserFull user in userList) {
        if ((user.model == "") ||
            (user.build == "") ||
            (user.level == "") ||
            (user.unit == "")) {
          return true;
        }
      }
      return false;
    }
  }

  List<UnitUserFull> itemList = [];
  List<SharedTypeSelected> itemSelected = [];

  void addItemToList() {
    print(itemList.length);
    print(isAnyEmpty(itemList));
    for (int i = 0; i < itemList.length; i++) {
      print(
          "Model:${itemList[i].model} build: ${itemList[i].build} level : ${itemList[i].level} unit : ${itemList[i].unit}");
    }
    if (isAnyEmpty(itemList) == false || itemList.isEmpty) {
      itemList.add(UnitUserFull(model: "", build: "", level: "", unit: ""));
      itemSelected.add(SharedTypeSelected(
          selectedModel: null,
          buildingModel: null,
          levelModel: null,
          unitModel: null));
    } else {
      failedSnack(context, "please_fill_all_the_fields".tr());
    }
    setState(() {});
  }

  @override
  void initState() {
    print("cooooom model ${widget.compoundData.toJson()}");
    unitsProvider = Provider.of<UnitsProvider>(context, listen: false);
    unitsProvider?.getAllModel(context, comId: widget.compoundData.id);
    super.initState();
  }

  Future<void> pickImageAccountGallery() async {
    await pickImage(ImageSource.gallery, (File imageTemp) {
      imageAccount = imageTemp;
      setState(() {});
    });
  }

  Future<void> pickImageCameraAccount() async {
    await pickImage(ImageSource.camera, (File imageTemp) {
      imageAccount = imageTemp;
      setState(() {});
    });
  }

  Future<void> pickImageFrontNaionalGallery() async {
    await pickImage(ImageSource.gallery, (File imageTemp) {
      imageFront = imageTemp;
      setState(() {});
    });
  }

  Future<void> pickImageCameraFront() async {
    await pickImage(ImageSource.camera, (File imageTemp) {
      imageFront = imageTemp;
      setState(() {});
    });
  }

  Future<void> pickImageBackGallery() async {
    await pickImage(ImageSource.gallery, (File imageTemp) {
      imageBack = imageTemp;
      setState(() {});
    });
  }

  Future<void> pickImageCameraBack() async {
    await pickImage(ImageSource.camera, (File imageTemp) {
      imageBack = imageTemp;
      setState(() {});
    });
  }

  Future<void> pickImageContractGallery() async {
    await pickImage(ImageSource.gallery, (File imageTemp) {
      imageContract = imageTemp;
      setState(() {});
    });
  }

  Future<void> pickImageContractCamera() async {
    await pickImage(ImageSource.camera, (File imageTemp) {
      imageContract = imageTemp;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // background//color: BACKGROUNDCOLOR,
        appBar: CustomAppBar(
          title: 'createAccount'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderImageSelected(context),
                  textFormField("First name".tr(), fNameController,
                      textFieldSvg("person.svg"),
                      validation: (value) => Validator.name(value)),
                  const SizedBox(
                    height: 14,
                  ),
                  textFormField(
                      "email", emailController, textFieldSvg("email.svg"),
                      validation: (value) => Validator.email(value)),
                  const SizedBox(
                    height: 14,
                  ),
                  RegisterScreenStateIntlPhoneField(
                      phoneNumberController: phoneNumberController,
                      onChanged: (val) {
                        setState(() {
                          phoneNumberController.text = val;
                        });
                      }),
                  const SizedBox(
                    height: 14,
                  ),
                  textFormField("national_id", nationalIdNumberController,
                      textFieldSvg("national.svg"),
                      validation: (value) =>
                          Validator.nationalId(value, required: true),keyboardType:TextInputType.number ),
                  const SizedBox(
                    height: 14,
                  ),
                  textFormField("car_plate", carPlateNumberController,
                      textFieldSvg("plate.svg"),
                      validation: (value) =>
                          Validator.carPlateNumber(value, required: false),),
                  const SizedBox(
                    height: 20,
                  ),
                  frontImage(context),
                  20.height,
                  const Divider(
                    color: lightGray,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  backImage(context),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: lightGray,
                  ),
                  //    imageContractWidget(context),
                  //  ContractUploadWidget(),
                  BuildPdfPicker(
                    label: "contract_image".tr(), // ترجمة الاسم
                    onTapPickPdf: pickPdfFile,
                    pdfFile: imageContract,
                    context: context,
                  ),
                  15.height,

                  textFormField(
                    "yourAddress", addressController,
                    textFieldSvg("location.svg"),
                    // validation: (value) => Validator.registerAddress(value)
                    validation: (value) => null,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: textFormField("password", passwordController,
                            textFieldSvg("lock.svg"),
                            validation: (value) => Validator.password(value)),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: textFormField("confirmPassword",
                            confirmPasswordController, textFieldSvg("lock.svg"),
                            validation: (value) => Validator.password(value)),
                      ),
                    ],
                  ),
                  10.height,
                  Row(
                    children: [
                      Text(
                        "pressToAdd".tr(),
                        style: CustomTextStyle.semiBold12Black,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => addItemToList(),
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  10.height,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      return ExpandableContainer(
                        title: (itemSelected[index].selectedModel != null &&
                                itemSelected[index].buildingModel != null &&
                                itemSelected[index].levelModel != null &&
                                itemSelected[index].unitModel != null)
                            ? "${(index + 1).toString()} ⁃ ( ${itemSelected[index].selectedModel!.name.toString() + " - " + itemSelected[index].buildingModel!.BuildingModelName.toString() + " - " + itemSelected[index].levelModel!.levelsName.toString() + " - " + itemSelected[index].unitModel!.unitNumber.toString()}) "
                            : 'unitModel'.tr(),
                        isExpanded:
                            (itemSelected[index].selectedModel != null &&
                                    itemSelected[index].buildingModel != null &&
                                    itemSelected[index].levelModel != null &&
                                    itemSelected[index].unitModel != null)
                                ? false
                                : true,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'unitModel'.tr(),
                                      style: CustomTextStyle.semiBold12Black,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          itemList[index].unit = null;
                                          itemSelected[index].unitModel = null;
                                          itemList[index].build = null;
                                          itemSelected[index].buildingModel =
                                              null;
                                          itemList[index].level = null;
                                          itemSelected[index].levelModel = null;
                                          itemList[index].model = null;
                                          itemSelected[index].selectedModel =
                                              null;
                                          itemList.removeAt(index);
                                          itemSelected!.removeAt(index);

                                          setState(() {});
                                        },
                                        icon: Icon(Icons.close))
                                  ],
                                ),
                                ModelSelectionAlert(
                                  selectedModel:
                                      itemSelected[index].selectedModel,
                                  buildingModel:
                                      itemSelected[index].buildingModel,
                                  levelModel: itemSelected[index].levelModel,
                                  unitModel: itemSelected[index].unitModel,
                                  isRegister: true,
                                  onSelectModel: (value) async {
                                    selectedModel = value;
                                    itemSelected[index].selectedModel =
                                        selectedModel;
                                    itemList[index].model =
                                        selectedModel!.id.toString();

                                    ///----------------------------
                                    itemList[index].build = null;
                                    buildingModel = null;
                                    itemSelected[index].buildingModel = null;

                                    ///----------------------------
                                    itemList[index].level = null;
                                    levelModel = null;
                                    itemSelected[index].levelModel = null;

                                    ///----------------------------
                                    itemList[index].unit = null;
                                    unitModel = null;
                                    itemSelected[index].unitModel = null;

                                    ///----------------------------
                                    setState(() {});
                                    await unitsProvider?.getAllBuilding(
                                        context, value!.id.toString());
                                  },
                                  onSelectBuilding: (value) async {
                                    buildingModel = value;
                                    itemSelected[index].buildingModel =
                                        buildingModel;
                                    itemList[index].build =
                                        buildingModel!.id.toString();

                                    itemList[index].level = null;
                                    itemSelected[index].levelModel = null;
                                    levelModel = null;

                                    itemList[index].unit = null;
                                    itemSelected[index].unitModel = null;
                                    unitModel = null;

                                    setState(() {});
                                    await unitsProvider?.getAllLevel(
                                        context, value!.id.toString());
                                  },
                                  onSelectLevel: (value) async {
                                    levelModel = value;
                                    itemList[index].level =
                                        levelModel!.id.toString();
                                    itemSelected[index].levelModel = levelModel;

                                    itemList[index].unit = null;
                                    unitModel = null;
                                    setState(() {});
                                    await unitsProvider?.getUnitModel(
                                        context, value!.id.toString(),
                                        isLogin: false);
                                  },
                                  onSelectUnits: (value) {
                                    setState(() {
                                      unitModel = value;
                                      itemSelected[index].unitModel = unitModel;
                                      itemList[index].unit =
                                          unitModel!.id.toString();
                                    });
                                  },
                                ),
                                10.height,
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  10.height,
                  widgetWithAction.buttonAction<RegisterProvider>(
                      action: (model) {
                        if (_formKey.currentState!.validate()) {
                          // if (phoneNumberController.text.isEmpty) {
                          //   failedSnack(context, "phoneValidate");
                          // } else
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            failedSnack(
                                context, "error_wrong_password_confirm");
                          } else {
                            FocusManager.instance.primaryFocus?.unfocus();
                            // if (imageAccount == null) {
                            //   failedSnack(context, "error_image_account");
                            // } else if (imageFront == null) {
                            //   failedSnack(context, "error_image_front");
                            // } else if (imageBack == null) {
                            //   failedSnack(context, "error_image_back");
                            // }
                            // else
                            if (itemSelected.isEmpty || isAnyEmpty(itemList)) {
                              failedSnack(context, "error_unit");
                            } else if (imageContract == null) {
                              failedSnack(context, "contract_image");
                            } else {
                              model.register(
                                comId: widget.compoundData.id,
                                fullNameEn: fNameController.text,
                                fullNameAr: fNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                userType: "UintOwner",
                                userLanguage: "Ar",
                                userLanguageID: "1",
                                phoneNumber: phoneNumberController.text,
                                address: addressController.text,
                                context: context,
                                profilePic: imageAccount,
                                imageFront: imageFront,
                                imageBack: imageBack,
                                imageContract: imageContract,
                                unitsList: itemSelected.map((e) {
                                  return {"id": e.unitModel!.id.toString()};
                                }).toList(),
                                carPlateNumber: carPlateNumberController.text,
                                nationalIdNumber:
                                    nationalIdNumberController.text,
                              );
                            }
                          }
                        }
                      },
                      context: context,
                      text: "createAccount"),
                  30.height,
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "have an account".tr(),
                          style: CustomTextStyle.semiBold12Black
                              .copyWith(color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            pushRoute(
                                context: context, route: const LoginScreen());
                          },
                          child: Text(
                            "login".tr(),
                            style: CustomTextStyle.extraBold18Gray.copyWith(
                                fontSize: 13,
                                color: black,
                                decoration: TextDecoration.underline),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildImagePicker backImage(BuildContext context) {
    return buildImagePicker(
        label: "backImage".tr(),
        onTapCamera: pickImageCameraBack,
        onTapGallery: pickImageBackGallery,
        imageFile: imageBack,
        context: context);
  }

  buildImagePicker frontImage(BuildContext context) {
    return buildImagePicker(
        label: "frontImage".tr(),
        onTapCamera: pickImageCameraFront,
        onTapGallery: pickImageFrontNaionalGallery,
        imageFile: imageFront,
        context: context);
  }

  buildImagePicker imageContractWidget(BuildContext context) {
    return buildImagePicker(
        label: "contract_image".tr(),
        onTapCamera: pickImageContractCamera,
        onTapGallery: pickImageContractGallery,
        imageFile: imageContract,
        context: context);
  }

  Stack HeaderImageSelected(BuildContext context) {
    return Stack(
      children: [
        Center(
            child: imageAccount == null
                ? InkWell(
                    onTap: () => showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10))),
                        context: context,
                        builder: (context) => Container(
                              margin: const EdgeInsets.all(40),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Is
                                  InkWell(
                                      onTap: () => pickImageCameraAccount(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.camera,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Select From Camera",
                                            style:
                                                CustomTextStyle.semiBold12Black,
                                          ),
                                        ],
                                      )),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Divider(),
                                  ),
                                  InkWell(
                                    onTap: () => pickImageAccountGallery(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.photo_camera_back_outlined,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Select From Gallery",
                                          style:
                                              CustomTextStyle.semiBold12Black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Image.asset(
                          "assets/images/person.png",
                          width: 170,
                          height: 150,
                          color: Colors.black.withOpacity(0.4),
                        )),
                  )
                : InkWell(
                    onTap: () => showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10))),
                        context: context,
                        builder: (context) => Container(
                              margin: const EdgeInsets.all(40),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Is
                                  InkWell(
                                      onTap: () => pickImageCameraAccount(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.camera,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Select From Camera",
                                            style:
                                                CustomTextStyle.semiBold12Black,
                                          ),
                                        ],
                                      )),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Divider(),
                                  ),
                                  InkWell(
                                    onTap: () => pickImageAccountGallery(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.photo_camera_back_outlined,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Select From Gallery",
                                          style:
                                              CustomTextStyle.semiBold12Black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                    child: Container(
                      width: 120,
                      height: 120,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          File(imageAccount!.path),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  )),
        Positioned(
          bottom: imageAccount == null ? 30 : 0,
          right: 110,
          child: GestureDetector(
            onTap: () => showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))),
                context: context,
                builder: (context) => Container(
                      margin: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Is
                          InkWell(
                              onTap: () => pickImageCameraAccount(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.camera,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Select From Camera",
                                    style: CustomTextStyle.semiBold12Black,
                                  ),
                                ],
                              )),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(),
                          ),
                          InkWell(
                            onTap: () => pickImageAccountGallery(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.photo_camera_back_outlined,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Select From Gallery",
                                  style: CustomTextStyle.semiBold12Black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: SvgPicture.asset(
                  "assets/images/edit.svg",
                  color: white,
                  width: 18,
                  height: 20,
                )),
          ),
        ),
      ],
    );
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
}

// Center(
//   child: Image.asset(
//     ImagesConstants.logo,
//     width: 180,
//     height: 100,
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 15),
//   child: Center(
//     child: Text(
//       "pleaseEnterData".tr(),
//       style: CustomTextStyle.extraBold18Gray
//           .copyWith(fontSize: 8),
//       textAlign: TextAlign.center,
//     ),
//   ),
// ),

// Usage
