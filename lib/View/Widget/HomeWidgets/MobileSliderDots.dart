import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../Provider/HomeProvider.dart';

class MobileSliderDots extends StatelessWidget {
  const MobileSliderDots({super.key, required int currentPage,}) : _currentPage = currentPage;

  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: DotsIndicator(
        dotsCount: Provider.of<HomeProvider>(context).mobileSliders.length,
        position: _currentPage,
        decorator: DotsDecorator(
          size: const Size(9, 13),          // باقي النقط
          activeSize: const Size(32, 10),    // النقطة الـ Active أطول
          color: lightGray,
          activeColor: Colors.white,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
