// ignore: file_names
class  UserModel {
  bool? status;
  var message;
  Users? data;

   UserModel({this.status, this.message, this.data});

   UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Users.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Users {
  var  id;
  var full_name;
  var lastName;
  var email;
  var phone;
  var dateBirth;
  var city;
  var zipCode;
  var lat;
  var lang;
  var homeNumber;
  var street;
  var area;
  var bloc;
  var address;
  var cityId;
  var civilId;
  var cityCost;

  Users(
      {this.id,
        this.full_name,
        this.lastName,
        this.email,
        this.phone,
        this.dateBirth,
        this.city,
        this.cityId,
        this.zipCode,
        this.lat,
        this.lang,


        this.homeNumber,
         this.address,
        this.civilId,
        this.street,
        this.bloc,
        this.area,
        this.cityCost
      });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    full_name = json['full_name'];
    // lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    civilId = json['civil_id'];
    city = json['city'];
    zipCode = json['zip_code'];
    lat = json['lat'];
    lang = json['lang'];
    homeNumber = json['home_number'];
    address=json["address"];
    area = json['area'];
    street = json['street'];
    bloc= json['block'];
    cityId= json['city_id'];
    cityCost= json['city_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['full_name'] = full_name;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['date_birth'] = dateBirth;
    data['city'] = city;
    data['zip_code'] = zipCode;
    data['lat'] = lat;
    data['lang'] = lang;
    data['home_number'] = homeNumber;
    data['address'] = address;
    data['civil_id'] = civilId;
    data['area'] = this.area;
    data['street'] = this.street;
    data['block'] = this.bloc;
    data['city_id'] = this.cityId;
    data['city_cost'] = this.cityCost;

    return data;
  }
}