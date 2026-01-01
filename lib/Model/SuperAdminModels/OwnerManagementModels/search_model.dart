class SearchModel {
  String name;
  String nationalId;
  String phoneNumber;
  int? pageNumber;
  int? pageSize;

  SearchModel(
      {required this.name,
      required this.nationalId,
      required this.phoneNumber,
      this.pageNumber,
      this.pageSize});

  // SearchModel.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   nationalId = json['nationalId'];
  //   phoneNumber = json['phoneNumber'];
  //   pageNumber = json['pageNumber'];
  //   pageSize = json['pageSize'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name.isNotEmpty ? this.name : null;
    data['nationalId'] = this.nationalId.isNotEmpty ? this.nationalId : null;
    data['phoneNumber'] = this.phoneNumber.isNotEmpty ? this.phoneNumber : null;
   // data['pageNumber'] = this.pageNumber;
   // data['pageSize'] = this.pageSize;
    return data;
  }
}
