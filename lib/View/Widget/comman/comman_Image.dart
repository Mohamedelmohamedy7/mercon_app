import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Utill/Comman.dart';

SvgPicture svgPictureImage(image){
  return SvgPicture.asset(image.toString().contains("assets")?"$image":"assets/$image");
}

/// returns Image(Local,Network)
Widget cachedImage(
    String? url, {
      double? height,
      double? width,
      BoxFit? fit,
      Color ? color,
      AlignmentGeometry? alignment,
      bool usePlaceholderIfUrlEmpty = true,
    }) {
   if (url == null||url=="") {
    return placeHolderWidget(
        height: height, width: width, fit: fit, alignment: alignment);
  } else if (!url.startsWith('assets')) {
    return CachedNetworkImage(
      imageUrl: url.startsWith("http")?url:"${AppConstants.BASE_URL_IMAGE}/$url",
      height: height,
      width: width,
      fit: fit,
      color: color ?? null,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(
            height: height, width: width, fit: fit, alignment: alignment);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return const SizedBox();
        return Loading();
       // return Center(child: CircularProgressIndicator());
        // return placeHolderWidget(
        //     height: height, width: width, fit: fit, alignment: alignment);
      },
    );
  } else {
    return Image.asset(url,
        height: height,
        width: width,
        fit: fit,  color: color ?? null,
        alignment: alignment ?? Alignment.center);
  }
}