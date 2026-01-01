import 'dart:io';

import 'package:core_project/Model/ALLModelModel.dart';
import 'package:core_project/Model/BuildingModel.dart';
import 'package:core_project/Model/GetUserModel.dart';
import 'package:core_project/Model/LevelModel.dart';
import 'package:core_project/Model/SharedTypeSelected.dart';
import 'package:core_project/Model/UnitModel.dart';
import 'package:core_project/Model/UnitUserFull.dart';
import 'package:core_project/Provider/UnitsProvider.dart';
import 'package:core_project/Utill/ExpandableContainer.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/Utill/once_future_builder.dart';
import 'package:core_project/View/Screen/PartAuth/BuildPdfPicker.dart';
import 'package:core_project/View/Screen/PartAuth/__register_screen_state_intl_phone_field.dart';
import 'package:core_project/View/Widget/DropDownWidgets.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:file_picker/file_picker.dart';
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
import 'package:widget_zoom/widget_zoom.dart';
import '../../../Provider/RegisterProvider.dart';
import '../../../Utill/Comman.dart';
import '../../../Utill/Local_User_Data.dart';
import '../../../helper/ButtonAction.dart';
import '../../../helper/ImagesConstant.dart';
import '../../../helper/SnackBarScreen.dart';
import '../../../helper/app_constants.dart';
import '../../../helper/color_resources.dart';
import '../../Widget/comman/CustomAppBar.dart';
import '../SuperAdminScreens/OwnersManagement/ContractPdfButton.dart';
import '../SuperAdminScreens/OwnersManagement/PdfViewerScreen.dart';

class EditAccountbefourAccept extends StatefulWidget {
  const EditAccountbefourAccept({Key? key}) : super(key: key);

  @override
  State<EditAccountbefourAccept> createState() =>
      _EditAccountbefourAcceptState();
}

class _EditAccountbefourAcceptState extends State<EditAccountbefourAccept> {
  String? ownershipContract;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addessController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  UnitsProvider? unitsProvider;
  ALLModelModel? selectedModel;
  BuildingModel? buildingModel;
  LevelModel? levelModel;
  UnitModel? unitModel;
  List<UnitUserFull> itemList = [];

  bool loading = true;
  List<SharedTypeSelected> itemSelected = [];
  File? imageAccount;
  File? imageContract;
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        phoneNumberController.text = globalAccountData.getPhoneNumber() ?? "";
        emailController.text = globalAccountData.getEmail() ?? "";
        fullNameController.text = globalAccountData.getUsername() ?? "";
        addessController.text = globalAccountData.getAddress() ?? "";

      });
    });
    super.initState();
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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
              title: 'EditAccount'.tr(),
              backgroundImage: AssetImage(ImagesConstants.backgroundImage),
            ),
            body: Consumer<RegisterProvider>(builder: (context, model, child) {
              return OnceFutureBuilder(future: () async {
                Future.wait([
                  model.getUserById(context),
                ]).then((userData) {
                  try {
                    GetUserModel? user = userData.first;
                    String? phone=user?.phoneNumber?.replaceFirst("+20", "");
                    phoneNumberController.text = phone ??
                        globalAccountData.getPhoneNumber() ??
                        "";
                    emailController.text =
                        user?.email ?? globalAccountData.getEmail() ?? "";
                    fullNameController.text =
                        user?.name ?? globalAccountData.getUsername() ?? "";
                    addessController.text =
                        user?.address ?? globalAccountData.getAddress() ?? "";
                  ownershipContract=user?.ownershipContract;

                    print("ownershipContract${ownershipContract}");
                    if(user?.unitModelID!=null)
                      {
                        addItemToList();
                        unitsProvider =
                            Provider.of<UnitsProvider>(context, listen: false);
                        unitsProvider
                            ?.getAllModel(context,
                            comId: int.tryParse(
                                globalAccountData.getCompoundId().toString()))
                            .then((value) {
                          selectedModel = unitsProvider?.aLLModelModelList
                              .where((element) => element.id == user?.unitModelID)
                              .cast<ALLModelModel?>()
                              .firstOrNull;
                          itemSelected[0].selectedModel = selectedModel;

                          unitsProvider
                              ?.getAllBuilding(
                              context, (selectedModel?.id ?? "").toString())
                              .then((value) {
                            buildingModel = unitsProvider?.buildingList
                                .where((element) => element.id == user?.buildingID)
                                .cast<BuildingModel?>()
                                .firstOrNull;
                            itemSelected[0].buildingModel = buildingModel;

                            unitsProvider
                                ?.getAllLevel(
                                context, (buildingModel?.id ?? "").toString())
                                .then((value) {
                              levelModel = unitsProvider?.levelList
                                  .where((element) => element.id == user?.roundID)
                                  .cast<LevelModel?>()
                                  .firstOrNull;
                              itemSelected[0].levelModel = levelModel;
                              setState(() {});

                              unitsProvider
                                  ?.getUnitModel(
                                  context, (levelModel?.id ?? "").toString(),
                                  isLogin: false)
                                  .then((value) {
                                unitModel = unitsProvider?.unitList
                                    .where((element) => element.id == user?.unitID)
                                    .cast<UnitModel?>()
                                    .firstOrNull;
                                itemSelected[0].unitModel = unitModel;
                                loading = false;
                                setState(() {});
                              });
                            });

                            setState(() {});
                          });

                          setState(() {});
                        });
                      }else{
                      loading=false;
                      setState(() {

                      });
                    }

                  } catch (e) {
                    if (kDebugMode) {
                      debugPrint("Errorrrr");
                      debugPrint(e.toString());
                    }
                  }
                });
              }, builder: (ctx, snapShot) {
                //  debugPrint("selected lang ${model.selectedItemsLang[0].name}");

                return Container(
                    width: w(context),
                    height: h(context),
                    // color: BACKGROUNDCOLOR.withOpacity(0.7),
                    child: loading
                        ? Column(
                            children: [
                              100.height,
                              Center(child: LoaderWidget()),
                            ],
                          )
                        : SingleChildScrollView(
                            child: Form(
                              key: _globalKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    17.height,
                                    Container(
                                      width: 220,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              ImagesConstants.backGroundOrder),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "EditAccount".tr(),
                                        style: CustomTextStyle.bold14White,
                                      )),
                                    ),
                                    17.height,
                                    // HeaderImageSelected(context),
                                    // 17.height,
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: w(context),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            10.height,
                                            textFormField(
                                                "fullName",
                                                fullNameController,
                                                Icon(
                                                  Icons.person_3_outlined,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                validation: (value) =>
                                                    Validator.name(value)),
                                            10.height,
                                            textFormField(
                                                "email",
                                                emailController,
                                                Icon(
                                                  Icons.email_outlined,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                validation: (value) =>
                                                    Validator.password(value),
                                                enabled: false),
                                            10.height,

                                            RegisterScreenStateIntlPhoneField(
                                              phoneNumberController: phoneNumberController,
                                              onChanged: (val) {
                                                setState(() {
                                                  phoneNumberController.text = val;
                                                });
                                              },
                                              autoFoucs: true,
                                            ),
                                            // textFormField(
                                            //     "Phone Number",
                                            //     phoneNumberController,
                                            //     Icon(
                                            //       Icons.phone_android,
                                            //       color: Theme.of(context)
                                            //           .primaryColor,
                                            //     ),
                                            //     validation: (value) =>
                                            //         Validator.password(value)),
                                            textFormField(
                                              "yourAddress", addessController,
                                              Icon(
                                                Icons.location_history,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              // validation: (value) => Validator.registerAddress(value)
                                              validation: (value) =>
                                                  Validator.defaultValidator(value),
                                            ),



                                            10.height,

                                            Card(
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Column(
                                                  children: [
                                                    // --- معاينة العقد ---
                                                    GestureDetector(
                                                      onTap: () {

                                                        print("ownershipContract ${ownershipContract}");
                                                        if (ownershipContract != null && ownershipContract!.contains(".pdf")) {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) => PdfViewerScreen(pdfUrl: "${AppConstants.BASE_URL_IMAGE}${ownershipContract!}"),
                                                            ),
                                                          );
                                                          // ContractPdfButton(
                                                          //   pdfUrl: "${AppConstants.BASE_URL_IMAGE}${ownershipContract!}",
                                                          // );
                                                        }
                                                        else if (ownershipContract != null && ownershipContract != "No files") {
                                                          // فتح الصورة مكبرة
                                                          showBottomSheet(
                                                              context: context,
                                                              builder: (_) {
                                                                return WidgetZoom(
                                                                  heroAnimationTag: 'tag',
                                                                  zoomWidget: cachedImage(
                                                                    ownershipContract!,
                                                                    width: 150,
                                                                    height: 150,
                                                                  ),
                                                                );
                                                              });
                                                        }
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 150,
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey[200],
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                        child: Center(
                                                          child: ownershipContract != null && ownershipContract!.contains(".pdf")
                                                              ? Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Icon(Icons.picture_as_pdf, size: 50, color: Colors.red),
                                                              SizedBox(width: 10),
                                                              Text("اضغط لرؤيه العقد الحالي"),
                                                            ],
                                                          )
                                                              : ownershipContract != null && ownershipContract != "No files"
                                                              ? cachedImage(ownershipContract!, width: 100, height: 100)
                                                              : Text("لا يوجد عقد", style: TextStyle(color: Colors.grey)),
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(height: 10),

                                                    const Divider(
                                                      color: lightGray,
                                                    ),
                                                    // --- زر تعديل / رفع العقد ---
                                                    BuildPdfPicker(
                                                      label: "تعديل / رفع العقد",
                                                      onTapPickPdf: pickPdfFile,
                                                      pdfFile: imageContract,
                                                      context: context,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            10.height,
                                          ],
                                        ),
                                      ),
                                    ),
                                    // 10.height,
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "pressToAdd".tr(),
                                    //       style: CustomTextStyle.semiBold12Black,
                                    //     ),
                                    //     Spacer(),
                                    //     GestureDetector(
                                    //       onTap: () => addItemToList(),
                                    //       child: Container(
                                    //         padding: EdgeInsets.all(4),
                                    //         decoration: BoxDecoration(
                                    //           shape: BoxShape.circle,
                                    //           border: Border.all(color: Colors.grey),
                                    //         ),
                                    //         child: Icon(Icons.add),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    10.height,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: itemList.length,
                                        itemBuilder: (context, index) {
                                          return ExpandableContainer(
                                            title:
                                                (itemSelected[index]
                                                                .selectedModel !=
                                                            null &&
                                                        itemSelected[index]
                                                                .buildingModel !=
                                                            null &&
                                                        itemSelected[index]
                                                                .levelModel !=
                                                            null &&
                                                        itemSelected[index]
                                                                .unitModel !=
                                                            null)
                                                    ? "${(index + 1).toString()} ⁃ ( ${itemSelected[index].selectedModel!.name.toString() + " - " + itemSelected[index].buildingModel!.BuildingModelName.toString() + " - " + itemSelected[index].levelModel!.levelsName.toString() + " - " + itemSelected[index].unitModel!.unitNumber.toString()}) "
                                                    : 'unitModel'.tr(),
                                            isExpanded: (itemSelected[index]
                                                            .selectedModel !=
                                                        null &&
                                                    itemSelected[
                                                                index]
                                                            .buildingModel !=
                                                        null &&
                                                    itemSelected[index]
                                                            .levelModel !=
                                                        null &&
                                                    itemSelected[index]
                                                            .unitModel !=
                                                        null)
                                                ? false
                                                : true,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'unitModel'.tr(),
                                                          style: CustomTextStyle
                                                              .semiBold12Black,
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              itemList[index]
                                                                  .unit = null;
                                                              itemSelected[
                                                                          index]
                                                                      .unitModel =
                                                                  null;
                                                              itemList[index]
                                                                  .build = null;
                                                              itemSelected[
                                                                          index]
                                                                      .buildingModel =
                                                                  null;
                                                              itemList[index]
                                                                  .level = null;
                                                              itemSelected[
                                                                          index]
                                                                      .levelModel =
                                                                  null;
                                                              itemList[index]
                                                                  .model = null;
                                                              itemSelected[
                                                                          index]
                                                                      .selectedModel =
                                                                  null;
                                                              itemList.removeAt(
                                                                  index);
                                                              itemSelected!
                                                                  .removeAt(
                                                                      index);

                                                              setState(() {});
                                                            },
                                                            icon: Icon(
                                                                Icons.close))
                                                      ],
                                                    ),
                                                    ModelSelectionAlert(
                                                      selectedModel:
                                                          itemSelected[index]
                                                              .selectedModel,
                                                      buildingModel:
                                                          itemSelected[index]
                                                              .buildingModel,
                                                      levelModel:
                                                          itemSelected[index]
                                                              .levelModel,
                                                      unitModel:
                                                          itemSelected[index]
                                                              .unitModel,
                                                      isRegister: true,
                                                      onSelectModel:
                                                          (value) async {
                                                        selectedModel = value;
                                                        itemSelected[index]
                                                                .selectedModel =
                                                            selectedModel;
                                                        itemList[index].model =
                                                            selectedModel!.id
                                                                .toString();

                                                        ///----------------------------
                                                        itemList[index].build =
                                                            null;
                                                        buildingModel = null;
                                                        itemSelected[index]
                                                                .buildingModel =
                                                            null;

                                                        ///----------------------------
                                                        itemList[index].level =
                                                            null;
                                                        levelModel = null;
                                                        itemSelected[index]
                                                            .levelModel = null;

                                                        ///----------------------------
                                                        itemList[index].unit =
                                                            null;
                                                        unitModel = null;
                                                        itemSelected[index]
                                                            .unitModel = null;

                                                        ///----------------------------
                                                        setState(() {});
                                                        await unitsProvider
                                                            ?.getAllBuilding(
                                                                context,
                                                                value!.id
                                                                    .toString());
                                                      },
                                                      onSelectBuilding:
                                                          (value) async {
                                                        buildingModel = value;
                                                        itemSelected[index]
                                                                .buildingModel =
                                                            buildingModel;
                                                        itemList[index].build =
                                                            buildingModel!.id
                                                                .toString();

                                                        itemList[index].level =
                                                            null;
                                                        itemSelected[index]
                                                            .levelModel = null;
                                                        levelModel = null;

                                                        itemList[index].unit =
                                                            null;
                                                        itemSelected[index]
                                                            .unitModel = null;
                                                        unitModel = null;

                                                        setState(() {});
                                                        await unitsProvider
                                                            ?.getAllLevel(
                                                                context,
                                                                value!.id
                                                                    .toString());
                                                      },
                                                      onSelectLevel:
                                                          (value) async {
                                                        levelModel = value;
                                                        itemList[index].level =
                                                            levelModel!.id
                                                                .toString();
                                                        itemSelected[index]
                                                                .levelModel =
                                                            levelModel;

                                                        itemList[index].unit =
                                                            null;
                                                        unitModel = null;
                                                        setState(() {});
                                                        await unitsProvider
                                                            ?.getUnitModel(
                                                                context,
                                                                value!.id
                                                                    .toString(),
                                                                isLogin: false);
                                                      },
                                                      onSelectUnits: (value) {
                                                        setState(() {
                                                          unitModel = value;
                                                          itemSelected[index]
                                                                  .unitModel =
                                                              unitModel;
                                                          itemList[index].unit =
                                                              unitModel!.id
                                                                  .toString();
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
                                    ),
                                    100.height,
                                    widgetWithAction
                                        .buttonAction<RegisterProvider>(
                                            action: (model) {
                                              if (_globalKey.currentState!
                                                  .validate()) {
                                                if (imageContract == null&&(ownershipContract??"").isEmpty) {
                                                  failedSnack(context, "contract_image");
                                                }
                                              else  if (phoneNumberController
                                                        .text.isEmpty ||
                                                    fullNameController
                                                        .text.isEmpty) {


                                                } else {
                                                  model.updateAccountDataBefourAcceptu(
                                                      email:
                                                          emailController.text,
                                                      name: fullNameController
                                                          .text,
                                                      profilePic: imageAccount,
                                                      phone:
                                                          phoneNumberController
                                                              .text,
                                                      context: context,
                                                      address: addessController
                                                          .text, unitId: unitModel?.id, ownershipContract: imageContract, ownershipContractString: ownershipContract);
                                                }
                                              }
                                            },
                                            context: context,
                                            text: "sendRequest")
                                  ]),
                            ),
                          ));
              });
            })));
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
                          border: Border.all(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: cachedImage(
                            globalAccountData.getProfilePic() ?? "",
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
