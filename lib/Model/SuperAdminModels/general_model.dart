class GeneralModel {
  String? message;
  String? data;

  GeneralModel({this.message, this.data});

  GeneralModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}