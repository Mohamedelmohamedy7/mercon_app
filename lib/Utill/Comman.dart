// ignore_for_file: non_constant_identifier_names

import 'package:core_project/Model/CompoundModel.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:talker/talker.dart';
import '../Model/user_info_model.dart';
import '../helper/ImagesConstant.dart';
import '../helper/SnackBarScreen.dart';
import '../helper/color_resources.dart';
import 'Local_User_Data.dart';

String? extractUserId(String inputString) {
  RegExp regex = RegExp(r"UserId: (\w+-\w+-\w+-\w+-\w+)");
  Match? match = regex.firstMatch(inputString);
  if (match != null) {
    return match.group(1);
  } else {
    return null;
  }
}

String? removeUserId(String inputString) {
  RegExp regex = RegExp(r"UserId: (\w+-\w+-\w+-\w+-\w+)");
  Match? match = regex.firstMatch(inputString);
  if (match != null) {
    return inputString.replaceFirst(regex, "");
  } else {
    return null;
  }
}

String extractType(String inputString) {
  RegExp regex = RegExp(r"Type: (\w+)");
  Match? match = regex.firstMatch(inputString);
  String extractedType = match?.group(1) ?? "Type not found";
  // Extract the matched group
  return extractedType;
}

///Shared Preference To get User Data From Local
Future<void> saveUserData(UserInfoModel user) async {
  print(user.roleType);
  await globalAccountData.setId(user.id.toString());
  await globalAccountData.SetExpiredTime(user.expiresIn.toString());
  await globalAccountData.SetRefreshToken(user.refreshToken.toString());
  await globalAccountData.SetAccessToken(user.accessToken.toString());
  await globalAccountData.setId(user.id.toString());
  await globalAccountData.setUsername(user.fName ?? "");
  await globalAccountData.setOwnerUserId(user.ownerUserId.toString());
  await globalAccountData.setEmail(user.email ?? "");
  await globalAccountData.setPhoneNumber(user.phone ?? "");
  await globalAccountData.setLoginInState(true);
  await globalAccountData.setUserType(user.roleType ?? "");
  await globalAccountData.setProfilePic(user.profileImagePath ?? "");
}

Future<void> saveCompoundData(CompoundData compoundData) async {
  print("saveCompoundData  ${compoundData.toJson()}");
  await globalAccountData.setCompoundId((compoundData.id ?? "").toString());
  await globalAccountData.setCompoundName((compoundData.name ?? "").toString());
  await globalAccountData.setCompoundLogo((compoundData.logo ?? "").toString());
}

toast(
    String? value, {
      ToastGravity? gravity,
      length = Toast.LENGTH_SHORT,
      Color? bgColor,
      Color? textColor,
      bool print = false,
    }) {
  Fluttertoast.showToast(
    msg: value!,
    gravity: gravity,
    toastLength: length,
    backgroundColor: bgColor,
    textColor: textColor,
  );
}

/// returns true if network is available
Future<bool> isNetworkAvailable() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

double w(context) {
  return MediaQuery.of(context).size.width;
}

double h(context) {
  return MediaQuery.of(context).size.height;
}

bool condation(BuildContext context) {
  return context.locale == const Locale("en", "US");
}

final talker = Talker(
  /// Your own observers to handle errors's exception's and log's
  /// like Crashlytics or Sentry observer
  observers: [],
  settings: TalkerSettings(
    /// You can enable/disable all talker processes with this field
    enabled: true,

    /// You can enable/disable saving logs data in history
    useHistory: true,

    /// Length of history that saving logs data
    maxHistoryItems: 1000,

    /// You can enable/disable console logs
    useConsoleLogs: true,
  ),

  /// Setup your implementation of logger
  logger: TalkerLogger(),

  ///etc...
);

/// returns place Holder Image (asset)

bool currentLangIsEng(BuildContext context) {
  return context.locale == const Locale("en", "US");
}

Widget placeHolderWidget(
    {double? height,
      double? width,
      BoxFit? fit,Color ? color,
      AlignmentGeometry? alignment}) {
  return Image.asset(
    ImagesConstants.plashHolder,
    height: height,
    width: width,  color: color ?? null,
    fit: fit ?? BoxFit.contain,
    alignment: alignment ?? Alignment.center,
  );
}

OutlineInputBorder borderStyle =   OutlineInputBorder(
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
    bottomLeft: Radius.circular(16),
    bottomRight: Radius.circular(16),
  ),
  borderSide: BorderSide(color:Color(0xFF695c4c).withOpacity(0.05)),
);
textFieldSvg(String title,
    {double? width, double? height, Color? color, BoxFit? fit}) {
  return SvgPicture.asset(
    "assets/images/$title",
    width: width ?? 20,
    height: height ?? 20,
    fit: fit ?? BoxFit.scaleDown,
    color: color ?? const Color(0xFF695c4c),
  );
}

void failedSnack(BuildContext context, text) {
  showAwesomeSnackbar(
    context,
    'On Snap!',
    '${tr("${text}")}',
    contentType: ContentType.failure,
  );
}

void successSnak(BuildContext context, String text) {
  showAwesomeSnackbar(
    context,
    'Success!',
    '${tr("${text}")}',
    contentType: ContentType.success,
  );
}

/// Display Text in Style

InputDecoration decoration(text, {icon}) {
  return InputDecoration(
    labelText: text,
    filled: true,
    fillColor: Color(0xFF695c4c).withOpacity(0.05),
    suffix: icon,
    labelStyle: CustomTextStyle.semiBold14DarkGrey.copyWith(fontSize: 12),
    border: borderStyle,
    focusedBorder: borderStyle,
    errorBorder: borderStyle,
    disabledBorder: borderStyle,
    enabledBorder: borderStyle,
    hintStyle: CustomTextStyle.semiBold14DarkGrey.copyWith(fontSize: 12),
  );
}

TextFormField textFormField(text, TextEditingController controller, icon,
    {autoFoucs,
      maxLines,
      String? Function(String?)? validation,
      bool? enabled,
      TextInputAction? textInputAction,
      TextInputType? keyboardType}) {
  return TextFormField(
      style: const TextStyle(
          color: BLACK, fontWeight: FontWeight.w600, fontSize: 12),
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLines: maxLines,
      autofocus: autoFoucs ?? false,
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: validation,
      textInputAction: textInputAction ?? TextInputAction.next,
      enabled: enabled ?? true,
      decoration: decoration("$text".tr(), icon: icon),
      onChanged: (val) {
        val = controller.text;
      },
      onSaved: (val) {
        val = controller.text;
      });
}

/// pushNamedAndRemoveUntil Navigator
pushNamedAndRemoveUntilRoute({required context, required String route}) async {
  return await Navigator.of(context)
      .pushNamedAndRemoveUntil(route, (route) => false);
}

/// pushRemoveUntil Navigator
pushRemoveUntilRoute({required context, required Widget route}) {
  return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => route), (route) => false);
}

/// push Navigator
pushRoute({required context, required Widget route}) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => route));
}

/// pushReplacement Navigator
pushReplacementRoute({required context, required Widget route}) {
  return Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => route));
}

/// pushReplacementNamed Navigator
pushReplacementNamedRoute({required context, required String route}) {
  return Navigator.pushReplacementNamed(context, route);
}

/// pop Navigator
popRoute({required context}) {
  if (Navigator.of(context).canPop()) {
    return Navigator.of(context).pop();
  } else {
    talker.error("❌  No Route found for this material ");
  }
}
