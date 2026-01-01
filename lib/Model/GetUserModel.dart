class GetUserModel {
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  int? unitModelID;
  int? buildingID;
  int? roundID;
  int? unitID;
String?ownershipContract;
  GetUserModel(
      {this.name,
        this.email,
        this.phoneNumber,
        this.address,
        this.unitModelID,
        this.buildingID,
        this.roundID,
        this.unitID,this.ownershipContract});

  GetUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    unitModelID = json['unitModelID'];
    buildingID = json['buildingID'];
    roundID = json['roundID'];
    unitID = json['unitID'];
    ownershipContract=json['ownershipContract'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['unitModelID'] = this.unitModelID;
    data['buildingID'] = this.buildingID;
    data['roundID'] = this.roundID;
    data['unitID'] = this.unitID;
    data['ownershipContract']=this.ownershipContract;
    return data;
  }
}