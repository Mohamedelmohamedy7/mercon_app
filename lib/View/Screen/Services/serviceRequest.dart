import 'package:core_project/Model/ServicesComponantModel.dart';
import 'package:core_project/Model/UnitModel.dart';
import 'package:core_project/Provider/ServicesProvider.dart';
import 'package:core_project/Provider/UnitsProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/LoaderWidget/loader_widget.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/helper/EnumLoading.dart';
import 'package:core_project/helper/Route_Manager.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:provider/provider.dart';
import '../../../Model/ALLModelModel.dart';
import '../../../Model/BuildingModel.dart';
import '../../../Model/LevelModel.dart';
import '../../../Model/SubService.dart';
import '../../../Utill/AnimationWidget.dart';
import '../../../Utill/validator.dart';
import '../../../helper/ButtonAction.dart';
import '../../../helper/ImagesConstant.dart';
import '../../../helper/SnackBarScreen.dart';
import '../../../helper/color_resources.dart';
import '../../Widget/DropDownWidgets.dart';
import '../../Widget/comman/CustomAppBar.dart';
import '../../Widget/comman/comman_Image.dart';

class ServiceRequest extends StatefulWidget {
  ServicesModel? servicesModel;
  bool? isOther;
  ServiceRequest({super.key, this.servicesModel, this.isOther});

  @override
  State<ServiceRequest> createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceRequest> {
  TextEditingController serviceDetails = TextEditingController();
  TextEditingController ownerName = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();
  UnitsProvider? unitsProvider;
  ALLModelModel? selectedModel;

  BuildingModel? buildingModel;
  LevelModel? levelModel;
  UnitModel? unitModel;
  List<SubService> subService = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        ownerName.text = globalAccountData.getUsername()!;
      });
      getData();
    });
    unitsProvider = Provider.of<UnitsProvider>(context, listen: false);
    unitsProvider!.getAllModel(context,
        isLogin: (
            globalAccountData.getUserType() == AppConstants.IS_SuperAdmin||
            globalAccountData.getUserType() == AppConstants.IS_FullSuperAdmin||
            globalAccountData.getUserType() ==
                AppConstants.IS_Supervisor||
            globalAccountData.getUserType() ==
                AppConstants.IS_CustomerService)
            ? false
            : true);

    super.initState();
  }

  void getData() async {
    subService = await Provider.of<ServicesProvider>(context, listen: false)
        .getSubServices(context, widget.servicesModel!.id.toString());
    setState(() {});
  }

  List<String> checkList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'clientService'.tr(),
          backgroundImage: AssetImage(ImagesConstants.backgroundImage),
        ),
        body: CustomAnimatedWidget(
          child: Container(
              width: w(context),
              height: h(context),
              // color: BACKGROUNDCOLOR.withOpacity(0.7),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 10.height,
                      // Container(
                      //   width: 220,
                      //   height: 48,
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage(ImagesConstants.backGroundOrder),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      //   child: Center(
                      //       child: Text(
                      //     "serviceDetails".tr(),
                      //     style: CustomTextStyle.bold14White,
                      //   )),
                      // ),
                      17.height,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: w(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                            color: lightGray.withOpacity(0.3),
                                            shape: BoxShape.circle),
                                        child: cachedImage(
                                            widget.servicesModel?.iconURLPath ??
                                                "",
                                            width: 30,
                                            fit: BoxFit.contain,
                                            height: 30)),
                                    10.width,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context.locale ==
                                                  const Locale('en', 'US')
                                              ? widget.servicesModel?.nameAr ??
                                                  "write the details of the service"
                                              : widget.servicesModel?.nameEn ??
                                                  "اكتب تفاصيل الخدمة المطلوبة",
                                          style: const TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            getCurrentDateTime(),
                                            style:
                                                CustomTextStyle.medium10Black,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                10.height,
                                textFormField("serviceDetails", serviceDetails,
                                    textFieldSvg("details.svg"),
                                    maxLines: 4,
                                    validation: (value) =>
                                        Validator.defaultValidator(value)),
                                if (!(((
                                    globalAccountData.getUserType() == AppConstants.IS_SuperAdmin||
                                    globalAccountData.getUserType() == AppConstants.IS_FullSuperAdmin||
                                        globalAccountData.getUserType() ==
                                            AppConstants.IS_Supervisor||
                                        globalAccountData.getUserType() ==
                                            AppConstants.IS_CustomerService)))) ...[
                                  10.height,
                                  textFormField("ownerName", ownerName,
                                      textFieldSvg("owner.svg"),
                                      validation: (value) =>
                                          Validator.defaultValidator(value)),
                                ],
                                15.height,
                                subService.length > 0
                                    ? Center(
                                        child: Text(
                                          "serviceType".tr(),
                                          style: CustomTextStyle.semiBold12Black
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    : SizedBox(),
                                subService.length > 0 ? 15.height : 0.height,
                                subService.length > 0
                                    ? Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.1),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      "serviceType".tr(),
                                                      style: CustomTextStyle
                                                          .semiBold12Black
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    )),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      "servicePrice".tr(),
                                                      style: CustomTextStyle
                                                          .semiBold12Black
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      "select".tr(),
                                                      style: CustomTextStyle
                                                          .semiBold12Black
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    )),
                                              ],
                                            ),
                                            Container(
                                                child: ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: subService.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        subService[index]
                                                            .subServicesName
                                                            .toString(),
                                                        style: CustomTextStyle
                                                            .semiBold12Black
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        subService[index]
                                                                    .emergencyServicePriceAfterTax ==
                                                                0.0
                                                            ? subService[index]
                                                                    .servicePriceAfterTax
                                                                    .toString() +
                                                                " " +
                                                                "EGP".tr()
                                                            : subService[index]
                                                                    .emergencyServicePriceAfterTax
                                                                    .toString() +
                                                                " " +
                                                                "EGP".tr(),
                                                        style: CustomTextStyle
                                                            .semiBold12Black
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Checkbox(
                                                          value:
                                                              subService[index]
                                                                  .isCheck,
                                                          onChanged: (value) {
                                                            if (checkList.contains(
                                                                subService[
                                                                        index]
                                                                    .id
                                                                    .toString())) {
                                                              checkList.remove(
                                                                  subService[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                              subService[index]
                                                                      .isCheck =
                                                                  value;
                                                              setState(() {});
                                                            } else {
                                                              checkList.add(
                                                                  subService[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                              subService[index]
                                                                      .isCheck =
                                                                  value;
                                                              setState(() {});
                                                            }
                                                            print(checkList);
                                                          }),
                                                    )
                                                  ],
                                                );
                                              },
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(height: 5);
                                              },
                                            )),
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                                5.height,
                                ModelSelectionDropdowns(
                                  selectedModel: selectedModel,
                                  buildingModel: buildingModel,
                                  levelModel: levelModel,
                                  unitModel: unitModel,
                                  onSelectModel: (value) {
                                    setState(() {
                                      selectedModel = value;
                                      buildingModel = null;
                                      levelModel = null;
                                      unitModel = null;
                                    });
                                    unitsProvider?.getAllBuilding(
                                        context, selectedModel!.id.toString(),
                                        isLogin:
                                        (
                                            globalAccountData.getUserType() == AppConstants.IS_SuperAdmin||
                                            globalAccountData.getUserType() == AppConstants.IS_FullSuperAdmin||
                                            globalAccountData.getUserType() ==
                                                AppConstants.IS_Supervisor||
                                            globalAccountData.getUserType() ==
                                                AppConstants.IS_CustomerService)
                                                ? false
                                                : true);
                                  },
                                  onSelectBuilding: (value) {
                                    setState(() {
                                      buildingModel = value;
                                      levelModel = null;
                                      unitModel = null;
                                    });
                                    unitsProvider?.getAllLevel(
                                        context, buildingModel!.id.toString(),
                                        isLogin:
                                        (
                                            globalAccountData.getUserType() == AppConstants.IS_SuperAdmin||
                                            globalAccountData.getUserType() == AppConstants.IS_FullSuperAdmin||
                                            globalAccountData.getUserType() ==
                                                AppConstants.IS_Supervisor||
                                            globalAccountData.getUserType() ==
                                                AppConstants.IS_CustomerService)
                                                ? false
                                                : true);
                                  },
                                  onSelectLevel: (value) {
                                    setState(() {
                                      levelModel = value;
                                      unitModel = null;
                                    });
                                    unitsProvider?.getUnitModel(
                                        context, levelModel!.id.toString(),
                                        isLogin:
                                        (
                                            globalAccountData.getUserType() == AppConstants.IS_SuperAdmin||
                                            globalAccountData.getUserType() == AppConstants.IS_FullSuperAdmin||
                                            globalAccountData.getUserType() ==
                                                AppConstants.IS_Supervisor||
                                            globalAccountData.getUserType() ==
                                                AppConstants.IS_CustomerService)
                                                ? false
                                                : true);
                                  },
                                  onSelectUnits: (value) {
                                    setState(() {
                                      unitModel = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      90.height,
                    ]),
              )),
        ),
        bottomSheet: Provider.of<ServicesProvider>(context)
                .sendServiceRequestLoading
            ? Container(height: 55, child: Loading())
            : Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: widgetWithAction.buttonAction<ServicesProvider>(
                    action: (model) {
                      print("${checkList.isEmpty&&widget.isOther == false}::::::<<:<:<<<:");
                      print("${checkList.isEmpty}::::::<<:<:<<<:");
                      print("${widget.isOther}::::::<<:<:<<<:");
                      print(widget.isOther == true);
                      if (selectedModel == null) {
                        showAwesomeSnackbar(
                          context,
                          'Error!',
                          '${"selectModel".tr()}',
                          contentType: ContentType.failure,
                        );
                      }
                      else if (buildingModel == null) {
                        showAwesomeSnackbar(
                          context,
                          'Error!',
                          '${"please_select_building".tr()}',
                          contentType: ContentType.failure,
                        );
                      }
                      else if (levelModel == null) {
                        showAwesomeSnackbar(
                          context,
                          'Error!',
                          '${"please_select_level".tr()}',
                          contentType: ContentType.failure,
                        );
                      }
                      else if (unitModel == null) {
                        showAwesomeSnackbar(
                          context,
                          'Error!',
                          '${"selectUnit".tr()}',
                          contentType: ContentType.failure,
                        );
                      }
                      else if (checkList.isEmpty&&(widget.isOther == false||
                      widget.isOther==null))  {
                        showAwesomeSnackbar(
                          context,
                          'Error!',
                          '${"pleaseSelectServiceType".tr()}',
                          contentType: ContentType.failure,
                        );
                      }
                      else if (_formKey.currentState!.validate()) {
                        if (widget.isOther == true) {
                          model
                              .sendServiceRequest(context,
                                  serviceDetails: serviceDetails.text,
                                  ownerName: ownerName.text,
                                  unitNumber: unitModel!.id.toString(),
                                  unitModel: selectedModel!.id.toString(),
                                  // subServiceIds: subService.map((e) => e.id.toString()).toList(),
                                  subServiceIds: checkList,
                                  serviceTypeId:
                                      widget.servicesModel?.id.toString() ?? "",
                                  isOther: true)
                              .then((value) {
                            if (value != null) {
                              if(value.toString().contains("تقديم")){
                                showAwesomeSnackbar(
                                  context,
                                  'Failed',
                                  '${value}',
                                  contentType: ContentType.failure,
                                );
                              }else {
                                pushNamedAndRemoveUntilRoute(
                                  context: context,
                                  route: (globalAccountData.getUserType() ==
                                      AppConstants.IS_SuperAdmin ||globalAccountData.getUserType() ==
                                      AppConstants.IS_FullSuperAdmin ||
                                      globalAccountData.getUserType() ==
                                          AppConstants.IS_Supervisor ||
                                      globalAccountData.getUserType() ==
                                          AppConstants.IS_CustomerService)
                                      ? Routes.dashBoardAdmin
                                      : Routes.dashBoard,
                                );
                                showAwesomeSnackbar(
                                  context,
                                  'Success',
                                  '${value}',
                                  contentType: ContentType.success,
                                );
                              }
                            }
                          });
                        } else {
                          model
                              .sendServiceRequest(context,
                                  serviceDetails: serviceDetails.text,
                                  ownerName: ownerName.text.isNotEmpty?ownerName.text:null,
                                  unitNumber: unitModel!.id.toString(),
                                  // subServiceIds: subService
                                  //     .map((e) => e.id.toString())
                                  //     .toList(),
                                  subServiceIds: checkList,
                                  unitModel: selectedModel!.id.toString(),
                                  serviceTypeId:
                                      widget.servicesModel?.id.toString() ?? "",
                                  isOther: false)
                              .then((value) {
                            if (value != null) {
                              pushNamedAndRemoveUntilRoute(
                                context: context,
                                route:(
                                    globalAccountData.getUserType() == AppConstants.IS_SuperAdmin||
                                    globalAccountData.getUserType() == AppConstants.IS_FullSuperAdmin||
                                    globalAccountData.getUserType() ==
                                        AppConstants.IS_Supervisor||
                                    globalAccountData.getUserType() ==
                                        AppConstants.IS_CustomerService)
                                    ? Routes.dashBoardAdmin
                                    : Routes.dashBoard,
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
                      }
                    },
                    context: context,
                    text: "sendRequest"),
              ),
      ),
    );
  }

  String getCurrentDateTime() {
    var now = DateTime.now();
    var formattedDate = context.locale == const Locale('en', 'US')
        ? DateFormat.yMMMMd('en_US').format(now)
        : DateFormat.yMMMMd('ar_EG').format(now);
    var formattedTime = DateFormat.Hm().format(now);
    return '${"timeAndDateOfService".tr()}: $formattedDate $formattedTime';
  }
}
