import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:core_project/print_object.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Provider/LoginProvider.dart';
import '../Utill/Notifications/notification.dart';
import '../helper/Route_Manager.dart';
import '../helper/SnackBarScreen.dart';

const encoder = JsonEncoder.withIndent("");

Map<String, String> headersData = {
  "Accept": "application/json",
  "Content-Type": "application/json",
  "Authorization": "Bearer" + " " + "${globalAccountData.GetAccessToken()!}",
  "lang": "ar"
};

Future<String> postFunctionRestApi(BuildContext context,
    {String? url,
    Object? body,
    bool? needContent,
    bool? needAccept,
    bool? showError}) async {
  await getToken();
  // try {
  updateHeaders(context);
  if (!await isNetworkAvailable()) {
    toast(AppConstants.errorInternetNotAvailable);
    return "";
  }
  if (needContent == false) {
    headersData.remove("Content-Type");
  }
  if (needAccept == false) {
    headersData.remove("Accept");
  }
  print("hereee llll");

  final Uri urlTarget = Uri.parse(AppConstants.BASE_URL + url!);
  infoPost(AppConstants.BASE_URL + url, body, headersData);
  final http.Response response =
      await http.post(urlTarget, body: body, headers: headersData);
  print("response.statusCode   cc ${response.statusCode}");
  if (response.statusCode == 200 ||
      (response.statusCode == 400 &&
          url.contains("$GET_QRCODE_STATUS_FOR_CHECKIN"))) {
    goodPost(AppConstants.BASE_URL + url, response);
    return response.body;
  } else {
    String? errorMsg;

    if (showError == true) {
      try {
        errorMsg = jsonDecode(response.body)['message'];
      } catch (e) {}
    }

    handleError(response, context,
        url: AppConstants.BASE_URL + url,
        method: 'POST',
        requestData: body ?? {},
        error: errorMsg);
    return "";
  }
}

Future<String> putFunctionRestApi(BuildContext context,
    {String? url, Object? body, bool? needContent, bool? needAccept}) async {
  await getToken();
  // try {
  updateHeaders(context);
  if (!await isNetworkAvailable()) {
    toast(AppConstants.errorInternetNotAvailable);
    return "";
  }
  if (needContent == false) {
    headersData.remove("Content-Type");
  }
  if (needAccept == false) {
    headersData.remove("Accept");
  }
  final Uri urlTarget = Uri.parse(AppConstants.BASE_URL + url!);
  infoPost(AppConstants.BASE_URL + url, body, headersData);
  final http.Response response =
      await http.put(urlTarget, body: body, headers: headersData);

  if (response.statusCode == 200 ||
      (response.statusCode == 400 &&
          url.contains("$GET_QRCODE_STATUS_FOR_CHECKIN"))) {
    goodPost(AppConstants.BASE_URL + url, response);
    return response.body;
  } else {
    print("response.statusCode ${response.statusCode}");
    print("response.statusCode ${response.body}");
    handleError(response, context,
        url: AppConstants.BASE_URL + url,
        method: 'POST',
        requestData: body ?? "");
    return "";
  }
}

Future<String> DeleteFunctionRestApi(BuildContext context,
    {String? url, Object? body, bool? needContent, bool? needAccept}) async {
  await getToken();
  // try {
  updateHeaders(context);
  if (!await isNetworkAvailable()) {
    toast(AppConstants.errorInternetNotAvailable);
    return "";
  }
  if (needContent == false) {
    headersData.remove("Content-Type");
  }
  if (needAccept == false) {
    headersData.remove("Accept");
  }
  final Uri urlTarget = Uri.parse(AppConstants.BASE_URL + url!);
  infoPost(AppConstants.BASE_URL + url, body, headersData);
  final http.Response response =
      await http.delete(urlTarget, body: body, headers: headersData);

  if (response.statusCode == 200 ||
      (response.statusCode == 400 &&
          url.contains("$GET_QRCODE_STATUS_FOR_CHECKIN"))) {
    goodPost(AppConstants.BASE_URL + url, response);
    return response.body;
  } else {
    print("response.statusCode ${response.statusCode}");
    handleError(response, context,
        url: AppConstants.BASE_URL + url,
        method: 'POST',
        requestData: body ?? {});
    return "";
  }
}
//   catch (e) {
//     if (e is TimeoutException) {
//       popRoute(context: context);
//     }
//   }
//   return "";
// }

Future<List<String>> uploadImagePostFunction(
    List<File?> files, String url, BuildContext context,
    {bool pdf = false}) async {
  try {
    updateHeaders(context);
    if (!await isNetworkAvailable()) {
      toast(AppConstants.errorInternetNotAvailable);
      return [""];
    }
    var request =
        http.MultipartRequest('POST', Uri.parse(AppConstants.BASE_URL + url));
    for (var file in files) {
      if (file != null) {
        request.files.add(http.MultipartFile(
          'image',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: pdf ? ".pdf" : 'image.jpg',
        ));
      }
    }
    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    print(responseString);

    if (response.statusCode == 200) {
      var responseData = (responseString);
      List<String> imageUrls = [];
      imageUrls.add(responseData);
      return imageUrls;
    } else {
      errorFunction(url, response);
      return [];
    }
  } on Exception catch (e) {
    return [];
  }
}

void errorFunction(String url, http.StreamedResponse response) {
  talker.error(
      "updateFunctionRestApi ERROR Body $url : => statusCode ${response.statusCode} - body: ${response.request}");
}

Future<http.StreamedResponse> updateFunctionRestApi(Map<String, String> headers,
    File file, Map<String, String> body, String url) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(AppConstants.BASE_URL + url));
  request.headers.addAll(headers);
  if (file != null) {
    request.files.add(http.MultipartFile(
      'image',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: 'image.jpg',
    ));
  }
  request.fields.addAll(body);
  var response = await request.send();
  errorFunction(url, response);
  return response;
}

Future<String> getFunctionRestApi(
  BuildContext context, {
  required String? urlEndPoint,
  String paramaters = "",
  bool? needContent,
  bool navigate = true,
  bool showError = true,
}) async {
  updateHeaders(context);
  if (!await isNetworkAvailable()) {
    toast(AppConstants.errorInternetNotAvailable);
    return "";
  }
  final Uri urlTarget =
      Uri.parse(AppConstants.BASE_URL + urlEndPoint! + paramaters);
  talker.info(
      "🗣️ 🗣️ 🗣️ getFunctionRestApi Link is  : =>  $urlTarget \n and Headers is :${headersData}");
  printAllObject(json: headersData);
  if (needContent == false) {
    headersData.remove("Content-Type");
  }
  final http.Response response =
      await http.get(urlTarget, headers: headersData);
  log(response.body);
  if (response.statusCode == 200) {
    goodPost(AppConstants.BASE_URL + urlEndPoint, response);
    return response.body;
  } else {
    talker.error(
        "getFunctionRestApi ERROR Body $urlEndPoint : => statusCode ${response.statusCode} - body: ${response.body}");
    if (navigate) {
      handleError(response, context,
          url: urlEndPoint + paramaters.trim(),
          method: 'GET',
          requestData: paramaters);
    }

    return "";
  }
}

void updateHeaders(BuildContext context) async {
  await globalAccountData.init();

  headersData = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": globalAccountData.GetAccessToken() != null
        ? "Bearer" + " " + "${globalAccountData.GetAccessToken()!}"
        : "",
    "lang": context == null
        ? "en"
        : context.locale == const Locale("en", "US")
            ? "en"
            : "ar"
  };
}

void handleError(
  http.Response response,
  context, {
  required String url,
  required String method,
  required Object requestData,
  String? error,
  bool showError = true,
}) async {
  final statusCode = response.statusCode;
  var responseBody = response.body;
  String userErrorMessage;
  String developerErrorMessage =
      " ✋❌ Failed In Response ✋🚨 postFunctionRestApi For $method request to $url\n";
  developerErrorMessage += "Request Data: $requestData\n";
  developerErrorMessage += "Status Code: $statusCode\n";
  developerErrorMessage += "Response Body: $responseBody";
  print(response.body);
  switch (statusCode) {
    case 400:
      userErrorMessage = json.decode(response.body)["message"] == null
          ? json.decode(response.body)["data"] == null
              ? 'Sorry, there was a problem with your request.'
              : json.decode(response.body)["data"]
          : json.decode(response.body)["message"];
      break;
    case 401:
      userErrorMessage =
          'Oops! You are not authorized to access this resource.';
      await globalAccountData.clearSharedPreferencesForLogOut();
      Provider.of<LoginProvider>(context, listen: false).showNavBar(false);
      pushNamedAndRemoveUntilRoute(context: context, route: Routes.loginRoute);
      break;
    case 404:
      userErrorMessage = 'Oops! The requested resource was not found.';
      break;
    case 500:
      userErrorMessage = 'Oops! Something went wrong on our end.';
      break;
    default:
      userErrorMessage = '${json.decode(response.body)["message"]}';
  }
  // sendErrorToAdmin(url,response.statusCode.toString(),response.body,requestData.toString());
  final errorMessage = userErrorMessage;
  talker.error(developerErrorMessage);

  // toast(errorMessage, gravity: ToastGravity.TOP);
  if (showError) {
    showAwesomeSnackbar(
      context,
      'On Snap!',
      '${error ?? errorMessage}',
      contentType: ContentType.failure,
    );
  }
}

// sendErrorToAdmin(String endPoint,String statusCode,String responseBody,String request)async {
//   await launch(
//       "https://wa.me/${201273095210}?text=The Problem is end Point => $endPoint \n and request"
//           " is $request \n status Code is $statusCode \n Response Body: $responseBody");
// }

void infoPost(String url, Object? body, Object? headers) {
  talker.info(
      " 🗣️ 🗣️ 🗣️ POST $url \n \n ----------------------- \n Request Headers:${encoder.convert(headers)} \n ----------------------- \n Request Body:${body}");

  log("Request Body:${body}");
}

void goodPost(String url, http.Response response) {
  try {
    talker.info(
        "✅✅✅✅ 👍🏻 🎖 Success Response 👍🏻 👑 POST REST API BODY ${response.statusCode}$url \n Response Body:${encoder.convert(json.decode(response.body))}");
  } catch (e) {
    talker.info(
        "✅✅✅✅ 👍🏻 🎖 Success Response 👍🏻 👑 POST REST API BODY ${response.statusCode}$url \n Response Body:${response.body}");
  }
}
