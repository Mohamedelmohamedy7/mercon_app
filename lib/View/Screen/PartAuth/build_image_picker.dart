import 'dart:io';

import 'package:core_project/helper/text_style.dart';
import 'package:flutter/material.dart';

import '../../../helper/color_resources.dart';

class buildImagePicker extends StatelessWidget {
  const buildImagePicker({
    super.key,
    required this.label,
    required this.onTapCamera,
    required this.onTapGallery,
    required this.imageFile,
    required this.context,
  });

  final String label;
  final Function() onTapCamera;
  final Function() onTapGallery;
  final File? imageFile;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        context: context,
        builder: (context) => Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: onTapCamera,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.camera),
                    const SizedBox(width: 10),
                    Text(
                      "Select From Camera",
                      style: CustomTextStyle.semiBold12Black,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              InkWell(
                onTap: onTapGallery,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.photo_camera_back_outlined),
                    const SizedBox(width: 10),
                    Text(
                      "Select From Gallery",
                      style: CustomTextStyle.semiBold12Black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      child: imageFile == null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: BLACK,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 10),
                const Spacer(),
                Icon(
                  Icons.upload_file,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 10),
              ],
            )
          : Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
    );
  }
}
