import 'package:core_project/Provider/QrCodeProvider.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../Widget/comman/comman_Image.dart';

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: const EdgeInsets.symmetric(horizontal: 70),
      child: context.locale == const Locale("en", "US")
          ? Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cachedImage("assets/images/Vector 2.png",
                            height: 40, width: 40),
                        cachedImage("assets/images/Vector 1.png",
                            height: 40, width: 40)
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cachedImage("assets/images/Vector 3.png",
                            height: 40, width: 40),
                        cachedImage("assets/images/Vector 4.png",
                            height: 40, width: 40)
                      ],
                    ),
                  ],
                ),
                Consumer<QrcodeProvider>(builder: (context, model, _) {
                  if (model.status == LoadingStatus.LOADING) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [LoaderWidget()],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: model.qrCodePath.contains('.')
                              ? cachedImage(
                                  "${AppConstants.BASE_URL_IMAGE + model.qrCodePath}",
                                  fit: BoxFit.contain,
                                  width: 200,
                                  height: 200)
                              : Center(
                                  child: QrImageView(
                                    data: model
                                        .qrCodePath, // النص اللي عايز تحوله لـ QR
                                    version: QrVersions.auto,
                                    size: 200.0, // حجم الكود
                                    gapless: false,
                                  ),
                                ),
                        ),
                      ],
                    );
                  }
                }),
              ],
            )
          : Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RotatedBox(
                            quarterTurns: 2,
                            child: cachedImage("assets/images/Vector 3.png",
                                height: 40, width: 40)),
                        RotatedBox(
                            quarterTurns: 2,
                            child: cachedImage("assets/images/Vector 4.png",
                                height: 40, width: 40))
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RotatedBox(
                            quarterTurns: 2,
                            child: cachedImage("assets/images/Vector 2.png",
                                height: 40, width: 40)),
                        RotatedBox(
                            quarterTurns: 2,
                            child: cachedImage("assets/images/Vector 1.png",
                                height: 40, width: 40))
                      ],
                    ),
                  ],
                ),
                Consumer<QrcodeProvider>(builder: (context, model, _) {
                  if (model.status == LoadingStatus.LOADING) {
                    return SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          LoaderWidget()
                        ],
                      ),
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 4),
                          child: model.qrCodePath.contains('.')
                              ? cachedImage(
                                  "${AppConstants.BASE_URL_IMAGE + model.qrCodePath}",
                                  fit: BoxFit.contain,
                                  width: 200,
                                  height: 200)
                              : Center(
                                  child: QrImageView(
                                    data: model
                                        .qrCodePath, // النص اللي عايز تحوله لـ QR
                                    version: QrVersions.auto,
                                    size: 200.0, // حجم الكود
                                    gapless: false,
                                  ),
                                ),
                        ),
                      ],
                    );
                  }
                }),
              ],
            ),
    );
  }
}
