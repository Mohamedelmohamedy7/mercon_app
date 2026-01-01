import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BkBtn extends StatelessWidget {
  BkBtn();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Theme.of(context).primaryColor),
      child: InkWell(
        onTap: () {
          Navigator.canPop(context) ? Navigator.pop(context) : () {};
        },
        child: context.locale == const Locale('ar', 'EG')
            ? const RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.white,
                ))
            : const Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
              ),
      ),
    );
  }
}
