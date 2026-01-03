import 'dart:io';

import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:core_project/Utill/validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:provider/provider.dart';
import '../../../Provider/RegisterProvider.dart';
import '../../../Utill/Comman.dart';
import '../../../Utill/Local_User_Data.dart';
import '../../../helper/ButtonAction.dart';
import '../../../helper/ImagesConstant.dart';
import '../../../helper/SnackBarScreen.dart';
import '../../../helper/color_resources.dart';
import '../../Widget/comman/CustomAppBar.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController  fullNameController = TextEditingController();
  TextEditingController addessController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  File? imageAccount;
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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        phoneNumberController.text = globalAccountData.getPhoneNumber()??"";
        emailController.text = globalAccountData.getEmail()??"";
        fullNameController.text = globalAccountData.getUsername()??"";
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            title: 'EditAccount'.tr(),
            backgroundImage: AssetImage(ImagesConstants.backgroundImage),
          ),
          body: Container(
              width: w(context),
              height: h(context),
              // color: BACKGROUNDCOLOR.withOpacity(0.7),
              child: SingleChildScrollView(
                child: Form(
                  key: _globalKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 17.height,
                        // Container(
                        //   width: 220,
                        //   height: 48,
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image:
                        //       AssetImage(ImagesConstants.backGroundOrder),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        //   child: Center(
                        //       child: Text(
                        //         "EditAccount".tr(),
                        //         style: CustomTextStyle.bold14White,
                        //       )),
                        // ),
                        17.height,
                        HeaderImageSelected(context),
                        17.height,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
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


                                10.height,
                                textFormField(
                                    "fullName",
                                    fullNameController,
                                    Icon(
                                      Icons.person_3_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    validation: (value) =>
                                        Validator.name(value)),
                                10.height,
                                textFormField(
                                    "email",
                                    emailController,
                                    Icon(
                                      Icons.email_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    validation: (value) =>
                                        Validator.password(value),enabled: false

                                ),
                                10.height,
                                textFormField(
                                    "Phone Number",
                                    phoneNumberController,
                                    Icon(
                                      Icons.phone_android,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    validation: (value) =>
                                        Validator.password(value)),
                                10.height,
                              ],
                            ),
                          ),
                        ),
                        100.height,
                        widgetWithAction.buttonAction<RegisterProvider>(
                            action: (model) {
                              if (_globalKey.currentState!.validate()) {
                                if (phoneNumberController.text.isEmpty||fullNameController.text.isEmpty) {

                                } else {
                                  model.updateAccountData(
                                      email: emailController.text,
                                      name: fullNameController.text,
                                      profilePic: imageAccount,
                                      phone: phoneNumberController.text,
                                      context: context);
                                }
                              }
                            },
                            context: context,text: "sendRequest")
                      ]),
                ),
              ))),
    );
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
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(150),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: cachedImage(
                      globalAccountData.getProfilePic()??"",
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
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
                width: 130,
                height: 130,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.file(
                    File(imageAccount!.path),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            )),
        Positioned(
          bottom: imageAccount == null ? 10 : 0,
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
      final image = await ImagePicker().pickImage(source: source);

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

