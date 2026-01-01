class PaymentModel {
  String? message;
  List<Payment>? data;

  PaymentModel({this.message, this.data});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Payment>[];
      json['data'].forEach((v) {
        data!.add(new Payment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payment {
  int? id;
  double? value;
  bool? isPaid;
  int? typeId;
  String? paymentType;
  DateTime? createdDate;
  String? unitName;
  String? description;

  Payment(
      {this.id,
      this.value,
      this.isPaid,
      this.typeId,
      this.paymentType,
      this.createdDate,
      this.unitName,
      this.description});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = double.tryParse(json['value'].toString());
    isPaid = json['isPaid'];
    typeId = json['typeId'];
    paymentType = json['paymentType'];
    createdDate = DateTime.tryParse(json['createdDate']);
    unitName = json['unitName'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['isPaid'] = this.isPaid;
    data['typeId'] = this.typeId;
    data['paymentType'] = this.paymentType;
    data['createdDate'] = this.createdDate;
    data['unitName'] = this.unitName;
    data['description'] = this.description;
    return data;
  }
}
