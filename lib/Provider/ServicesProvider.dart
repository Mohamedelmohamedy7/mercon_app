import 'dart:convert';
import 'package:core_project/Model/SuperAdminModels/get_all_service_rate_model.dart';
import 'package:flutter/material.dart';
import '../Model/PaymentModel.dart';
import '../Model/ServicesComponantModel.dart';
import '../Model/ServicesComponantModel/MyServicesModel.dart';
import '../Model/SubService.dart';
import '../Services/RequestFile.dart';
import '../Services/RestApi.dart';
import '../Utill/Local_User_Data.dart';
import '../helper/EnumLoading.dart';
import '../helper/app_constants.dart';

class ServicesProvider extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.SUCCESS;
  List<ServicesModel> services = [];
  List<ServiceRequest> servicesRequestProccessing = [];
  List<ServiceRequest> servicesRequestFinished = [];
  List<ServiceRequest> servicesRequestRequested = [];
  List<ServiceRequest> servicesRequestCancelled = [];

  List<SubService> subService = [];

  Future<void> getAllMyServices(context) async {
    if (!loading) {
      startLoader();
    }
    servicesRequestProccessing.clear();
    servicesRequestRequested.clear();
    servicesRequestFinished.clear();
    final res = await getFunctionRestApi(context,
        urlEndPoint: GET_ALL_SERVICE_REQUEST +
            "?UserId=" +
            globalAccountData.getId().toString());
    for (ServiceRequest service in ServiceRequestFromJson(res)) {
      if (service.statusID.toString() == "3"||service.statusID.toString() == "4"
          ||service.statusID.toString() == "5") {
        servicesRequestFinished.add(service);
      } else if (service.statusID.toString() == "2") {
        servicesRequestProccessing.add(service);
      } else {
        servicesRequestRequested.add(service);
      }

      /// TODO ADD servicesRequestCancelled
    }
    S_finishLoader();
    return;
  }

  Future<void> getAllServices(context) async {
    services.clear();
    startLoader();
    final res =
        await getFunctionRestApi(context, urlEndPoint: GET_ALL_SERVICES);
    for (ServicesModel service in parseServiceList(res)) {
      services.add(service);
    }
    S_finishLoader();
    return;
  }

  Future<List<SubService>> getSubServices(context, String id) async {
    subService.clear();
    startLoader();
    final res = await getFunctionRestApi(context,
        urlEndPoint: GET_SUB_SERVICE_BY_ID + id);
    for (SubService service in parseSubServiceList(res)) {
      subService.add(service);
    }
    S_finishLoader();
    return subService;
  }

  List<UnitPayment> paymentList = [];

  int isPaidCost = 0;
  void addingPaidCost(int cost) {
    isPaidCost = isPaidCost + cost;
    notifyListeners();
  }

  int isNotPaidCost = 0;
  void addingNotPaidCost(int cost) {
    isNotPaidCost = isNotPaidCost + cost;
    notifyListeners();
  }

  Future<void> getAllPayments(context) async {
    paymentList.clear();
    startLoader();
    final res = await getFunctionRestApi(context,
        urlEndPoint:
            GET_ALL_OWNER_PAYMENT + globalAccountData.getId().toString());

    for (UnitPayment payment in parsePaymentModel(res)) {
      paymentList.add(payment);
    }

    S_finishLoader();
    return;
  }

  bool sendServiceRequestLoading = false;
  Future sendServiceRequest(
    context, {
    required String serviceDetails,
    required String? ownerName,
    required List<String> subServiceIds,
    required String unitNumber,
    required String unitModel,
    required String serviceTypeId,
    required bool isOther,
  }) async {
    sendServiceRequestLoading = true;
    notifyListeners();
    print(subServiceIds
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "")
        .trim());
    final res = await postFunctionRestApi(context,
        url: ADD_SERVICE_REQUEST,
        body: jsonEncode({
          "details": serviceDetails,
          "serviceTypeId": isOther == true ? null : serviceTypeId,
          "isOther": isOther,
          "ownerName": ownerName,
          "unitID": unitNumber,
          "unitModelId": unitModel,
          "subServiceIds": subServiceIds
              .toString()
              .replaceAll("[", "")
              .replaceAll("]", "")
              .trim()
              .replaceAll("  ", "")
              .trim(),
          "userId": (globalAccountData.getId() == null
              ? ""
              : globalAccountData.getId())!,
        }),
        needContent: true);
    //  S_finishLoader();
    sendServiceRequestLoading = false;
    notifyListeners();
    return Decoding(res);
  }

  bool loadRates = false;

  List<RateModel> listRateModel = [];
  Future<void> getAllServicesRateData(context) async {
    listRateModel.clear();
    loadRates = true;
    notifyListeners();
    final res =
        await getFunctionRestApi(context, urlEndPoint: GET_ALL_SERVICE_Rates);
    for (RateModel rateModel in getAllServiceRatesModelFromJson(res)) {
      listRateModel.add(rateModel);
    }
    loadRates = false;
    notifyListeners();
    return;
  }

  bool loading = false;

  Future<void> RateServiceRequestFun(context,
      {required ServiceRequest? servicesModel}) async {
    loading = true;

    await putFunctionRestApi(context,
        url: RateServiceRequest,
        body: jsonEncode(
            {"id": servicesModel?.id, "rateId": servicesModel?.rateId,"complaint":servicesModel?.complaint??"",})

        // jsonEncode(servicesModel?.toJson())
        );
    getAllMyServices(context);
    loading = false;
    return;
  }

  void S_finishLoader() {
    status = LoadingStatus.SUCCESS;
    notifyListeners();
  }

  void startLoader() {
    status = LoadingStatus.LOADING;
    notifyListeners();
  }
}
