import 'package:core_project/Provider/HomeProvider.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'MobileSliderDots.dart';

class CarouselSliderExample extends StatefulWidget {
  const CarouselSliderExample({
    Key? key,
  }) : super(key: key);

  @override
  State<CarouselSliderExample> createState() => _CarouselSliderExampleState();
}

class _CarouselSliderExampleState extends State<CarouselSliderExample> {
  @override
  void initState() {
    super.initState();
  }

  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, model, _) {
        if (model.status == LoadingStatus.LOADING) {
          return _buildLoadingShimmer();
        } else if (model.status == LoadingStatus.SUCCESS &&
            model.mobileSliders.length > 0) {
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width, // عرض الشاشة كله
                height: 230,
                child: CarouselSlider.builder(
                  itemCount: model.mobileSliders.length,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        child: cachedImage(
                          '${model.mobileSliders[index].sliderPath}',
                          fit: BoxFit.fill, // بدل fill عشان ياخد العرض والارتفاع بشكل مناسب
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    height: 200,
                    viewportFraction: 0.8,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                ),
              ),
               MobileSliderDots(currentPage: _currentPage),
              5.height,
            ],
          );
        } else {
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: cachedImage(
                  '',
                  fit: BoxFit.fill,
                  height: 190,
                ),
              ),
              10.height,
            ],
          );
        }
      },
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: CarouselSlider.builder(
          itemCount: 7,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Container(
              color: Colors.white,
            );
          },
          options: CarouselOptions(
            height: 200,
            viewportFraction: 0.8,
            enableInfiniteScroll: true,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
        ));
  }
}
