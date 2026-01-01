class CheckModel {
  String? message;
  int? data;
  int? data2;

  CheckModel({this.message, this.data, this.data2});

  CheckModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
    data2 = json.containsKey("data2") ? json['data2'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['data'] = this.data;
    data['data2'] = this.data2;
    return data;
  }
}
