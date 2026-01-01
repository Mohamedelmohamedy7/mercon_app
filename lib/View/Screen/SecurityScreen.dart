import 'dart:io';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/View/Screen/ComplainScreen.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../helper/ImagesConstant.dart';
import '../../helper/text_style.dart';
import '../Widget/comman/CustomAppBar.dart';
import 'DashBoard/QrCode/QrCodeScanner.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  int _tabIndex = 1;

  int get tabIndex => _tabIndex;

  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  String valueArabic = "";
  @override
  void initState() {
    super.initState();
  }

  bool isOpen = false;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isScan = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    context.locale = const Locale('ar', 'EG');
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: CustomAppBar(
          leading: IconButton(
            onPressed: () {
              pushRoute(
                  context: context,
                  route: ComplaintFormScreen(
                    needBack: true,
                    fromSecurity: true,
                  ));
            },
            icon: textFieldSvg("message.svg"),
          ),
          needBack: false,
          title: "مسح الكود الضوئي",
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Container(
          width: double.infinity,
          // color: BACKGROUNDCOLOR.withOpacity(0.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/images/scanQrcodeProeccs.json",
                  width: 200, height: 200),
              20.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "قم بالضغط من فضلك لفتح الكاميرا لكي تتحقق من الكود الضوئي",
                  style: CustomTextStyle.semiBold14Black,
                  textAlign: TextAlign.center,
                ),
              ),
              20.height,
              GestureDetector(
                onTap: () {
                  pushRoute(context: context, route: QRViewScreen());
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                  child: Center(
                      child: Text("تحقق من الكود الضوئي",
                          style: CustomTextStyle.bold14White,
                          textAlign: TextAlign.center)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
