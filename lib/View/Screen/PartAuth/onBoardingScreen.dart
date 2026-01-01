import 'package:core_project/View/Screen/PartAuth/select_type.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:core_project/helper/text_style.dart';

import '../../../Utill/Comman.dart';

import '../../../helper/ImagesConstant.dart';


import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Widget/comman/comman_Image.dart';
import 'LoginScreen.dart';


class onBoardingScreen extends StatefulWidget {
  @override
  _onBoardingScreenState createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  final PageController _pageController = PageController();
  final String sharedString = "This is a shared string among pages.";

  int selected = 0;

  onPageChangedController(index) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        selected = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          cachedImage(ImagesConstants.backgroundImage,
              width: w(context), height: h(context), fit: BoxFit.cover),
          PageView.builder(
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (val) {
              onPageChangedController(val);
            },
            itemBuilder: (context, index) {
              return MyPage(
                pageText: sharedString,
                pageIndex: index + 1,
              );
            },
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              axisDirection: Axis.horizontal,
              effect: SlideEffect(
                spacing: 12.0,
                radius: 14.0,
                dotWidth: 13.0,
                dotHeight: 13.0,
                paintStyle: PaintingStyle.fill,
                strokeWidth: 1,
                dotColor: lightGray,
                activeDotColor: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only( top: 20,left: 20, right: 20),
            //   child: Text(
            //     "AppNameOnBoarding".tr(),
            //     style: CustomTextStyle.bold18black
            //         .copyWith(color: Theme
            //         .of(context)
            //         .primaryColor,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only( left: 20, right: 20),
              child: Text(
                  selected==0? "onBoardingtext1".tr():selected==1? "onBoardingtext2".tr():"onBoardingtext3".tr(),
                style: CustomTextStyle.regular14Black
                    .copyWith(color: grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only ( top: 20),
              child: GestureDetector(
                onTap: () {
                  if (selected < 2) {
                    setState(() {
                      selected++;
                    });
                    onPageChangedController(selected);
                  } else {
                    pushRoute(context: context, route: const LoginScreen());
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      shape: BoxShape.circle
                  ),
                  child: CircularPercentIndicator(
                    radius: 40.0,
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 5.0,
                    percent: selected == 0 ? 0.4 : selected == 1 ? 0.75 : 1,
                    center: const Icon(
                      Icons.arrow_forward_ios_outlined, color: white,),
                    circularStrokeCap: CircularStrokeCap.butt,
                    backgroundColor: lightGray,
                    progressColor: Colors.black,
                  ),
                ),
              ),
            ),
              10.height,
          ],)
        ],
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  final String pageText;
  final int pageIndex;
  List<String> onBoardIngImages = [
    ImagesConstants.step1,
    ImagesConstants.step2,
    ImagesConstants.step3,
  ];

  MyPage({super.key, required this.pageText, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        EasyLocalization.of(context)?.currentLocale?.languageCode == 'ar'
        ? Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(3.14), // Rotate 180 degrees horizontally
      child: cachedImage(onBoardIngImages[pageIndex - 1],
          height: pageIndex - 1 == 0 ? h(context) * 0.59 : h(context) * 0.63,
          width: w(context),
          fit: pageIndex - 1 == 0 ? BoxFit.cover : BoxFit.fill),
    )
        : cachedImage(onBoardIngImages[pageIndex - 1],
        height: pageIndex - 1 == 0 ? h(context) * 0.59 : h(context) * 0.63,
        width: w(context),
        fit: pageIndex - 1 == 0 ? BoxFit.cover : BoxFit.fill),]);
  }
}
