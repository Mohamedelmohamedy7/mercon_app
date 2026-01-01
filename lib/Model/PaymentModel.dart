
import 'dart:convert';

List<UnitPayment> parsePaymentModel(String src) => List<UnitPayment>.from(json.decode(src)["data"].map<UnitPayment>((json) => UnitPayment.fromJson(json)));


class PaymentModel {
  String message;
  List<UnitPayment> data;

  PaymentModel({required this.message, required this.data});

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      message: json['message'],
      data: List<UnitPayment>.from(json['data'].map((x) => UnitPayment.fromJson(x))),
    );
  }
}

class UnitPayment {
  int unitId;
  String? unitName;
  List<OwnerPayment> ownerPayments;

  UnitPayment({
    required this.unitId,
    this.unitName,
    required this.ownerPayments,
  });

  factory UnitPayment.fromJson(Map<String, dynamic> json) {
    return UnitPayment(
      unitId: json['unitId'],
      unitName: json['unitName'],
      ownerPayments: List<OwnerPayment>.from(json['ownerPayments'].map((x) => OwnerPayment.fromJson(x))),
    );
  }
}

class OwnerPayment {
  int id;
  String? date;
  double? value;
  bool isPaid;
  int typeId;
  String paymentType;
  String createdDate;
  String unitName;
  String description;

  OwnerPayment({
    required this.id,
    this.date,
    required this.value,
    required this.isPaid,
    required this.typeId,
    required this.paymentType,
    required this.createdDate,
    required this.unitName,
    required this.description,
  });

  factory OwnerPayment.fromJson(Map<String, dynamic> json) {
    return OwnerPayment(
      id: json['id'],
      date: json['date'],
      value:double.tryParse(json['value'].toString()) ,
      isPaid: json['isPaid'],
      typeId: json['typeId'],
      paymentType: json['paymentType'],
      createdDate: json['createdDate'],
      unitName: json['unitName'],
      description: json['description'],
    );
  }
}
