import 'package:core_project/Provider/QrCodeProvider.dart';
import 'package:core_project/View/Screen/DashBoard/QrCode/qr_code_widget.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../../../Utill/Comman.dart';
import '../../../../helper/ImagesConstant.dart';
import '../../../Widget/comman/CustomAppBar.dart';

class AskScanQrCode extends StatefulWidget {
  const AskScanQrCode({Key? key}) : super(key: key);

  @override
  State<AskScanQrCode> createState() => _State();
}

class _State extends State<AskScanQrCode> {
  @override
  void initState() {
    Provider.of<QrcodeProvider>(context, listen: false).generateQrCodeToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'scanQrCode'.tr(),
          needBack: false,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: Container(
          //color: BACKGROUNDCOLOR,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              80.height,
              Text(
                "scanQrCode".tr(),
                style: CustomTextStyle.bold18black.copyWith(fontSize: 25),
              ),
              80.height,
              QrCodeWidget(),
              90.height,
              InkWell(
                onTap: () {
                  Provider.of<QrcodeProvider>(context, listen: false).generateQrCodeToken(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  width: w(context),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor,
                    boxShadow: const [
                      BoxShadow(
                        color: lightGray,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 4.0, // Specify the blur radius
                      ),
                    ],
                  ),
                  child: Center(child: Text(
                    "Reload".tr(),
                    style:CustomTextStyle.semiBold12Black.copyWith(color: white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
