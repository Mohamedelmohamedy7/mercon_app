import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
//import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
void showImagePopup(BuildContext context, String? imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: cachedImage(imageUrl),
            ),

            // Close button
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),

            // Download button
            Positioned(
              bottom: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  if (imageUrl != null) {
                    downloadImage(imageUrl, context);
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: Icon(Icons.download, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}


Future<void> downloadImage(String imageUrl, BuildContext context) async {
  final granted = await requestStoragePermission();

  if (!granted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Permission denied. Please enable from settings.'),
        action: SnackBarAction(
          label: 'Settings',
          onPressed: () => openAppSettings(),
        ),
      ),
    );
    return;
  }

  // حفظ الصورة في المعرض
  bool? success = await GallerySaver.saveImage("${AppConstants.BASE_URL_IMAGE}/$imageUrl");

  if (success == true) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image saved to gallery')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to save image')),
    );
  }
}
Future<void> requestPermission() async {
  await Permission.storage.request();
}
// void downloadImageToGallery(String imageUrl) async {
//   await requestPermission();
//   await GallerySaver.saveImage(imageUrl);
// }
// Future<void> downloadImage(String imageUrl, BuildContext context) async {
//   try {
//     final status = await Permission.storage.request();
//     if (!status.isGranted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Storage permission denied')),
//       );
//       return;
//     }
//
//     final dir = await getExternalStorageDirectory();
//     final fileName = imageUrl.split('/').last;
//     final savePath = '${dir!.path}/$fileName';
//
//     await Dio().download(imageUrl, savePath);
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Downloaded to $savePath')),
//     );
//   } catch (e) {
//     print('Download error: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Failed to download image')),
//     );
//   }
// }


Future<bool> requestStoragePermission() async {
  if (await Permission.photos.isGranted) return true;
  final status = await Permission.photos.request();
  return status.isGranted;
}

