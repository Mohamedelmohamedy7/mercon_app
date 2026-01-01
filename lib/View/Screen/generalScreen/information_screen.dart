import 'dart:io';

import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';

import '../../../Provider/VisitorProvider.dart';
import '../../../Utill/Comman.dart';
import '../../../helper/ButtonAction.dart';
import '../../../helper/ImagesConstant.dart';
import '../../../helper/Route_Manager.dart';
import '../../../helper/SnackBarScreen.dart';
import '../../../helper/text_style.dart';
import '../../Widget/comman/CustomAppBar.dart';

class InformationScreen extends StatefulWidget {
  final String name;
  final String relationship;
  final String nationalId;
  final List<File> imageNationalIdFrontFile;
  final String email;
  final List<File> imageNationalIdBackFile;
  final bool isRent;
  final bool isVisitor;
  final DateTime entryDateTime;
  final DateTime checkOutDateTime;
  final String facebookLink;
  final String instagramLink;
  final String totalWithVisitorCount;
  final String unitId;
  final String phoneNumber;

  const InformationScreen({
    required this.name,
    required this.relationship,
    required this.nationalId,
    required this.imageNationalIdFrontFile,
    required this.email,
    required this.imageNationalIdBackFile,
    required this.isRent,
    required this.isVisitor,
    required this.entryDateTime,
    required this.checkOutDateTime,
    required this.facebookLink,
    required this.instagramLink,
    required this.totalWithVisitorCount,
    required this.unitId,
    required this.phoneNumber,
  });

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  bool isCheck = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<VisitorProvider>(context, listen: false)
        .getTermsAndConditions(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            title: 'sendInvention'.tr(),
            backgroundImage: AssetImage(ImagesConstants.backgroundImage),
          ),
          body: Container(
            //color: BACKGROUNDCOLOR,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<VisitorProvider>(
                    builder: (context, model, _) {
                      if (model.getTermsAndConditionsLoading == true) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [LoaderWidget()]);
                      } else {
                        if (model.termsAndConditionsModel != null)
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: HtmlWidget(
                                model.termsAndConditionsModel
                                        ?.internalRegulation ??
                                    "",
                                textStyle: TextStyle(fontSize: 15),
                                enableCaching: true,
                              ),
                            ),
                          );
                        else
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 14),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'استمارة تعليمات',
                                    style:
                                        CustomTextStyle.regular14Black.copyWith(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: w(context),
                                child: Center(
                                  child: Text(
                                    "يتم دفع مبلغ 1000 جنية كتأمين لحين المغادرة وتسليم الوحدة لمسؤول الاستلام بدون أي تلفيات.",
                                    style: CustomTextStyle.regular14Black
                                        .copyWith(fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: w(context),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 2.0),
                                      _buildListItem(
                                          'مراعاة اتباع لائحة منظومة تأجير الوحدات والحفاظ على نظافة القرية والالتزام بتعليمات الامن.'),
                                      _buildListItem(
                                          'التزام العملاء بتسليم أصل بطاقة الحاجز و بتقديم كافة المستندات لأثبات درجات القرابة والعلاقات الزوجية. (يحظر تماما دخول اية افراد من الجنسين ولا تربطهم علاقة زوجيه)'),
                                      _buildListItem(
                                          'يحظر تماما دخول افراد دون المستوى اللائق بالمنتجع من حيث الملبس والسلوك والشكل العام.'),
                                      _buildListItem(
                                          'تنتهي مدة الإقامة بتاريخ المغادرة المثبت في الاستمارة ولا يجوز تجديد المدة إلا باستمارة جديدة.'),
                                      _buildListItem(
                                          'يتم رد مبلغ التامين للضيوف يوم المغادرة وبعد التأكد من عدم وجود أي تلفيات.'),
                                      _buildListItem(
                                          'عدم اصطحاب الحيوانات بأنواعها خارج حدود الوحدة ويمنع دخولها مناطق المطاعم والكافتريات مع مراعاة منع خطورتها على الغير من المقيمين داخل المنتجع.'),
                                      _buildListItem(
                                          'عدم استخدام مكبرات الصوت داخل المنتجع حفاظا على راحة وسلامة المقيمين داخل المنتجع.'),
                                      _buildListItem(
                                          'عدم التجول بالمنتجع والشاطئ بالجلباب والملابس المنزلية و ممنوع المأكولات(حلل) على حمام السباحة والبحر.'),
                                      _buildListItem(
                                          'عدم استخدام حمام السباحة أو نزول البحر الا بالزي المخصص للسباحة.'),
                                      _buildListItem(
                                          'عدم ممارسة الصيد الا في الأماكن المخصصة لذلك.'),
                                      _buildListItem(
                                          'يتم دفع 100 جنيها عن كل ليلة نظير استخدام خدمات و مرافق المنتجع.'),
                                      _buildListItem(
                                          'يلتزم المالك بان يكون عقد ايجار المستأجر مذكور به عدد الافراد (بحد أقصى عدد 4 للغرفه / 6 للغرفتين / 8 للثلاث غرف) (في حالة زيادة فرد واحد بحد اقصى فردين يقوم المستأجر بسداد مبلغ 150ج عنه لكل ليلة).'),
                                      _buildListItem(
                                          'يجوز للضيف استقبال زيارات أقاربه من الدرجة الأولى والثانية فقط مقابل سداد مبلغ 300 جنيهاَ عن كل فرد لليوم (بدون مبيت) و بدون تعدى اجمالى العدد الاقصى المحددة لكل نموذج.'),
                                      _buildListItem(
                                          'عدم نشر آية ملابس من أسوار الشرفات (الغسيل).'),
                                      _buildListItem(
                                          'يمنع منعاَ باتاَ دخول أو استعمال مشروبات روحيه أو مواد مخدرة في كافة ارجاء المنتجع ويتم استبعاد حائزها فوراَ ولا يحق له رد التأمين.'),
                                      _buildListItem(
                                          'يحظر نزول حمامات السباحة إلا في المواعيد المخصصة لذلك.'),
                                      _buildListItem(
                                          'الأطفال مسئولية ذويهم من نزول حمامات السباحة أو شاطئ البحر أو تحركاتهم داخل المنتجع.'),
                                      _buildListItem(
                                          'المنتجع غبر مسؤول عن أي مفقودات او متعلقات ثمينة.'),
                                      _buildListItem(
                                          'التأكد من ركن السيارة وغلقها في المكان المخصص لها، والمنتجع غير مسئول عن أي متعلقات شخصية داخل السيارة أو المفقودة من الضيوف.'),
                                      _buildListItem(
                                          'الإدارة غير مسئولة عن سيارات السادة النزلاء حيث دور الامن مقتصر على تنظيم السيارات فقط.'),
                                      _buildListItem(
                                          'اتعهد طوال مدة الإقامة بارتداء إسورة المنتجع وإظهارها عند السؤال عنها.'),
                                      _buildListItem(
                                          'متوافر برسوم خدمة فندقية طول مدة الاقامة و بعد مغادرة سيادتكم للشاليه.'),
                                      _buildListItem(
                                          'اقر بأنني بمخالفتي لهذه التعليمات أتحمل المسئولية عما يقع من اضرار لنفسي أو مرافقي ويحق لإدارة المنتجع توقيع العقوبة التي تراه مناسبة وقد تصل الي الاستبعاد من المنتجع.'),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 14),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'لائحة خاصة بمنظومة إدارة تأجير الوحدات بالقرية',
                                        style: CustomTextStyle.regular14Black
                                            .copyWith(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: w(context),
                                  child: Column(children: [
                                    Text(
                                      'حرصاً منا للحفاظ على سلامة وامن الجميع وقضاء وقت ممتع بالقرية يجب الالتزام باللائحة لتحقيق الاستقرار والامن و الراحة لجميع الملاك والضيوف داخل قرية كورنادو.\n\n'
                                      'يلتزم كل من السادة المؤجرين بقرية كورنادو مارينا السخنة بالآتي:\n',
                                      style: CustomTextStyle.regular14Black
                                          .copyWith(fontSize: 13),
                                    ),
                                    _buildListItem(
                                        'يلتزم السادة المؤجرين بتقديم الأوراق الآتية:'),
                                    _buildSubListItem(
                                        'أ- ارسال صور الرقم القومي للسادة الضيوف و المستأجرين قبل وصولهم خلال 24 ساعة حتى يتثنى لنا ارسال البيانات للجهات الأمنية.'),
                                    _buildSubListItem(
                                        'ب- ارسال شهادات ميلاد لمن دون 16 عام.'),
                                    _buildSubListItem(
                                        'ج- ارسال البيانات الخاصة بالمستأجرين والضيوف اقاربه من حيث عددهم وتاريخ الوصول وتاريخ المغادرة ورقم الوحدة.'),
                                    _buildSubListItem(
                                        'الالتزام باظهار البطايق الشخصية لكل الضيوف عند الدخول.'),
                                    _buildListItem(
                                        'يلتزم المالك المؤجر بإيجار الوحدة الي العائلات فقط مع إنتقاء نوعية الضيوف للارتقاء بالمستوى العام للقرية.'),
                                    _buildListItem(
                                        'يلتزم المالك بان يكون عقد ايجار المستأجر مذكور به عدد افراد الوحدة (عدد 4 ضيوف بالغرفة الواحدة / عدد 6 ضيوف بالغرفتين / عدد 8 ضيوف بالثلاث غرف). ملحوظة هامة: في حالة زيادة فرد واحد فقط بحد اقصى فردين يقوم المستأجر بسداد مبلغ مائة وخمسون جنيهاً عن كل فرد زيادة لكل ليلة.'),
                                    _buildListItem(
                                        'يلتزم المؤجر بإبلاغ المستأجر بسداد مبلغ (100 جنيها) لادارة القرية عن كل ليلة نظير إستخدام مرافق وخدمات القرية ويتم سدادها قبل الدخول من البوابات و مقابل ايصال معتمد من القرية.'),
                                    _buildListItem(
                                        'يلتزم المؤجر بسداد المصروفات الإدارية الخاصة بمنظومة إدارة الوحدات الايجارية وفي حالة عدم سداد المصروفات يتم تجميد الوحدة ايجاريا ولا يجوز التعامل عليها إلا للاستخدام الشخصي للمالك فقط.'),
                                    _buildListItem(
                                        'يلتزم المؤجر بتبليغ المستأجر بالتوقيع على استمارة التعليمات الخاصة بالزائرين قبل الدخول وبارتداء الاسورة الخاصة بهم طول فترة الاقامة. ملحوظة هامة: يتم توقيع المستأجر على استمارة التعليمات اثناء دخول المستأجر من على بوابة القرية.'),
                                    _buildListItem(
                                        'ممنوع تجمع الزائرين للوحدات في وحدة واحدة وفي حالة مخالفة ذلك يطبق غرامة 1000 جنيهاَ للوحدة حفاظا على راحة وسلامة المقيمين داخل المنتجع.'),
                                    _buildListItem(
                                        'ممنوع دخول أي سيارات اجرة أو اتوبيسات او ميكرو باصات إلا السياحي منها.'),
                                    _buildListItem(
                                        'يجوز للمالك الاستضافة فى الوحدة المصيفية ملكه فقط واستقبال زيارات أقاربه من الدرجة الأولى والثانية فقط مع ابلاغ بياناتهم و صور الرقم القومي لهم قبل وصولهم القرية. و ايضا يجوز للمالك استضافة معارفة واصدقائه بوجودة شخصيا لاستقبالهم مع الإلتزام بالعدد المحدد لكل شاليه.'),
                                    _buildListItem(
                                        'يجوز للضيف استقبال زيارات أقاربه من الدرجة الأولى والثانية فقط مقابل سداد مبلغ 300 جنيهاَ عن كل فرد لليوم (بدون مبيت) و بدون تعدى اجمالى العدد الاقصى المحددة لكل نموذج. تسليم وتسلم الوحدة الى ومن الضيوف اما عن طريق المالك او عن طريق المكتب.'),
                                    _buildSubListItem(
                                        'الاجراءات الادارية والامنية عن حجز الضيوف سيقوم بها المكتب و كذلك استلام وتحويل الاموال و كذلك تسويق الشاليهات لمن يرغب من الملاك بدون رسوم. المكتب موفر خدمة تسليم وتسلم و خدمة فندقية طول فترة الاقامة وبعدها برسوم محددة ب ٢٠٠ ج للغرفة و ٢٥٠ ج للغرفتين و ٣٠٠ ج للثلاث غرف لمن يرغب.'),
                                    _buildListItem(
                                        'يمنع منعاَ باتاَ تشغيل الوحدة خارج منظومة ايجار الوحدات وفي حالة الكشف عن ايجار وحدة خارج المنظومة يتم تجميد الوحدة ايجارياَ ثلاث أشهر وغرامة خمسة الاف جنيهاَ. وان ثبت خلال مرور الامن اشغال الوحدة بغير المسجلين على البوابة سيتم تطبيق غرامات على الوحدة و ستتعرض للايقاف ايجاريا.'),
                                    _buildListItem(
                                        'في حالة قيام المستأجر باي تلفيات داخل المنتجع يتم أخطار المؤجر ليقوم بتسوية قيمة التلفيات من المستأجر أو يقوم بدفعها.'),
                                    _buildListItem(
                                        'يلتزم المستأجر باللائحة الداخلية للقرية وتنفيذ ما هو بداخل اللائحة وفي حالة عدم التزام المستأجر باللائحة واستمارة التعليمات الموقع عليها من المستأجر يتم مغادرة القرية عن طريق أمن القرية دون الرجوع للمؤجر.'),
                                    _buildListItem(
                                        'رجاء التواصل فورا مع مكتب الايجارات لاى استفسار او اقتراح او مشكلة خاصة بالايجارات.'),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          );
                      }
                    },
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              child: Container(
                                child: Checkbox(
                                    value: isCheck,
                                    onChanged: (selected) {
                                      setState(() {
                                        isCheck = selected!;
                                      });
                                    }),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.70,
                                child: Text(
                                  "الموافقة على تعليمات اللاستمارة و شروط اللائحة الداخلية"
                                      .tr(),
                                  style: CustomTextStyle.regular14Black
                                      .copyWith(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: widgetWithAction.buttonAction<VisitorProvider>(
                              action: (model) {
                                if (isCheck == false) {
                                  showAwesomeSnackbar(
                                    context,
                                    'On Snap!',
                                    'من فضلك قم بالموافقة على تعليمات اللاستمارة و شروط اللائحة الداخلية',
                                    contentType: ContentType.failure,
                                  );
                                } else {
                                  model
                                      .sendVisitorQrCode(context,
                                          name: widget.name,
                                          relationship: widget.relationship,
                                          nationalId: widget.nationalId,
                                          imageNationalIdFrontFile:
                                              widget.imageNationalIdFrontFile,
                                          email: widget.email,
                                          imageNationalIdBackFile:
                                              widget.imageNationalIdBackFile,
                                          isRent: widget.isRent,
                                          isVisitor: widget.isVisitor,
                                          entryDateTime: widget.entryDateTime,
                                          checkOutDateTime:
                                              widget.checkOutDateTime,
                                          facebookLink: widget.facebookLink,
                                          instagramLink: widget.instagramLink,
                                          totalWithVistiorCount:
                                              widget.totalWithVisitorCount,
                                          unitId: widget.unitId.toString(),
                                          phoneNumber: widget.phoneNumber)
                                      .then((value) {
                                    if (value != null) {
                                      pushNamedAndRemoveUntilRoute(
                                        context: context,
                                        route: Routes.dashBoard,
                                      );
                                      showAwesomeSnackbar(
                                        context,
                                        'Success!',
                                        '${value["message"]}',
                                        contentType: ContentType.success,
                                      );
                                    }
                                  });
                                }
                              },
                              context: context,
                              text: "sendRequest"),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(fontSize: 18.0),
          ),
          Expanded(
            child: Text(
              text,
              style: CustomTextStyle.regular14Black.copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '◦ ',
            style: CustomTextStyle.regular14Black.copyWith(fontSize: 16),
          ),
          Expanded(
            child: Text(
              text,
              style: CustomTextStyle.regular14Black.copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
