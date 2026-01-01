import 'dart:convert';


 List<UnitPayments> unitPaymentsList(String src) {
  List<dynamic> data = json.decode(src)["data"];
  List<UnitPayments> unitPayments = data.map((unitPayment) => UnitPayments.fromJson(unitPayment)).toList();
  return unitPayments;
}
class UnitPayments {
  final int unitId;
  final String? unitName;
  final double?  paidDone;
  final double? notPaid;
  final List<OwnerPayment> ownerPayments;

  UnitPayments({
    required this.unitId,
    this.unitName,
    required this.paidDone,
    required this.notPaid,
    required this.ownerPayments,
  });

  factory UnitPayments.fromJson(Map<String, dynamic> json) {
    var ownerPaymentsList = json['ownerPayments'] as List;
    List<OwnerPayment> ownerPayments =
    ownerPaymentsList.map((e) => OwnerPayment.fromJson(e)).toList();

    return UnitPayments(
      unitId: json['unitId'],
      unitName: json['unitName'],
      paidDone: double.tryParse(json['paidDone'].toString()) ,
      notPaid:double.tryParse(json['notPaid'].toString()) ,
      ownerPayments: ownerPayments,
    );
  }
}
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
  final DateTime date;
  final String value;
  final bool isPaid;
  final int typeId;
  final String paymentType;
  final DateTime createdDate;
  final String unitName;
  final String description;

  OwnerPayment({
    required this.id,
    required this.date,
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
      date: DateTime.parse(json['date']??json['createdDate']),
      value: json['value'].toString(),
      isPaid: json['isPaid'],
      typeId: json['typeId'],
      paymentType: json['paymentType'],
      createdDate: DateTime.parse(json['createdDate']),
      unitName: json['unitName'],
      description: json['description']??"",
    );
  }
}


