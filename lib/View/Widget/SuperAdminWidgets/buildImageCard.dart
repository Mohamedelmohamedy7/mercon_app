import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/View/Widget/comman/show_full_image.dart';
import 'package:flutter/material.dart';

Widget buildImageCard(String? imageUrl,{required BuildContext context}) {
  return GestureDetector(
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: cachedImage(
          imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    ),
    onTap: () {
      showImagePopup(context, imageUrl);
    },
  );
}