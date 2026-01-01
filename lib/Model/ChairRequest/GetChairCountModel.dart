class GetChairCountModel {
  String? message;
  GetChairCount? data;

  GetChairCountModel({this.message, this.data});

  GetChairCountModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data =
        json['data'] != null ? new GetChairCount.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetChairCount {
  int? chairsCount;

  GetChairCount({this.chairsCount});

  GetChairCount.fromJson(Map<String, dynamic> json) {
    chairsCount = json['chairsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chairsCount'] = this.chairsCount;
    return data;
  }
}
