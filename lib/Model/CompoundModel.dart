// class CompoundModel {
//   String? message;
//   CompoundData? data;
//
//   CompoundModel({this.message, this.data});
//
//   CompoundModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     data =
//         json['data'] != null ? new CompoundData.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

class CompoundData {
  String? name;
  String? addres;
  String? logo;
  String? code;
  int? id;
  String? createdDate;

  CompoundData({
    this.name,
    this.addres,
    this.logo,
    this.code,
    this.id,
    this.createdDate,
  });

  CompoundData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    addres = json['addres'];
    logo = json['logo'];
    code = json['code'];
    id = json['id'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['addres'] = this.addres;
    data['logo'] = this.logo;
    data['code'] = this.code;
    data['id'] = this.id;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
