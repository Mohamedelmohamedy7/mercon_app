// import 'package:animate_do/animate_do.dart';
// import 'package:core_project/Utill/Comman.dart';
// import 'package:core_project/Utill/Local_User_Data.dart';
// import 'package:core_project/View/Screen/PartAuth/LoginScreen.dart';
// import 'package:core_project/helper/Route_Manager.dart';
// import 'package:core_project/helper/color_resources.dart';
// import 'package:core_project/helper/text_style.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:nb_utils/nb_utils.dart';
//
// import '../../../helper/ImagesConstant.dart';
// import '../../Widget/comman/CustomAppBar.dart';
//
// class SelectType extends StatefulWidget {
//   const SelectType({super.key});
//
//   @override
//   State<SelectType> createState() => _SelectLocationState();
// }
//
// class _SelectLocationState extends State<SelectType>
//     with TickerProviderStateMixin {
//   bool isSelectedAlocation = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         background//color: BACKGROUNDCOLOR,
//         appBar: CustomAppBar(
//           title: 'Select User'.tr(),needBack:false,
//           backgroundImage: AssetImage(ImagesConstants.backgroundImage),
//         ),
//         bottomNavigationBar: isSelectedAlocation == true
//             ? const SizedBox()
//             : Padding(
//                 padding: const EdgeInsets.only(bottom: 40),
//                 child: LoadingAnimationWidget.inkDrop(
//                   color: Theme.of(context).primaryColor,
//                   size: 30,
//                 ),
//               ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: fadeColumn(context),
//         ),
//       ),
//     );
//   }
//
//   List<String> selectType = ["LoginAsaUser".tr(), "LoginAsaSecurity".tr()];
//   List<String> selectTypeIcon = ["assets/images/user.svg","assets/images/security.svg",];
//
//   typeWidget() {
//     return ListView.separated(
//         separatorBuilder: (context, index) => const SizedBox(
//               height: 10,
//             ),
//         shrinkWrap: true,
//         padding: const EdgeInsets.only(top: 20, bottom: 10, left: 0, right: 0),
//         itemCount: selectType.length,
//         itemBuilder: (context, index) {
//           return FadeInUp(
//             delay: Duration(
//                 milliseconds: index == 0
//                     ? 1200
//                     : index == 1
//                         ? 1600
//                         : 2000),
//             child: FadeOutUp(
//               animate: isSelectedAlocation,
//               duration: Duration(
//                   milliseconds: index == 0
//                       ? 1400
//                       : index == 1
//                           ? 1600
//                           : 1800),
//               // delay: Duration(milliseconds: 800),
//               child: InkWell(
//                 onTap: () {
//                   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                     setState(() {
//                       isSelectedAlocation = true;
//                     });
//                     Future.delayed(const Duration(milliseconds: 2000), () {
//                       pushRoute(
//                           context: context, route: LoginScreen());
//                     });
//                   });
//                   globalAccountData.setUserType("$index");
//                   if(index==1){
//                     context.locale = const Locale('ar', 'EG');
//                   }
//                 },
//                 child: Container(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//
//                   width: w(context),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(13),
//                       border: Border.all(color: Theme.of(context).primaryColor, width: 1
//                           //  Theme.of(context).dividerColor
//                           )),
//                   child: Center(
//                     child: Row(
//                       children: [
//                         SvgPicture.asset(selectTypeIcon[index]
//                           ,width: 50,height: 30,fit: BoxFit.cover,
//                         color: Theme.of(context).primaryColor,),
//                         10.width,
//                         Text(
//                           selectType[index],
//                           textAlign: TextAlign.start,
//                           style: CustomTextStyle.bold18black.copyWith(
//                               fontSize:index==1?12: 12,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
//
//   Column fadeColumn(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 60,),
//         FadeInUp(
//           child: FadeOutUp(
//             animate: isSelectedAlocation,
//             duration: const Duration(milliseconds: 1200),
//             child: Center(
//               child: Image.asset(
//                 ImagesConstants.logo,
//                 width: 180,height: 180,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         FadeInUp(
//           child: FadeOutUp(
//             animate: isSelectedAlocation,
//             duration: const Duration(milliseconds: 800),
//             child: Text("Select The type of User".tr(),
//                 textAlign: TextAlign.start,
//                 style: CustomTextStyle.bold18black
//                     .copyWith(fontWeight: FontWeight.w600, fontSize: 14)),
//           ),
//         ),
//         FadeInUp(
//           delay: const Duration(milliseconds: 400),
//           child: FadeOutUp(
//             animate: isSelectedAlocation,
//             duration: const Duration(milliseconds: 1000),
//             // delay: Duration(milliseconds: 600),
//             child: Padding(
//                 padding: const EdgeInsets.only(top: 5),
//                 child: Text(
//                     "SelectAnyTime".tr(),
//                     textAlign: TextAlign.start,
//                     style: CustomTextStyle.bold18black
//                         .copyWith(fontWeight: FontWeight.w400, fontSize: 12))),
//           ),
//         ),
//         const SizedBox(
//           height: 2,
//         ),
//         FadeInUp(
//           delay: const Duration(milliseconds: 800),
//           child: FadeOutUp(
//             animate: isSelectedAlocation,
//             duration: const Duration(milliseconds: 1200),
//             // delay: Duration(milliseconds: 600),
//             child: Text("selectFromSelectType".tr(),
//                 textAlign: TextAlign.start,
//                 style: CustomTextStyle.bold18black
//         .copyWith(fontWeight: FontWeight.w400, fontSize: 12),
//             )),
//         ),
//         typeWidget(),
//       ],
//     );
//   }
// }
