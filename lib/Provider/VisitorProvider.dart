import 'dart:convert';
import 'dart:io';

import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:flutter/material.dart';

import '../Model/TermsAndConditionsModel.dart';
import '../Services/RequestFile.dart';
import '../Services/RestApi.dart';
import '../helper/app_constants.dart';

class VisitorProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;

  Future<dynamic> sendMessageToSecurity(
      String message, BuildContext context) async {
    startLoader();
    final res = await postFunctionRestApi(context,
        url: SEND_MESSAGE_TO_SECURITY +
            "?body=$message&Titel=اشعار جديد الي فرد الامن من ${globalAccountData.getUsername()}",
        needContent: false);
    S_finishLoader();
    return json.decode(res);
  }

  Future sendVisitorQrCode(context,
      {required String name,
      required String nationalId,
      required List<File> imageNationalIdFrontFile,
      required List<File> imageNationalIdBackFile,
      required bool isRent,
      required bool isVisitor,
      required DateTime checkOutDateTime,
      required DateTime entryDateTime,
      required String totalWithVistiorCount,
      required String relationship,
      required String unitId,
      required String email,
      required String phoneNumber,
      String? facebookLink,
      String? instagramLink}) async {
    try {
      startLoader();
      List<String> imageNationalIdFrontURL = [];
      for (File element in imageNationalIdFrontFile) {
        List<String> image = await uploadImagePostFunction(
            [element], "Common/UploadImage", context);
        imageNationalIdFrontURL.add(image.first);
      }

      List<String> imageNationalIdBackURL = [];
      for (File element in imageNationalIdBackFile) {
        List<String> image = await uploadImagePostFunction(
            [element], "Common/UploadImage", context);
        imageNationalIdBackURL.add(image.first);
      }

      print(jsonEncode(imageNationalIdFrontURL));
      print(")))))))))))))))");
      print(jsonEncode(imageNationalIdBackURL));
      final res = await postFunctionRestApi(context,
          url: NOTICE_VISIT_AND_RENT,
          body: json.encode(sendVisitorRequestBody(
              unitId: unitId,
              name: name,
              nationalId: nationalId,
              email: email,
              relationship: relationship,
              imageNationalIdFrontURL: jsonEncode(imageNationalIdFrontURL),
              imageNationalIdBackURL: jsonEncode(imageNationalIdBackURL),
              isRent: isRent,
              facebookLink: facebookLink,
              instagramLink: instagramLink,
              isVisitor: isVisitor,
              checkOutDateTime: checkOutDateTime,
              entryDateTime: entryDateTime,
              totalWithVistiorCount: totalWithVistiorCount,
              phoneNumber: phoneNumber)),
          needContent: true);
      S_finishLoader();
      return Decoding(res);
    } catch (e) {
      print(e);
      S_finishLoader();
    }
  }

  void startLoader() {
    status = LoadingStatus.LOADING;
    notifyListeners();
  }

  void S_finishLoader() {
    status = LoadingStatus.SUCCESS;
    notifyListeners();
  }

  TermsAndConditionsModel? termsAndConditionsModel;
  bool getTermsAndConditionsLoading = false;
  Future<void> getTermsAndConditions(context) async {
    getTermsAndConditionsLoading = true;
    notifyListeners();
    final res =
        await getFunctionRestApi(context, urlEndPoint: Terms_And_Conditions);
    if (json.decode(res)['data'].isNotEmpty) {
      termsAndConditionsModel =
          TermsAndConditionsModel.fromJson(json.decode(res));
    }

    getTermsAndConditionsLoading = false;
    notifyListeners();
    return;
  }
}
