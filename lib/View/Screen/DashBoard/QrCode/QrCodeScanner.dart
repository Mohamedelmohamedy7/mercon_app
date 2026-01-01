import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:core_project/Provider/QrCodeProvider.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart' as nb_utils;
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../../Utill/Comman.dart';
import '../../../../Utill/LoaderWidget/loader_widget.dart';
import '../../../../Utill/validator.dart';
import '../../../../helper/ImagesConstant.dart';
import '../../../Widget/comman/CustomAppBar.dart';

class QRViewScreen extends StatefulWidget {
  const QRViewScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewScreen> {
  final TextEditingController reasonController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Map<String, String> valueArabic = {};

  @override
  void initState() {
    super.initState();
  }

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isScan = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    print("----------");
    return SafeArea(
      child: Scaffold(
        extendBody: false,
        appBar: CustomAppBar(
          title: "مسح الكود الضوئي",
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: _buildQrView(context),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 400.0;
    return Stack(
      children: [
        QRView(
            key: qrKey,
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p)),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () async {
              await controller?.toggleFlash();
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.7),
              ),
              child: textFieldSvg("flash.svg",
                  width: 35,
                  height: 35,
                  color: Theme.of(context).primaryColor,
                  fit: BoxFit.cover),
            ),
          ),
        )
      ],
    );
  }

  String extractEmployee(String inputString) {
    RegExp regex = RegExp(r"Type: (\w+)");
    Match? match = regex.firstMatch(inputString);
    String extractedType = match?.group(1) ?? "Type not found";
    // Extract the matched group
    return extractedType;
  }

  void onQRViewCreated(QRViewController controller) {
    print("*******************");
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (result == null) {
        setState(() {
          result = scanData;
          isScan = true;
        });

        nb_utils.toast("Scan Done Successfully",
            gravity: nb_utils.ToastGravity.BOTTOM);

        print("result!.code!result!.code! ${result!.code!}");
        if (extractType(result!.code!).trim() == "OwnerCheckIn") {
          setState(() {
            valueArabic.addAll(replaceAllStringCode());
          });
          removeUserId(result!.code!);
          Provider.of<QrcodeProvider>(context, listen: false)
              .getScanAvalible(context, extractUserId(result!.code!)!)
              .then((value) {
            return showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black.withOpacity(0.5),
                context: context,
                builder: (dialogContext) => CustomDialog(
                    context: dialogContext,
                    isActive: value,
                    title: "".tr(),
                    onYesTap: () {},
                    subtitle: "".tr()));
          });
        } else if (extractType(result!.code!).trim() == "OwnerCheckOut") {
          setState(() {
            valueArabic.addAll(replaceAllStringCode());
          });
          removeUserId(result!.code!);
          Provider.of<QrcodeProvider>(context, listen: false)
              .getScanAvalible(context, extractUserId(result!.code!)!)
              .then((value) {
            print("valueeee ${value}");
            return showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black.withOpacity(0.5),
                context: context,
                builder: (dialogContext) => CustomDialog(
                    context: dialogContext,
                    isActive: value,
                    title: "".tr(),
                    onYesTap: () {},
                    subtitle: "".tr()));
          });
        } else if (extractType(result!.code!).trim() == "") {
          setState(() {
            valueArabic.addAll(replaceAllStringCode());
          });
          p_Listeneress<QrcodeProvider>(context)
              .getScanAvalible(context, extractUserId(result!.code!)!)
              .then((value) {
            return showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black.withOpacity(0.5),
                context: context,
                builder: (dialogContext) => CustomDialog(
                    context: dialogContext,
                    isActive: value,
                    title: "".tr(),
                    onYesTap: () {},
                    subtitle: "".tr()));
          });
        } else if (extractType(result!.code!) == "CheckOut") {
          p_Listeneress<QrcodeProvider>(context)
              .getScanAvalibleForCheckout(context, result!.code!)
              .then((value) {
            setState(() {
              valueArabic.addAll(replaceAllStringCode());
            });
            return showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black.withOpacity(0.5),
                context: context,
                builder: (dialogContext) => CustomDialog(
                    context: dialogContext,
                    isActive: value,
                    title: "".tr(),
                    onYesTap: () {},
                    subtitle: "".tr()));
          });
        } else if (extractType(result!.code!) == "CheckIn") {
          {
            p_Listeneress<QrcodeProvider>(context)
                .getScanAvalibleForCheckIn(context, result!.code!)
                .then((value) {
              setState(() {
                valueArabic.addAll(replaceAllStringCode());
              });
              return showDialog(
                  barrierDismissible: false,
                  barrierColor: Colors.black.withOpacity(0.5),
                  context: context,
                  builder: (dialogContext) => CustomDialog(
                      context: dialogContext,
                      isActive: value,
                      title: "".tr(),
                      onYesTap: () {},
                      subtitle: "".tr()));
            });
          }
        } else if (result!.code!.contains("EmployeeName")) {
          //  removeUserId(result!.code!);
          Provider.of<QrcodeProvider>(context, listen: false)
              .getScanAvalibleForEmployee(context, result!.code!)
              .then((value) {
            setState(() {
              valueArabic.addAll(replaceAllStringCode());
            });
            return showDialog(
                barrierDismissible: false,
                barrierColor: Colors.black.withOpacity(0.5),
                context: context,
                builder: (dialogContext) => CustomDialog(
                    context: dialogContext,
                    isActive: value,
                    title: "".tr(),
                    onYesTap: () {},
                    subtitle: "".tr()));
          });
        }
      }
    });
  }

  Map<String, String> replaceAllStringCode() {
    List<String> keyValuePairs = result!.code!.split(',');
    Map<String, String> resultMap = {};
    for (String pair in keyValuePairs) {
      List<String> parts = pair.split(':');
      if (parts.length == 2) {
        String key = parts[0].trim();
        String value = parts[1].trim();
        value = value.replaceAll('{', '').replaceAll('}', '');
        resultMap[key] = value;
      }
    }
    print("========================>>>>>>>${resultMap}");
    print(resultMap);
    return resultMap;
  }

// return result!.code!
//             .replaceAll("NationalId", "رقم البطاقة")
//             .replaceAll("Name", "الاسم")
//             .replaceAll("EntryDate", "تاريخ الدخول").replaceAll("Date", "تاريخ و وقت الدخول")
//             .replaceAll("CkeckOutDate", "تاريخ الخروج").replaceAll("UserStatus", "حالة المستخدم").replaceAll("True", "نشط").replaceAll("False", "غير نشط")
//             .replaceAll("Total Vistior Count ", "عدد الاشخاص في الزيارة")
//             .replaceAll("OwnerCheckIn", "دخول").replaceAll("OwnerCheckOut", "خروج").replaceAll("Type", "نوع العملية");

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  CustomDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool isActive,
    required VoidCallback onYesTap,
  }) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          isScan = false;
          result = null;
        });
        return true;
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: Colors.white),
            child: Container(
              padding: const EdgeInsetsDirectional.only(
                  start: 16, end: 16, top: 20, bottom: 20),
              child: WillPopScope(
                onWillPop: () async {
                  setState(() {
                    isScan = false;
                    result = null;
                  });
                  return true;
                },
                child: Consumer<QrcodeProvider>(
                  builder: (context, model, _) {
                    if (model.status == LoadingStatus.LOADING) {
                      return Loading(onYesTap, context);
                    } else {
                      return result?.code == null
                          ? SizedBox()
                          : isActive
                              ? result!.code!.contains('EmployeeName')
                                  ? Employee(context)
                                  : (extractType(result!.code!) ==
                                          "OwnerCheckOut")
                                      ? OwnerCheckOut(context)
                                      : (extractType(result!.code!) ==
                                              "OwnerCheckIn")
                                          ? Owner(context)
                                          : (extractType(result!.code!) ==
                                                  "CheckIn")
                                              ? CheckIn(context)
                                              : CheckOUt(context)
                              : unSuffiecentCode(context);
                    }
                  },
                ),
              ),
            )),
      ),
    );
  }

  SingleChildScrollView CheckIn(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "الاسم :${valueArabic["Name"]}",
            style: CustomTextStyle.semiBold12Black
                .copyWith(fontSize: 13, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "الرقم القومي :${valueArabic["NationalId"].toString()}",
            style: CustomTextStyle.semiBold12Black
                .copyWith(fontSize: 13, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "نوع العملية :${valueArabic["Type"].toString() == "CheckIn" ? "دخول" : "خروج"}",
            style: CustomTextStyle.semiBold12Black
                .copyWith(fontSize: 13, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "تاريخ الدخول :${valueArabic["EntryDate"].toString()}",
            style: CustomTextStyle.semiBold12Black
                .copyWith(fontSize: 13, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "تاريخ الخروج :${valueArabic["CkeckOutDate"].toString()}",
            style: CustomTextStyle.semiBold12Black
                .copyWith(fontSize: 13, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "عدد الزائرين :${valueArabic["Total Vistior Count"].toString()}",
            style: CustomTextStyle.semiBold12Black
                .copyWith(fontSize: 13, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (_key.currentState!.validate()) {
                      Provider.of<QrcodeProvider>(context, listen: false)
                          .sendStatusQrcodeForCheckIn(context, result!.code!,
                              reasonController.text, true)
                          .then((value) {
                        setState(() {
                          result = null;
                          isScan = false;
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        successSnak(context, "تم ارسال طلب الرفض بنجاح");
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsetsDirectional.only(top: 16, bottom: 16),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(9)),
                    child: Text(
                      "رفض",
                      style: CustomTextStyle.semiBold12Black
                          .copyWith(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    p_Listeneress<QrcodeProvider>(context)
                        .sendStatusQrcodeForCheckIn(
                            context, result!.code!, '', false)
                        .then((value) {
                      setState(() {
                        result = null;
                        isScan = false;
                      });
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                    successSnak(context, "تم الموافقة علي الدخول");
                  },
                  child: p_Listener<QrcodeProvider>(context).status ==
                          LoadingStatus.LOADING
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsetsDirectional.only(
                              top: 16, bottom: 16),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(9)),
                          child: Text(
                            "السماح بالدخول",
                            style: CustomTextStyle.semiBold12Black
                                .copyWith(fontSize: 10, color: Colors.white),
                          ),
                        ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _key,
            child: textFormField(
                "سبب الرفض",
                reasonController,
                Icon(
                  Icons.message,
                  color: Theme.of(context).primaryColor,
                ),
                validation: (value) => Validator.defaultValidator(value),
                maxLines: 5),
          ),
        ],
      ),
    );
  }

  Column CheckOUt(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Lottie.asset(
              "assets/images/successScan.json",
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "الاسم :${valueArabic["Name"]}",
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "الرقم القومي :${valueArabic["NationalId"].toString()}",
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "نوع العملية :${valueArabic["Type"].toString() == "CheckIn" ? "دخول" : "خروج"}",
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "تاريخ الدخول :${valueArabic["EntryDate"].toString()}",
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "تاريخ الخروج :${valueArabic["CkeckOutDate"].toString()}",
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  result = null;
                  isScan = false;
                });
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsetsDirectional.only(top: 16, bottom: 16),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(9)),
                child: Text(
                  "ارسال بالموافقة",
                  style: CustomTextStyle.semiBold12Black
                      .copyWith(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Column Employee(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Lottie.asset(
              "assets/images/successScan.json",
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "الاسم :${valueArabic["EmployeeName"]}",
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "المسمي وظيفي :${valueArabic["JobTitle"].toString()}",
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "نوع العملية :${valueArabic["UserStatus"].toString() == "In" ? "دخول" : "خروج"}",
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            // SizedBox(
            //   height: 15,
            // ),
            // Text(
            //   "الوقت :${valueArabic["Date"].toString()}",
            //   style: CustomTextStyle.semiBold12Black
            //       .copyWith(fontSize: 13, color: Colors.black),
            //   textAlign: TextAlign.center,
            // ),

            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  result = null;
                  isScan = false;
                });
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsetsDirectional.only(top: 16, bottom: 16),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(9)),
                child: Text(
                  "تم",
                  style: CustomTextStyle.semiBold12Black
                      .copyWith(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Column Owner(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Lottie.asset(
              "assets/images/successScan.json",
            ),
            Text(
              "الاسم :${valueArabic["Name"]}",
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "حالة المستخدم :${valueArabic["UserStatus"].toString() == "True" ? "نشط" : "غير نشط"}",
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "نوع العملية :${valueArabic["Type"].toString() == "OwnerCheckIn" ? "دخول" : "خروج"}",
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 13, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  result = null;
                  isScan = false;
                });
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsetsDirectional.only(top: 16, bottom: 16),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(9)),
                child: Text(
                  "ارسال بالموافقة",
                  style: CustomTextStyle.semiBold12Black
                      .copyWith(fontSize: 13, color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Column OwnerCheckOut(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Lottie.asset(
              "assets/images/successScan.json",
            ),
            valueArabic.containsKey("Name")
                ? Text(
                    "الاسم :${valueArabic["Name"]}",
                    style: CustomTextStyle.semiBold12Black
                        .copyWith(fontSize: 13, color: Colors.black),
                    textAlign: TextAlign.center,
                  )
                : SizedBox(),
            SizedBox(
              height: valueArabic.containsKey("Name") ? 5 : 0,
            ),
            valueArabic.containsKey("Name")
                ? Text(
                    "حالة المستخدم :${valueArabic["UserStatus"].toString() == "True" ? "نشط" : "غير نشط"}",
                    style: CustomTextStyle.semiBold12Black
                        .copyWith(fontSize: 13, color: Colors.black),
                    textAlign: TextAlign.center,
                  )
                : SizedBox(),
            SizedBox(
              height: valueArabic.containsKey("Name") ? 5 : 0,
            ),
            valueArabic.containsKey("Type")
                ? Text(
                    "نوع العملية :${valueArabic["Type"].toString() == "OwnerCheckIn" ? "دخول" : "خروج"}",
                    style: CustomTextStyle.semiBold12Black
                        .copyWith(fontSize: 13, color: Colors.black),
                    textAlign: TextAlign.center,
                  )
                : SizedBox(),
            SizedBox(
              height: valueArabic.containsKey("Type") ? 5 : 0,
            ),
            Provider.of<QrcodeProvider>(context, listen: false).status ==
                    LoadingStatus.LOADING
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoaderWidget(),
                    ],
                  )
                : Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<QrcodeProvider>(context, listen: false)
                              .setScanCheckOut(
                                  context, valueArabic["UserId"]!, false)
                              .then((value) {
                            if (value) {
                              successSnak(context, "تم تنفيذ العملية بنجاح");
                              Future.delayed(Duration(seconds: 2), () {
                                // Use SchedulerBinding.instance.addPostFrameCallback for the pop
                                SchedulerBinding.instance.addPostFrameCallback(
                                    (_) => Navigator.of(context).pop());
                                SchedulerBinding.instance.addPostFrameCallback(
                                    (_) => Navigator.of(context).pop());
                              });
                            } else {
                              failedSnack(context, "تعذر تنفيذ العملية");
                              Future.delayed(Duration(seconds: 2), () {
                                SchedulerBinding.instance.addPostFrameCallback(
                                    (_) => Navigator.of(context).pop());
                                SchedulerBinding.instance.addPostFrameCallback(
                                    (_) => Navigator.of(context).pop());
                              });
                            }
                          });
                          setState(() {
                            result = null;
                            isScan = false;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsetsDirectional.only(
                              top: 16, bottom: 16),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(9)),
                          child: Text(
                            "خروج مؤقت",
                            style: CustomTextStyle.semiBold12Black
                                .copyWith(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                      15.height,
                      InkWell(
                        onTap: () {
                          Provider.of<QrcodeProvider>(context, listen: false)
                              .setScanCheckOut(
                                  context, valueArabic["UserId"]!, true)
                              .then((value) {
                            if (value) {
                              successSnak(context, "تم تنفيذ العملية بنجاح");
                              Future.delayed(Duration(seconds: 2), () {
                                // Use SchedulerBinding.instance.addPostFrameCallback for the pop
                                SchedulerBinding.instance.addPostFrameCallback(
                                    (_) => Navigator.of(context).pop());
                                SchedulerBinding.instance.addPostFrameCallback(
                                    (_) => Navigator.of(context).pop());
                              });
                            } else {
                              failedSnack(context, "تعذر تنفيذ العملية");
                              Future.delayed(Duration(seconds: 2), () {
                                SchedulerBinding.instance.addPostFrameCallback(
                                    (_) => Navigator.of(context).pop());
                                SchedulerBinding.instance.addPostFrameCallback(
                                    (_) => Navigator.of(context).pop());
                              });
                            }
                          });
                          setState(() {
                            result = null;
                            isScan = false;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsetsDirectional.only(
                              top: 16, bottom: 16),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(9)),
                          child: Text(
                            "خروج نهائي",
                            style: CustomTextStyle.semiBold12Black
                                .copyWith(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        )
      ],
    );
  }

  Column unSuffiecentCode(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Lottie.asset("assets/images/failedScan.json"),
        Column(
          children: [
            Text(
              "هذة ال كود غير صالح قد يكون تم استخدامة من قبل",
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 12, color: Colors.black),
              textAlign: TextAlign.center,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            setState(() {
              result = null;
              isScan = false;
            });
            Navigator.of(context).pop();
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsetsDirectional.only(top: 16, bottom: 16),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(9)),
            child: Text(
              "ارسال بالرفض".tr(),
              style: CustomTextStyle.semiBold12Black
                  .copyWith(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Column Loading(VoidCallback onYesTap, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoaderWidget(),
          ],
        ),
        InkWell(
          onTap: onYesTap,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsetsDirectional.only(top: 6, bottom: 6),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(9)),
            child: Text(
              "Loading ...",
              style:
                  CustomTextStyle.semiBold12Black.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
