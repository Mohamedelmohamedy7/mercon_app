import 'dart:developer';
import 'package:core_project/Services/RestApi.dart';

//log("${encoder.convert(propertiesModel.toJson())}");


void printAllObject({required Map<String,dynamic> json})
{
log(encoder.convert(json));
}


extension ArabicNormalizer on String {
  String normalizeArabic() {
    return replaceAllMapped(
        RegExp(r'ه(?=$)'), // استبدال الهاء فقط إذا كانت في نهاية النص
            (match) => 'ة')
        .replaceAll(RegExp(r'[ة]'), 'ة') // التاء المربوطة تظل كما هي
        .replaceAll(RegExp(r'[أإآا]'), 'ا') // توحيد جميع الألفات
        .replaceAll(RegExp(r'[ئىي]'), 'ي'); // توحيد جميع أنواع الياء
  }
}