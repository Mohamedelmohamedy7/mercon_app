import 'dart:convert';

List<OwnerPayment> parseOwnerPayment(String src) =>
    List<OwnerPayment>.from(json.decode(src)["data"].map<OwnerPayment>((json) => OwnerPayment.fromJson(json)));

class OwnerPaymentList {
  final String message;
  final List<OwnerPayment> data;

  OwnerPaymentList({
    required this.message,
    required this.data,
  });

  factory OwnerPaymentList.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<OwnerPayment> payments = dataList.map((payment) => OwnerPayment.fromJson(payment)).toList();

    return OwnerPaymentList(
      message: json['message'],
      data: payments,
    );
  }
}
class OwnerPayment {
  final int id;
  final String year;
  final int value;
  final String unitName;
  final int unitNumber;
  final String paymentStatus;

  OwnerPayment({
    required this.id,
    required this.year,
    required this.value,
    required this.unitName,
    required this.unitNumber,
    required this.paymentStatus,
  });

  factory OwnerPayment.fromJson(Map<String, dynamic> json) {
    return OwnerPayment(
      id: json['id'],
      year: json['year'],
      value: json['value'],
      unitName: json['unitName'],
      unitNumber: json['unitNumber'],
      paymentStatus: json['paymentStatus'],
    );
  }
}


