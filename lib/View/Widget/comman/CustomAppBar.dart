import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../helper/ImagesConstant.dart';
import '../../../helper/text_style.dart';
import 'comman_Image.dart';
import 'package:core_project/Utill/Local_User_Data.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final ImageProvider<Object> backgroundImage;
  bool? needBack;

  CustomAppBar({
    super.key,
    this.needBack = true,
    required this.title,
    required this.backgroundImage,
    this.leading,
  });

//backGroundOrder.png
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.079,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: backgroundImage,
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                if (leading != null) leading!,
                15.width,
                needBack == false
                    ? Text(
                        title,
                        style: CustomTextStyle.semiBold12Black.copyWith(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          popRoute(context: context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                needBack == false
                    ? const SizedBox()
                    : Text(
                        title,
                        style: CustomTextStyle.semiBold12Black.copyWith(
                          fontSize: 12,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                const Spacer(),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  // child: cachedImage( ImagesConstants.logo, width: 50, height: 50),
                  child: cachedImage(
                      globalAccountData.getCompoundLogo(),
                      width: 50,
                      height: 50,
                    color: Theme.of(context).primaryColor
                      ),
                ),
                10.width,
              ],
            ),
            Container(
              height: 3,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight + 100.0); // Adjust the height as needed
}
