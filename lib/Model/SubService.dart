import 'dart:convert';

List<SubService> parseSubServiceList(String src) => List<SubService>.from(json.decode(src)["data"].map<SubService>((json) => SubService.fromJson(json)));

class SubService {
  int id;
  double price;
  int serviceTypeId;
  String subServicesName;
  String? serviceType;
  String? serviceTypeDTO;
  double emergencyServicePrice;
  double? vatRate;
  double? totalPrice;
  double servicePriceAfterTax;
  double? emergencyServicePriceAfterTax;
  bool? isCheck;

  SubService({
    required this.id,
    required this.price,
    required this.serviceTypeId,
    required this.subServicesName,
    this.serviceType,
    this.serviceTypeDTO,
    required this.emergencyServicePrice,
    this.vatRate,
    this.totalPrice,
    required this.servicePriceAfterTax,
    this.emergencyServicePriceAfterTax,
    this.isCheck,
  });

  // Factory method to create a SubService from JSON
  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      id: json['id'],
      price: json['price']==null?0.0:json['price'].toDouble()?? 0.0,
      serviceTypeId: json['serviceTypeId'],
      subServicesName: json['subServicesName'],
      serviceType: json['serviceType'],
      serviceTypeDTO: json['serviceTypeDTO'],
      emergencyServicePrice: json['emergencyServicePrice']==null?0.0:json['emergencyServicePrice'].toDouble()?? 0.0,
      vatRate: json['vatRate']==null?0.0:json['vatRate'].toDouble()?? 0.0,
      totalPrice: json['totalPrice']==null?0.0:json['totalPrice'].toDouble()?? 0.0,
      servicePriceAfterTax: json['servicePriceAfterTax']==null?0.0:json['servicePriceAfterTax'].toDouble()?? 0.0,
      emergencyServicePriceAfterTax: json['emergencyServicePriceAfterTax']==null?0.0:json['emergencyServicePriceAfterTax'].toDouble()?? 0.0,
      isCheck: false,
    );
  }

  // Method to convert a SubService to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'serviceTypeId': serviceTypeId,
      'subServicesName': subServicesName,
      'serviceType': serviceType,
      'serviceTypeDTO': serviceTypeDTO,
      'emergencyServicePrice': emergencyServicePrice,
      'vatRate': vatRate,
      'totalPrice': totalPrice,
      'servicePriceAfterTax': servicePriceAfterTax,
      'emergencyServicePriceAfterTax': emergencyServicePriceAfterTax,
    };
  }
}
