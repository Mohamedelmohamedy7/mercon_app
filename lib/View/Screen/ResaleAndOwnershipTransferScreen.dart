import 'dart:io';

import 'package:core_project/Model/UnitModel.dart';
import 'package:core_project/Provider/UnitsProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
 import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Model/ALLModelModel.dart';
import '../../Model/BuildingModel.dart';
 import '../../Model/LevelModel.dart';
 import '../../Utill/Local_User_Data.dart';
import '../../helper/ImagesConstant.dart';
 import '../../helper/app_constants.dart';
import '../Widget/DropDownWidgets.dart';
import '../Widget/comman/CustomAppBar.dart';
import 'PartAuth/build_image_picker.dart';

class ResaleAndOwnershipTransferScreen extends StatefulWidget {
  final bool needBack;

  const ResaleAndOwnershipTransferScreen({
    Key? key,
    required this.needBack,
  }) : super(key: key);

  @override
  State<ResaleAndOwnershipTransferScreen> createState() =>
      _ResaleAndOwnershipTransferScreenState();
}

class _ResaleAndOwnershipTransferScreenState
    extends State<ResaleAndOwnershipTransferScreen> {
  int selectedType = 0; // 0 = resale , 1 = transfer
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
          title: 'resale_and_transfer_requests'.tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ===== نوع الطلب =====
              Row(
                children: [
                  _buildTypeButton(
                    title: 'resale'.tr(),
                    isSelected: selectedType == 0,
                    onTap: () {
                      setState(() => selectedType = 0);
                    },
                  ),
                  const SizedBox(width: 12),
                  _buildTypeButton(
                    title: 'ownership_transfer'.tr(),
                    isSelected: selectedType == 1,
                    onTap: () {
                      setState(() => selectedType = 1);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// ===== الحقول =====
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
                      isLogin:
                      (
                          globalAccountData.getUserType() == AppConstants.IS_SuperAdmin||
                              globalAccountData.getUserType() == AppConstants.IS_FullSuperAdmin||
                              globalAccountData.getUserType() ==
                                  AppConstants.IS_Supervisor||
                              globalAccountData.getUserType() ==
                                  AppConstants.IS_CustomerService)
                          ? false
                          : true);
                },
                onSelectBuilding: (value) {
                  setState(() {
                    buildingModel = value;
                    levelModel = null;
                    unitModel = null;
                  });
                  unitsProvider?.getAllLevel(
                      context, buildingModel!.id.toString(),
                      isLogin:
                      (
                          globalAccountData.getUserType() == AppConstants.IS_SuperAdmin||
                              globalAccountData.getUserType() == AppConstants.IS_FullSuperAdmin||
                              globalAccountData.getUserType() ==
                                  AppConstants.IS_Supervisor||
                              globalAccountData.getUserType() ==
                                  AppConstants.IS_CustomerService)
                          ? false
                          : true);
                },
                onSelectLevel: (value) {
                  setState(() {
                    levelModel = value;
                    unitModel = null;
                  });
                  unitsProvider?.getUnitModel(
                      context, levelModel!.id.toString(),
                      isLogin:
                      (
                          globalAccountData.getUserType() == AppConstants.IS_SuperAdmin||
                              globalAccountData.getUserType() == AppConstants.IS_FullSuperAdmin||
                              globalAccountData.getUserType() ==
                                  AppConstants.IS_Supervisor||
                              globalAccountData.getUserType() ==
                                  AppConstants.IS_CustomerService)
                          ? false
                          : true);
                },
                onSelectUnits: (value) {
                  setState(() {
                    unitModel = value;
                  });
                },
              ),
              SizedBox(height: 10),
              _buildTextField(hint: 'current_owner_name'.tr()),
              _buildTextField(hint: 'new_owner_name'.tr()),

              const SizedBox(height: 16),

              /// ===== إرفاق مستندات =====
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'attach_documents'.tr(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff695C4C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildUploadCard(
                      icon: Icons.image_outlined,
                      title: 'upload_image'.tr(),
                      onTap: () {
                         pickImageFrontNaionalGallery();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildUploadCard(
                      icon: Icons.description_outlined,
                      title: 'upload_file'.tr(),
                      onTap: () {
                         pickImageFrontNaionalGallery();
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// ===== زر الإرسال =====
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF695C4C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'submit_request'.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= Widgets =================

  Widget _buildTypeButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF695C4C)
                : const Color(0xFFF6EFE7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xff695C4C),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTextField({required String hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xff9E9488),
            fontSize: 13,
          ),
          filled: true,
          fillColor: const Color(0xFFF6EFE7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildUploadCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: const Color(0xFFF6EFE7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: const Color(0xff695C4C)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xff695C4C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
