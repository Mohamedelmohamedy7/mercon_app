import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../helper/text_style.dart';
import '../../../helper/color_resources.dart';
import '../../../helper/SnackBarScreen.dart';

class BuildPdfPicker extends StatelessWidget {
  const BuildPdfPicker({
    super.key,
    required this.label,
    required this.onTapPickPdf,
    required this.pdfFile,
    required this.context,
  });

  final String label;
  final Function() onTapPickPdf;
  final File? pdfFile;
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
                onTap: () {
                  Navigator.pop(context);
                  onTapPickPdf();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Icon(Icons.picture_as_pdf, color: Theme.of(context).primaryColor,),
                    const SizedBox(width: 10),
                    Text(
                      "Select PDF File",
                      style: CustomTextStyle.semiBold12Black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      child: pdfFile == null
          ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
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
              Icons.picture_as_pdf_outlined,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 10),
                    ],
                  ),
          )
          : Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
             Icon(Icons.picture_as_pdf, color: Theme.of(context).primaryColor,),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                pdfFile!.path.split('/').last,
                style: CustomTextStyle.semiBold12Black,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
