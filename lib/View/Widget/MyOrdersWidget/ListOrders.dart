import 'package:core_project/Model/SuperAdminModels/get_all_service_rate_model.dart';
import 'package:core_project/Provider/ServicesProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/View/Widget/EmojRate/flutter_emoji_feedback.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import '../../../Model/ServicesComponantModel/MyServicesModel.dart';
import '../../../Provider/SuperAdminProviders/CutomerServiceProvider.dart';
import '../../../Utill/validator.dart';
import '../../../helper/color_resources.dart';
import '../../../helper/date_converter.dart';
import '../../../helper/text_style.dart';
import '../../Screen/Services/ServicesCategories.dart';
import '../comman/comman_Image.dart';

TextStyle headerStyle() {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    // color: Colors.green,
  );
}

  emptyList() {
  return Lottie.asset("assets/images/MXxGLf5x75.json");
}

ListView shimmerList() {
  return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: buildShimmer(context),
        );
      },
      separatorBuilder: (context, index) => 2.height,
      itemCount: 5);
}

TabBar TabBarHeader(BuildContext context, TabController tabController) {
  return TabBar(
    dividerColor: Colors.transparent,
    dividerHeight: 0,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    labelStyle: CustomTextStyle.semiBold14grey,
    indicatorColor:Colors.transparent,
    controller: tabController,
    unselectedLabelColor: Colors.grey,

    labelColor: Theme.of(context).primaryColor,
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15)),
    dragStartBehavior: DragStartBehavior.start,
    unselectedLabelStyle: CustomTextStyle.medium14Black.copyWith(fontSize: 12),
    isScrollable: false,
    tabs: [
      Tab(text: "Requested".tr()),
      Tab(text: "processing".tr()),
      Tab(text: "alreadyFinished".tr()),
      // Tab(text: "Cancelled".tr()),
    ],
  );
}

int? rating;

Widget BodyTabView(
  List<ServiceRequest> list, {
  bool isFinished = false,
  required List<RateModel> rateList,
}) {
  String? rateLabelFun({index}) {
    RateModel rateLabel = rateList.firstWhere(
      (element) => element.id == list[index].rateId,
      orElse: () =>
          RateModel(id: -1, label: 'Not Found'), // Provide a default value
    );

    if (rateLabel == null || rateLabel.id == -1) {
      return null;
    } else {
      return rateLabel.label;
    }
  }

  EmojiModel? selectedModel;
  String? getSrcByEmojiName(String? emojiName) {
    switch (emojiName) {
      case "غير راضي":
        return "assets/images/emoj/classic_bad.svg";
      case "مقبول":
        return "assets/images/emoj/classic_good.svg";
      case "جيد":
        return "assets/images/emoj/classic_very_good.svg";
      case "راضي جدا":
        return "assets/images/emoj/classic_awesome.svg";
      default:
        return "assets/images/emoj/no.svg"; // Handle unmatched names
    }
  }

  List<EmojiModel> convertRateModelToEmojiModel() {
    return rateList.map((rateModel) {
      return EmojiModel(
          id: rateModel.id,
          src: getSrcByEmojiName(rateModel.label?.trim()),
          label: rateModel.label ?? 'غير معروف');
    }).toList();
  }

  List<EmojiModel> classicEmojiPresetCustom = convertRateModelToEmojiModel();
  return list.length <= 0
      ? emptyList()
      : AnimationLimiter(
          child: ListView.separated(
              padding: EdgeInsets.only(bottom: 40),
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    cachedImage(
                                        list[index].serviceType?.iconURLPath,
                                        width: 80,
                                        height: 80),
                                    10.width,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            list[index].serviceType?.name ??
                                                "${"other".tr()}",
                                            style: CustomTextStyle.medium10Gray,
                                          ),
                                          2.height,
                                          Text(
                                            DateConverter.localDateToIsoString(
                                                DateTime.parse(
                                                    list[index].createdDate!)),
                                            style: CustomTextStyle.medium10Gray,
                                          ),
                                          2.height,
                                          Text(
                                            "${list[index].details}",
                                            style: CustomTextStyle.bold14black,
                                          ),
                                          5.height,
                                          list[index].isApprove.toString() ==
                                                      "null" &&
                                                  list[index].dateFrom !=
                                                      null &&
                                                  list[index].dateTo != null
                                              ? Text(
                                                  "timeOfExcitedServiceAreyouavalibe"
                                                      .tr(),
                                                  textAlign: TextAlign.start,
                                                  style: CustomTextStyle
                                                      .bold14black
                                                      .copyWith(
                                                          color: Colors.black),
                                                )
                                              : SizedBox(),
                                          5.height,
                                          Column(
                                            children: [
                                              list[index].dateFrom == null
                                                  ? SizedBox()
                                                  : Text(
                                                      "${"from".tr()} ${list[index].dateFrom}",
                                                      style: CustomTextStyle
                                                          .regular14Black,
                                                    ),
                                              list[index].dateTo == null
                                                  ? SizedBox()
                                                  : Text(
                                                      "${"to".tr()} ${list[index].dateTo}",
                                                      style: CustomTextStyle
                                                          .regular14Black,
                                                    ),
                                            ],
                                          ),
                                          5.height,
                                          list[index].isApprove.toString() == "null" &&
                                                  list[index].dateFrom != null &&
                                                  list[index].dateTo != null
                                              ? Row(children: [
                                                  Expanded(
                                                    child: Consumer<
                                                            CustomerServiceProvider>(
                                                        builder: (context,
                                                            model, _) {
                                                      return InkWell(
                                                        onTap: () {
                                                          model
                                                              .sendTimeOfService(
                                                                  context,
                                                                  body: {
                                                                "Id":
                                                                    list[index]
                                                                        .id,
                                                                "isApprove":
                                                                    true
                                                              }).then((value) {
                                                            Provider.of<ServicesProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .getAllMyServices(
                                                                    context);
                                                          });
                                                        },
                                                        child: model.loading
                                                            ? Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              )
                                                            : Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                height: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .green,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Accepted"
                                                                        .tr(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: CustomTextStyle
                                                                        .bold14black
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.white),
                                                                  ),
                                                                )),
                                                      );
                                                    }),
                                                  ),
                                                  Expanded(
                                                      child: InkWell(
                                                    onTap: () {
                                                      DateTime? startDate1 =
                                                          DateTime.now();

                                                      DateTime? endDate1 =
                                                          DateTime.now();

                                                      DateTime? startTime;
                                                      DateTime? endTime;

                                                      showModalBottomSheet(
                                                          context: context,
                                                          isScrollControlled:true,
                                                          builder: (context) {
                                                            return StatefulBuilder(
                                                              builder: (context,
                                                                      state) =>
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(14.0),
                                                                    child: Column(
                                                                      mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                    Column(
                                                                      children: [
                                                                        /// Row لوقت البداية
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              "fromDate".tr(),
                                                                              style:
                                                                                  headerStyle(),
                                                                              textAlign:
                                                                                  TextAlign.center,
                                                                            ),
                                                                            Spacer(),
                                                                            InkWell(
                                                                              onTap:
                                                                                  () {
                                                                                showDialog(
                                                                                  context: context,
                                                                                  builder: (context) => Dialog(
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        TimePickerSpinner(
                                                                                          locale: const Locale('en', ''),
                                                                                          time: startTime,
                                                                                          is24HourMode: true,
                                                                                          isShowSeconds: false,
                                                                                          itemHeight: 80,
                                                                                          normalTextStyle: const TextStyle(fontSize: 24),
                                                                                          highlightedTextStyle: const TextStyle(fontSize: 24, color: Colors.blue),
                                                                                          isForce2Digits: true,
                                                                                          onTimeChange: (time) {
                                                                                            state(() {
                                                                                              startTime = time;
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                        InkWell(
                                                                                          onTap: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          child: Container(
                                                                                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                                                                                              height: 50,
                                                                                              width: 90,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.black,
                                                                                                borderRadius: BorderRadius.circular(15),
                                                                                              ),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                "select".tr(),
                                                                                                style: TextStyle(color: Colors.white, fontSize: 14),
                                                                                              ))),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child:
                                                                                  Container(
                                                                                height: 40,
                                                                                width: 90,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.black,
                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    startTime == null ? "selectHour".tr() : "${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}",
                                                                                    style: TextStyle(color: Colors.white, fontSize: 14),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),

                                                                        /// DatePicker لليوم
                                                                        SizedBox(
                                                                            height:
                                                                                8),
                                                                        Container(
                                                                          height:
                                                                              100,
                                                                          decoration: BoxDecoration(
                                                                              color:
                                                                                  Colors.white,
                                                                              borderRadius: BorderRadius.circular(15),
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  color: Colors.grey.shade300,
                                                                                  offset: Offset(0.0, 2.0),
                                                                                  blurRadius: 2.0, // Specify the blur radius
                                                                                )
                                                                              ]),
                                                                          child:
                                                                              DatePicker(
                                                                            DateTime
                                                                                .now(),
                                                                            initialSelectedDate:
                                                                                startDate1 ?? DateTime.now(),
                                                                            selectionColor:
                                                                                Colors.black,
                                                                            selectedTextColor:
                                                                                Colors.white,
                                                                            onDateChange:
                                                                                (date) {
                                                                              state(() {
                                                                                startDate1 = date;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                19),
                                                                        Container(
                                                                          height:
                                                                              20,
                                                                          color: Colors
                                                                              .grey
                                                                              .shade100,
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                10),

                                                                        /// Row لوقت النهاية
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              "toDate".tr(),
                                                                              style:
                                                                                  headerStyle(),
                                                                              textAlign:
                                                                                  TextAlign.center,
                                                                            ),
                                                                            Spacer(),
                                                                            InkWell(
                                                                              onTap:
                                                                                  () {
                                                                                showDialog(
                                                                                  context: context,
                                                                                  builder: (context) => Dialog(
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      children: [
                                                                                        TimePickerSpinner(
                                                                                          locale: const Locale('en', ''),
                                                                                          time: endTime,
                                                                                          is24HourMode: true,
                                                                                          isShowSeconds: false,
                                                                                          itemHeight: 80,
                                                                                          normalTextStyle: const TextStyle(fontSize: 24),
                                                                                          highlightedTextStyle: const TextStyle(fontSize: 24, color: Colors.blue),
                                                                                          isForce2Digits: true,
                                                                                          onTimeChange: (time) {
                                                                                            state(() {
                                                                                              endTime = time;
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                        InkWell(
                                                                                          onTap: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          child: Container(
                                                                                              margin: const EdgeInsets.only(top: 10, bottom: 10),
                                                                                              height: 50,
                                                                                              width: 90,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.black,
                                                                                                borderRadius: BorderRadius.circular(15),
                                                                                              ),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                "select".tr(),
                                                                                                style: TextStyle(color: Colors.white, fontSize: 14),
                                                                                              ))),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child:
                                                                                  Container(
                                                                                height: 40,
                                                                                width: 90,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.black,
                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    endTime == null ? "selectHour".tr() : "${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}",
                                                                                    style: TextStyle(color: Colors.white, fontSize: 14),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),

                                                                        /// DatePicker للنهاية
                                                                        SizedBox(
                                                                            height:
                                                                                8),
                                                                        Container(
                                                                          padding:
                                                                              EdgeInsets.symmetric(vertical: 10),
                                                                          decoration: BoxDecoration(
                                                                              color:
                                                                                  Colors.white,
                                                                              borderRadius: BorderRadius.circular(15),
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  color: Colors.grey.shade300,
                                                                                  offset: Offset(0.0, 2.0),
                                                                                  blurRadius: 2.0, // Specify the blur radius
                                                                                )
                                                                              ]),
                                                                          height:
                                                                              120,
                                                                          child:
                                                                              DatePicker(
                                                                            DateTime
                                                                                .now(),
                                                                            initialSelectedDate:
                                                                                endDate1 ?? DateTime.now(),
                                                                            selectionColor:
                                                                                Colors.black,
                                                                            selectedTextColor:
                                                                                Colors.white,
                                                                            onDateChange:
                                                                                (date) {
                                                                              state(() {
                                                                                endDate1 = date;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),

                                                                        SizedBox(
                                                                            height:
                                                                                12),
                                                                        if (startDate1 !=
                                                                                null &&
                                                                            endDate1 !=
                                                                                null)
                                                                          Container(
                                                                            padding: const EdgeInsets
                                                                                .all(
                                                                                12),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color:
                                                                                  Colors.green.withOpacity(0.1),
                                                                              borderRadius:
                                                                                  BorderRadius.circular(12),
                                                                              border:
                                                                                  Border.all(color: Colors.green, width: 1),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Icon(Icons.calendar_today, size: 18, color: Colors.green),
                                                                                    SizedBox(width: 8),
                                                                                    Text(
                                                                                      "Start: ${DateFormat('dd/MM/yyyy').format(startDate1!)} "
                                                                                      "at ${startTime?.hour.toString().padLeft(2, '0') ?? ""}:${startTime?.minute.toString().padLeft(2, '0') ?? ""}",
                                                                                      style: TextStyle(color: Colors.green[800], fontSize: 14, fontWeight: FontWeight.w600),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 6),
                                                                                Row(
                                                                                  children: [
                                                                                    Icon(Icons.calendar_today_outlined, size: 18, color: Colors.green),
                                                                                    SizedBox(width: 8),
                                                                                    Text(
                                                                                      "End:   ${DateFormat('dd/MM/yyyy').format(endDate1!)} "
                                                                                      "at ${endTime?.hour.toString().padLeft(2, '0') ?? ""}:${endTime?.minute.toString().padLeft(2, '0') ?? ""}",
                                                                                      style: TextStyle(color: Colors.green[800], fontSize: 14, fontWeight: FontWeight.w600),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                      ],
                                                                    ),
                                                                    SizedBox(height: 30,),
                                                                    Consumer<CustomerServiceProvider>(builder: (context, model, _) {
                                                                      return model.loading?
                                                                      Center(
                                                                        child: CircularProgressIndicator(),
                                                                      ):Container(
                                                                        width: MediaQuery.of(context).size.width,
                                                                        height: 45,
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.red,
                                                                          borderRadius: BorderRadius.circular(12),
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          onTap: () {
                                                                            print(startTime);
                                                                            print(startDate1);
                                                                            if (startDate1 == null) {
                                                                              failedSnack(context, "please_select_start_date".tr());
                                                                            } else if (endDate1 == null) {
                                                                              failedSnack(context, "please_select_end_date".tr());
                                                                            } else if (startTime == null) {
                                                                              failedSnack(context, "please_select_start_time".tr());
                                                                            } else if (endTime == null) {
                                                                              failedSnack(context, "please_select_end_time".tr());
                                                                            } else {
                                                                              model.sendTimeOfService(context, body: {
                                                                                "Id": list[index]?.id,
                                                                                "DateFrom": "${startDate1!.year.toString().padLeft(4, '0')}-${startDate1!.month.toString().padLeft(2, '0')}-${startDate1!.day.toString().padLeft(2, '0')}T${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}:00",
                                                                                "DateTo": "${endDate1!.year.toString().padLeft(4, '0')}-${endDate1!.month.toString().padLeft(2, '0')}-${endDate1!.day.toString().padLeft(2, '0')}T${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}:00",
                                                                                "isApprove":false
                                                                              }).then((value) {
                                                                                Navigator.pop(context);
                                                                                Provider.of<ServicesProvider>(context, listen: false).getAllMyServices(context);
                                                                              });
                                                                            }
                                                                          },
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              "sendRequest".tr(),
                                                                              style:
                                                                                  TextStyle(color: Colors.white, fontSize: 16),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                                                                                                    ],),
                                                                  ),
                                                            );
                                                          });
                                                    },
                                                    child: Container(
                                                        height: 30,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Declined".tr(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: CustomTextStyle
                                                                .bold14black
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        )),
                                                  ))
                                                ])
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                    if (isFinished)
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () {
                                            rating = null;
                                            selectedModel = null;
                                            TextEditingController complmentController = TextEditingController();
                                            showDialog(
                                              context: context,
                                              builder: (dialogContext) =>
                                                  Dialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          StatefulBuilder(
                                                            builder: (context,
                                                                    setState) =>
                                                                Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(
                                                                            24),
                                                                        color:
                                                                            white),
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsetsDirectional
                                                                          .only(
                                                                          start:
                                                                              16,
                                                                          end:
                                                                              16,
                                                                          top:
                                                                              20,
                                                                          bottom:
                                                                              20),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Text(
                                                                            "rate_your_request".tr(),
                                                                            style: CustomTextStyle.bold14black,
                                                                            textAlign: TextAlign.center,
                                                                          ),
                                                                          const SizedBox(
                                                                            height: 10,
                                                                          ),
                                                                          Center(
                                                                            child: EmojiFeedback(
                                                                              inactiveElementScale: .5,
                                                                              rating: rating,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  rating = value;
                                                                                });

                                                                                try {
                                                                                  selectedModel = classicEmojiPresetCustom[value! - 1];
                                                                                  print("rate ${rating} index ${selectedModel?.id}");
                                                                                } catch (e) {
                                                                                  print("errrrorrrrr ${e.toString()}");
                                                                                }
                                                                              },
                                                                              maxRating: 100,
                                                                              emojiPreset: classicEmojiPresetCustom,
                                                                            ),
                                                                          ),
                                                                          rating==3?
                                                                          textFormField(
                                                                              "Complaint_Description".tr(),
                                                                              complmentController,
                                                                              Icon(
                                                                                Icons.add_chart,
                                                                                color: Theme.of(context).primaryColor,
                                                                              ),
                                                                              autoFoucs: true,
                                                                              maxLines: 5,
                                                                              validation: (value) => Validator.defaultValidator(value)):SizedBox(),
                                                                          // EmojiFeedback(
                                                                          //   rating:
                                                                          //       rating, // Set to null (default) for no initial rating
                                                                          //   animDuration:
                                                                          //       const Duration(milliseconds: 300), // Duration of the animation
                                                                          //   curve:
                                                                          //       Curves.bounceIn, // Curve of the animation
                                                                          //   inactiveElementScale:
                                                                          //       .5, // Scale of the inactive element
                                                                          //   onChanged:
                                                                          //       (value) {
                                                                          //     setState(() {
                                                                          //       rating = value;
                                                                          //     });
                                                                          //     // Callback when the user change the value of the emoji
                                                                          //   },
                                                                          //   //  onChangeWaitForAnimation: true, // Wait for the animation of the emoji to complete before calling `#onChanged`
                                                                          //   // Other parameters
                                                                          // ),
                                                                          const SizedBox(
                                                                            height: 24,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              InkWell(
                                                                                onTap: () => Navigator.pop(context),
                                                                                child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  padding: const EdgeInsets.all(15),
                                                                                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(9)),
                                                                                  child: Text(
                                                                                    "no".tr(),
                                                                                    style: CustomTextStyle.medium10Gray.copyWith(color: white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  if (selectedModel == null) {
                                                                                    failedSnack(context, "enter_rate");
                                                                                  } else {
                                                                                    list[index].rateId = selectedModel?.id;
                                                                                    list[index].rate = selectedModel?.label;
                                                                                    list[index].complaint=complmentController.text;
                                                                                    if( list[index].rateId ==3&& complmentController.text.isEmpty){
                                                                                      failedSnack(context, "please_enter_compliant");
                                                                                    }else {
                                                                                      Provider.of<ServicesProvider>(context, listen: false).RateServiceRequestFun(
                                                                                        context,
                                                                                        servicesModel: list[index],
                                                                                      );
                                                                                      Navigator.pop(context);
                                                                                    }
                                                                                  }
                                                                                },
                                                                                child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  padding: const EdgeInsetsDirectional.only(top: 6, bottom: 6),
                                                                                  decoration: BoxDecoration(
                                                                                      // color: Theme.of(context).accentColor,
                                                                                      borderRadius: BorderRadius.circular(9)),
                                                                                  child: Text(
                                                                                    "yes".tr(),
                                                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          //  color: CREAM
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          //   child: StarRatingWidget(rating: 2),
                                          child: rateLabelFun(index: index) ==
                                                  null
                                              ? Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      border: Border.all(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                                  child: Text(
                                                    'enter_rate'.tr(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${rateLabelFun(index: index)}",
                                                      style: CustomTextStyle
                                                          .bold18black
                                                          .copyWith(
                                                              color: YELLOW,
                                                              fontSize: 14),
                                                    ),
                                                    if (getSrcByEmojiName(
                                                            rateLabelFun(
                                                                index:
                                                                    index)) !=
                                                        null) ...[
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      SvgPicture.asset(
                                                        getSrcByEmojiName(
                                                            rateLabelFun(
                                                                index: index))!,
                                                        width: 20,
                                                      )
                                                    ]
                                                  ],
                                                ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )));
              },
              separatorBuilder: (context, index) => 2.height,
              itemCount: list.length),
        );
}

class StarRatingWidget extends StatelessWidget {
  final int rating; // Number of filled stars
  final int totalStars; // Total number of stars

  StarRatingWidget({required this.rating, this.totalStars = 5});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalStars,
        (index) => Icon(
          index < rating
              ? Icons.star
              : Icons.star_border, // Filled or empty star
          color: Colors.amber,
          size: 15.0,
        ),
      ),
    );
  }
}
