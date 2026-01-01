import 'dart:io';
import 'package:core_project/Model/UnitModel.dart';
import 'package:core_project/Model/user_info_model.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/View/Screen/PartAuth/LoginScreen.dart';
import 'package:core_project/View/Screen/PartAuth/build_image_picker.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
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
import '../../../helper/color_resources.dart';
import '../../Widget/DropDownWidgets.dart';
import '../../Widget/comman/CustomAppBar.dart';
import '__register_screen_state_intl_phone_field.dart';

//201235606058
class RegisterScreenSub extends StatefulWidget {
  @override
  State<RegisterScreenSub> createState() => _RegisterScreenSubState();
}

enum ContactMethod { phone, email }

class _RegisterScreenSubState extends State<RegisterScreenSub> {
  TextEditingController fNameController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmPasswordController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      phonePrimaryNumberController = TextEditingController(),
      emailController = TextEditingController(),
      nationalIdNumberController = TextEditingController(),
      carPlateNumberController = TextEditingController(),
      addressController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  File? imageFront;
  File? imageBack;
  File? imageAccount;
  File? birthdayImage;
  @override
  void dispose() {
    fNameController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
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

  Future<void> pickImageBirthdayImageGallery() async {
    await pickImage(ImageSource.gallery, (File imageTemp) {
      birthdayImage = imageTemp;
      setState(() {});
    });
  }

  Future<void> pickImageBirthdayImageCamera() async {
    await pickImage(ImageSource.camera, (File imageTemp) {
      birthdayImage = imageTemp;
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

  bool isCheck = false;
  Future<void> pickImageCameraBack() async {
    await pickImage(ImageSource.camera, (File imageTemp) {
      imageBack = imageTemp;
      setState(() {});
    });
  }

  OwnerData? ownerData;

  ContactMethod selectedMethod = ContactMethod.phone;

  TextEditingController phoneController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
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
                  const SizedBox(
                    height: 25,
                  ),
                  if (ownerData == null) ...[
                    Text(
                      "enterThePrimaryNumber".tr(),
                      style: CustomTextStyle.semiBold12Black
                          .copyWith(fontSize: 10, color: Colors.black),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio<ContactMethod>(
                              value: ContactMethod.phone,
                              groupValue: selectedMethod,
                              onChanged: (ContactMethod? value) {
                                setState(() {
                                  emailController.clear();
                                  selectedMethod = value!;
                                });
                              },
                            ),
                            Text('Phone'),
                            Radio<ContactMethod>(
                              value: ContactMethod.email,
                              groupValue: selectedMethod,
                              onChanged: (ContactMethod? value) {
                                setState(() {
                                  phonePrimaryNumberController.clear();
                                  selectedMethod = value!;
                                });
                              },
                            ),
                            Text('Email'),
                          ],
                        ),
                        if (selectedMethod == ContactMethod.phone)
                          RegisterScreenStateIntlPhoneField(
                            phoneNumberController: phonePrimaryNumberController,
                            onChanged: (val) {
                              setState(() {
                                phonePrimaryNumberController.text = val;
                              });
                            },
                            autoFoucs: true,
                          ),
                        if (selectedMethod == ContactMethod.email)
                          textFormField("email", emailController,
                              textFieldSvg("email.svg"),
                              validation: (value) => Validator.email(value)),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    // if (phonePrimaryNumberController.text.length >= 13)
                    widgetWithAction.buttonAction<RegisterProvider>(
                        action: (model) {
                          if (phonePrimaryNumberController.text.isEmpty &&
                              emailController.text.isEmpty) {
                            failedSnack(
                                context, "pleaseEnterEmailOrPhone".tr());
                          } else {
                            model
                                .getPrimaryAccount(
                                    context,
                                    phonePrimaryNumberController.text.isNotEmpty
                                        ? phonePrimaryNumberController.text
                                        : emailController.text,
                                    phonePrimaryNumberController.text.isNotEmpty
                                        ? null
                                        : emailController.text)
                                .then((value) {
                              setState(() {
                                ownerData = value;
                              });
                            });
                          }
                        },
                        context: context,
                        text: "suringPhoneMumber"),
                  ],
                  if (ownerData != null) ...[
                    Text("primaryAccountDara".tr(),
                        style: CustomTextStyle.bold14black),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "name".tr() + " : ",
                              style: CustomTextStyle.regular10Gray.copyWith(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              ownerData?.fullNameAr ?? "",
                              style: CustomTextStyle.regular10Gray
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Phone Number".tr() + " : ",
                              style: CustomTextStyle.regular10Gray.copyWith(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              ownerData?.phoneNumber ?? "",
                              style: CustomTextStyle.regular10Gray
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "email".tr() + " : ",
                              style: CustomTextStyle.regular10Gray.copyWith(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              ownerData?.email ?? "",
                              style: CustomTextStyle.regular10Gray
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ownerData == null
                        ? SizedBox()
                        : HeaderImageSelected(context, ownerData),
                    textFormField("First name".tr(), fNameController,
                        textFieldSvg("person.svg"),
                        validation: (value) => Validator.name(value),
                        enabled: ownerData == null ? false : true),
                    const SizedBox(
                      height: 14,
                    ),
                    textFormField(
                        "email", emailController, textFieldSvg("email.svg"),
                        validation: (value) => Validator.email(value),
                        enabled: ownerData == null ? false : true),
                    const SizedBox(
                      height: 14,
                    ),
                    ownerData == null
                        ? SizedBox()
                        : RegisterScreenStateIntlPhoneField(
                            phoneNumberController: phoneNumberController,
                            onChanged: (val) {
                              setState(() {
                                phoneNumberController.text = val;
                              });
                            }),
                    textFormField("car_plate", carPlateNumberController,
                      textFieldSvg("plate.svg"),
                      validation: (value) =>
                          Validator.carPlateNumber(value, required: false),),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          child: MSHCheckbox(
                              size: 20,
                              value: isCheck,
                              colorConfig:
                                  MSHColorConfig.fromCheckedUncheckedDisabled(
                                      uncheckedColor: Colors.red,
                                      checkedColor:
                                          Theme.of(context).primaryColor),
                              checkedColor: Theme.of(context).primaryColor,
                              style: MSHCheckboxStyle.fillFade,
                              onChanged: (selected) {
                                setState(() {
                                  isCheck = selected;
                                });
                              }),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "under 16 years old".tr(),
                          style: CustomTextStyle.aMainButtonTextStyle.copyWith(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),


                    if (!isCheck) ...[
                      textFormField("national_id", nationalIdNumberController,
                          textFieldSvg("national.svg"),
                          validation: (value) =>
                              Validator.nationalId(value, required: true),keyboardType:TextInputType.number ),
                      SizedBox(
                        height: 20,
                      ),

                      ownerData == null
                          ? SizedBox()
                          : frontImage(context, ownerData),
                      ownerData == null ? SizedBox() : 20.height,
                      ownerData == null
                          ? SizedBox()
                          : const Divider(
                              color: lightGray,
                            ),
                      ownerData == null
                          ? SizedBox()
                          : const SizedBox(
                              height: 10,
                            ),
                      ownerData == null
                          ? SizedBox()
                          : backImage(context, ownerData),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                    if (isCheck) ...[
                      imageBirthdayImage(context),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                    if (!isCheck) ...[
                      textFormField("yourAddress", addressController,
                          textFieldSvg("location.svg"),
                          validation: (value) =>
                              Validator.registerAddress(value),
                          enabled: ownerData == null ? false : true),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: textFormField("password", passwordController,
                              textFieldSvg("lock.svg"),
                              validation: (value) => Validator.password(value),
                              enabled: ownerData == null ? false : true),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: textFormField(
                              "confirmPassword",
                              confirmPasswordController,
                              textFieldSvg("lock.svg"),
                              validation: (value) => Validator.password(value),
                              enabled: ownerData == null ? false : true),
                        ),
                      ],
                    ),
                    10.height,
                    ownerData == null
                        ? SizedBox()
                        : widgetWithAction.buttonAction<RegisterProvider>(
                            action: (model) {
                              if (_formKey.currentState!.validate()) {
                                if (phoneNumberController.text.isEmpty) {
                                  failedSnack(context, "phoneValidate");
                                } else if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  failedSnack(
                                      context, "error_wrong_password_confirm");
                                } else {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (imageAccount == null) {
                                    failedSnack(context, "error_image_account");
                                  } else if (isCheck == false &&
                                      imageFront == null) {
                                    failedSnack(context, "error_image_front");
                                  } else if (isCheck == false &&
                                      imageBack == null) {
                                    failedSnack(context, "error_image_back");
                                  } else if (isCheck == true &&
                                      birthdayImage == null) {
                                    failedSnack(
                                        context, "error_birth_Certificate");
                                  } else {
                                    print(ownerData!.id.toString());
                                    model.registerSub(
                                      fullNameEn: fNameController.text,
                                      fullNameAr: fNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      userType: "UintOwner",
                                      userLanguage: "Ar",
                                      userLanguageID: "1",
                                      primaryOwnerId: ownerData!.id.toString(),
                                      phoneNumber: phoneNumberController.text,
                                      address: addressController.text,
                                      context: context,
                                      profilePic: imageAccount,
                                      birthImage: birthdayImage,
                                      imageFront: imageFront,
                                      imageBack: imageBack,
                                      comId: ownerData?.compID, carPlateNumber: carPlateNumberController.text, nationalIdNumber:nationalIdNumberController.text,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildImagePicker backImage(BuildContext context, OwnerData? ownerData) {
    return buildImagePicker(
        label: "backImage".tr(),
        onTapCamera: pickImageCameraBack,
        onTapGallery: pickImageBackGallery,
        imageFile: imageBack,
        context: context);
  }

  buildImagePicker frontImage(BuildContext context, OwnerData? ownerData) {
    return buildImagePicker(
        label: "frontImage".tr(),
        onTapCamera: pickImageCameraFront,
        onTapGallery: pickImageFrontNaionalGallery,
        imageFile: imageFront,
        context: context);
  }

  buildImagePicker imageBirthdayImage(BuildContext context) {
    return buildImagePicker(
        label: "birth certificate".tr(),
        onTapCamera: pickImageBirthdayImageCamera,
        onTapGallery: pickImageBirthdayImageGallery,
        imageFile: birthdayImage,
        context: context);
  }

  Stack HeaderImageSelected(BuildContext context, OwnerData? ownerData) {
    return Stack(
      children: [
        Center(
            child: imageAccount == null
                ? InkWell(
                    onTap: () {
                      if (ownerData == null) {
                      } else {
                        showModalBottomSheet(
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
                                                style: CustomTextStyle
                                                    .semiBold12Black,
                                              ),
                                            ],
                                          )),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
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
                                              style: CustomTextStyle
                                                  .semiBold12Black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                      }
                    },
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
                    onTap: () {
                      if (ownerData == null) {
                      } else {
                        showModalBottomSheet(
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
                                                style: CustomTextStyle
                                                    .semiBold12Black,
                                              ),
                                            ],
                                          )),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
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
                                              style: CustomTextStyle
                                                  .semiBold12Black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                      }
                    },
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
