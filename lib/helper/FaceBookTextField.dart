import 'package:core_project/helper/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FacebookTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const FacebookTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        maxLines: null,
        decoration: InputDecoration(
           hintText: hintText,
          hintStyle: CustomTextStyle.bold14black.copyWith(fontSize: 12,color: Colors.black.withOpacity(0.6)),
          contentPadding: EdgeInsets.only(top: 5),
          prefixIcon: Icon(FontAwesomeIcons.facebook,size: 30,color: Theme.of(context).primaryColor,), // Facebook icon as prefix
          filled: true,
          fillColor:Colors.blue.withOpacity(0.1), // Facebook blue color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none, // Remove border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none, // Remove border
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none, // Remove border
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none, // Remove border
          ),
        ),
      ),
    );
  }
}
class InstaTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const InstaTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [
            Color(0xFFF9CE34).withOpacity(0.15),
            Color(0xFFEE2A7B).withOpacity(0.3),
            Color(0xFF6228D7).withOpacity(0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.5, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        maxLines: null,
        decoration: InputDecoration(
           hintText: hintText,
          hintStyle: CustomTextStyle.bold14black.copyWith(fontSize: 12,color: Colors.black.withOpacity(0.6)),
          contentPadding: EdgeInsets.only(top: 5),
          prefixIcon: Icon(FontAwesomeIcons.instagram,size: 30,color: Color(0xFFEE2A7B),), // Facebook icon as prefix
          filled: true,
          fillColor:Colors.blue.withOpacity(0.1), // Facebook blue color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none, // Remove border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none, // Remove border
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none, // Remove border
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none, // Remove border
          ),
        ),
      ),
    );
  }
}
