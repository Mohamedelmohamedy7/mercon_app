import 'package:core_project/View/Screen/ComplainScreen.dart';
import 'package:core_project/View/Widget/comman/comman_Image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Utill/Comman.dart';
import 'package:flutter/material.dart';

import '../../helper/ImagesConstant.dart';
import '../Widget/comman/CustomAppBar.dart';

// نموذج البيانات لكل شكوى
class ComplaintModel {
  final String status;
  final String title;
  final String unitInfo;
  final String date;
  final String image;

  final Color color;
  ComplaintModel({
    required this.status,
    required this.title,
    required this.unitInfo,
    required this.date,
    required this.image,
    required this.color,
  });
}

// ويدجت البطاقة
class ComplaintCard extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintCard({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6EFE7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: complaint.color,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 2.0),
                      child: Text(
                        complaint.status,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Text(
                      complaint.title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          complaint.unitInfo,
                          style: const TextStyle(
                            color: Color(0xff695C4C),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "التاريخ :${complaint.date}",
                          style: const TextStyle(
                            color: Color(0xff695C4C),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            cachedImage(
              complaint.image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

// مثال على ListView مع 4 عناصر
class ComplaintListView extends StatelessWidget {
  const ComplaintListView({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات تجريبية
    final List<ComplaintModel> complaints = [
      ComplaintModel(
        status: "جديـــــــدة",
        title: "حنفية المياه لا تعمل",
        unitInfo: "الوحده 505 , المبنى ج , الطابق 6",
        date: "2-12-2025",
        image: "assets/images/com/com_1.png",
        color: Color(0xff247DDB),
      ),
      ComplaintModel(
        status: "قيد المعالجة",
        title: "تكيف الهواء لا يبرد الهواء بشكل صحيح",
        unitInfo: "الوحده 505 , المبنى ج , الطابق 6",
        date: "1-12-2025",
        image: "assets/images/com/com_4.png",
        color: Color(0xffE8944E),
      ),
      ComplaintModel(
        status: "تم الحــــــل",
        title: "حنفية المياه لا تعمل",
        unitInfo: "الوحده 203 , المبنى أ , الطابق 2",
        date: "1-12-2025",
        image: "assets/images/com/com_3.png",
        color: Color(0xff55B971),
      ),
      ComplaintModel(
        status: "تم الحــــــل",
        title: "تكيف الهواء لا يبرد الهواء بشكل صحيح",
        unitInfo: "الوحده 505 , المبنى ج , الطابق 6",
        date: "20-10-2025",
        image: "assets/images/com/com_2.png",
        color: Color(0xff55B971),
      ),
    ];

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        return ComplaintCard(complaint: complaints[index]);
      },
    );
  }
}

class AllComplaintsScreen extends StatefulWidget {
  final bool needBack;
  final bool fromSecurity;
  const AllComplaintsScreen(
      {Key? key, required this.needBack, this.fromSecurity = false});
  @override
  _AllComplaintsScreenState createState() => _AllComplaintsScreenState();
}

class _AllComplaintsScreenState extends State<AllComplaintsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF695C4C), // اللون
        statusBarIconBrightness: Brightness.light, // Android
        statusBarBrightness: Brightness.dark, // iOS
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).primaryColor,
        //   elevation: 0,
        //   centerTitle: false,
        //   automaticallyImplyLeading: false,
        //   titleSpacing: 16,
        //   title: Row(
        //     children: [
        //       InkWell(
        //         onTap: () {
        //           popRoute(context: context);
        //         },
        //         child: Icon(
        //           Icons.arrow_back_ios_sharp,
        //           color: Color(0xffCCB6A1),
        //           size: 21,
        //         ),
        //       ),
        //       const SizedBox(width: 14),
        //       Expanded(
        //         child: FittedBox(
        //           fit: BoxFit.scaleDown,
        //           alignment: Alignment.centerRight,
        //           child: Text(
        //             'Complaints_and_Suggestions'.tr(),
        //             style: TextStyle(
        //               color: Color(0xffCCB6A1),
        //               fontSize: 18,
        //               fontWeight: FontWeight.w500,
        //             ),
        //             maxLines: 1,
        //           ),
        //         ),
        //       ),
        //       const SizedBox(width: 20),
        //       cachedImage(
        //         'assets/images/logo_m.png',
        //          height: 28,
        //           fit: BoxFit.contain,
        //       ),
        //     ],
        //   ),
        // ),
        appBar:  CustomAppBar(
          title: 'Complaints_and_Suggestions'.tr(),
          needBack: widget.needBack,
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: SingleChildScrollView(
         // padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        pushRoute(
                          context: context,
                          route: const ComplaintFormScreen(
                            needBack: true,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'add_complaint'.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              ComplaintListView(),
              // Container(
              //   height: 180,
              //   decoration: BoxDecoration(
              //     color: const Color(0xFFF6EFE7),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child:        Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 12),
              //     child: Row(
              //       mainAxisAlignment:
              //       MainAxisAlignment.spaceBetween,
              //       children: [
              //         Expanded(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Container(
              //                   decoration: BoxDecoration(
              //                     borderRadius:
              //                     BorderRadius.circular(20),
              //                     color: Color(0xff247DDB),
              //                   ),
              //                   child: Padding(
              //                     padding: EdgeInsets.symmetric(
              //                         horizontal: 20.0,
              //                         vertical: 2.0),
              //                     child: Text(
              //                       'جديـــــــدة',
              //                       style: TextStyle(
              //                           color: Colors.white),
              //                     ),
              //                   )),
              //               SizedBox(
              //                 height: 10,
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.only(left: 60),
              //                 child: Center(
              //                   child: Expanded(
              //                     child: Text(
              //                       "حنفية المياه بايظة",
              //                       textAlign: TextAlign.center,
              //
              //                       style: TextStyle(fontSize: 16,),
              //                       maxLines: 2,
              //
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               SizedBox(
              //                 height: 2,
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       "الوحده 505 , المبنى ج , الطابق 6",
              //                       style: TextStyle(
              //                         color: Color(0xff695C4C),
              //                         fontSize: 12,
              //                       ),
              //                     ),
              //                     Text(
              //                       "التاريخ :2-12-2025",
              //                       style: TextStyle(
              //                         color: Color(0xff695C4C),
              //                         fontSize: 12,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         Image.asset(
              //           "assets/images/com/com1.png",
              //           width: 100,
              //           height: 100,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
