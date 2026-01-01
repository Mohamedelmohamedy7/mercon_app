import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../Utill/validator.dart';
import '../../../helper/color_resources.dart';

class  RegisterScreenStateIntlPhoneField extends StatelessWidget {
    RegisterScreenStateIntlPhoneField( {
    super.key,
    required this.phoneNumberController,
    required this.onChanged, this.autoFoucs
  });
  final Function onChanged;
  final TextEditingController phoneNumberController;
  bool ? autoFoucs;
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      languageCode: 'ar',
      showDropdownIcon: true,
      autofocus: autoFoucs??false,
      style: TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
      validator: (value) => Validator.numbers(value?.number),
      dropdownTextStyle: TextStyle(
          color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400),
      dropdownDecoration:
          BoxDecoration(color: BACKGROUNDCOLOR.withOpacity(0.7)),
        keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Phone Number'.tr(),
        filled: true,

        fillColor: Color(0xFF695c4c).withOpacity(0.02),
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.6),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.6),
        ),
      ),
      initialCountryCode: 'EG',
      initialValue:  phoneNumberController.text ,
      onChanged: (phone) {
        phoneNumberController.text = phone.completeNumber;
        print(phoneNumberController.text);
        onChanged(phone.completeNumber);
      },
    );
  }
}
