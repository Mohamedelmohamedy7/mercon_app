class UserInfoModel {
  String? id;
  String? accessToken;
  String? refreshToken;
  String? expiresIn;
  String? name;
  String? method;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  double? walletBalance;
  double? loyaltyPoint;
  String? ownerUserId;
  bool? isBlocked;
  bool? isApprove;
  String? roleType;
  String? profileImagePath;

  UserInfoModel({
    this.id,
    this.name,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
    this.profileImagePath,
    this.method,
    this.fName,
    this.lName,
    this.phone,
    this.image,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.walletBalance,
    this.loyaltyPoint,
    this.ownerUserId,
    this.isBlocked,
    this.roleType,
    this.isApprove,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['data']['userData']['id'].toString();
    refreshToken = json['data']['refreshToken'];
    accessToken = json['data']['accessToken'];
    refreshToken = json['data']['refreshToken'];
    name = json['data']['userData']['name'];
    profileImagePath = json['data']['userData']['profileImagePath'];
    method = json['data']['userData']['method'];
    fName = json['data']['userData']['name'];
    lName = json['data']['userData']['l_name'];
    phone = json['data']['userData']['phone'];
    image = json['data']['userData']['imagePath'];
    email = json['data']['userData']['email'];
    emailVerifiedAt = json['data']['userData']['email_verified_at'];
    isBlocked = json['data']['userData']['isBlocked'];
    isApprove = json['data']['userData']['isApproved'];
    createdAt = json['data']['userData']['created_at'];
    updatedAt = json['data']['userData']['updated_at'];
    ownerUserId = json['data']['ownerUserId'].toString();
    walletBalance = json['wallet_balance']?.toDouble();
    loyaltyPoint = json['loyalty_point']?.toDouble();
    if (json["data"]?.containsKey("roleType") ?? false) {
      final role = json["data"]['roleType'];
      roleType = role == null || role.isEmpty
          ? ""
          : role is Map
          ? role["name"].toString()
          : role[0].toString();
    }

    if (json["data"]?['userData']?.containsKey("userType") ?? false) {
      roleType = json['data']['userData']['userType'] ?? "";
    }











    // roleType = json['roleType'] == null || json['roleType'].isEmpty
    //     ? ""
    //     : json['roleType'] is Map
    //         ? json['roleType']["name"].toString()
    //         : json['roleType'][0].toString();
  }
}

class Owner {
  String? message;
  OwnerData? data;

  Owner({this.message, this.data});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      message: json['message'],
      data: json['data'] != null ? OwnerData.fromJson(json['data']) : null,
    );
  }
}

class OwnerData {
  bool? isActive;
  String? fullNameAr;
  String? fullNameEn;
  String? profileImagePath;
  String? imageNationalIdFrontURL;
  String? imageNationalIdBackURL;
  String? address;
  bool? isDeleted;
  bool? isConfirmed;
  String? createdDate;
  String? password;
  String? roleName;
  bool? isBlocked;
  bool? isApproved;
  String? unitOwnerTypeId;
  String? primaryOwnerId;
  String? primaryOwner;
  String? id;
  String? userName;
  String? normalizedUserName;
  String? email;
  String? normalizedEmail;
  bool? emailConfirmed;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;
  String? phoneNumber;
  bool? phoneNumberConfirmed;
  bool? twoFactorEnabled;
  String? lockoutEnd;
  bool? lockoutEnabled;
  int? accessFailedCount;
  int? compID;
  OwnerData({
    this.isActive,
    this.fullNameAr,
    this.fullNameEn,
    this.profileImagePath,
    this.imageNationalIdFrontURL,
    this.imageNationalIdBackURL,
    this.address,
    this.isDeleted,
    this.isConfirmed,
    this.createdDate,
    this.password,
    this.roleName,
    this.isBlocked,
    this.isApproved,
    this.unitOwnerTypeId,
    this.primaryOwnerId,
    this.primaryOwner,
    this.id,
    this.userName,
    this.normalizedUserName,
    this.email,
    this.normalizedEmail,
    this.emailConfirmed,
    this.passwordHash,
    this.securityStamp,
    this.concurrencyStamp,
    this.phoneNumber,
    this.phoneNumberConfirmed,
    this.twoFactorEnabled,
    this.lockoutEnd,
    this.lockoutEnabled,
    this.accessFailedCount,
    this.compID,
  });

  factory OwnerData.fromJson(Map<String, dynamic> json) {
    return OwnerData(
      isActive: json['isActive'],
      fullNameAr: json['fullNameAr'],
      fullNameEn: json['fullNameEn'],
      profileImagePath: json['profileImagePath'],
      imageNationalIdFrontURL: json['imageNationalIdFrontURL'],
      imageNationalIdBackURL: json['imageNationalIdBackURL'],
      address: json['address'],
      isDeleted: json['isDeleted'],
      isConfirmed: json['isConfirmed'],
      createdDate: json['createdDate'],
      password: json['password'],
      roleName: json['roleName'],
      isBlocked: json['isBlocked'],
      isApproved: json['isApproved'],
      unitOwnerTypeId: json['unitOwnerTypeId'].toString(),
      primaryOwnerId: json['primaryOwnerId'],
      primaryOwner: json['primaryOwner'],
      id: json['id'],
      userName: json['userName'],
      normalizedUserName: json['normalizedUserName'],
      email: json['email'],
      normalizedEmail: json['normalizedEmail'],
      emailConfirmed: json['emailConfirmed'],
      passwordHash: json['passwordHash'],
      securityStamp: json['securityStamp'],
      concurrencyStamp: json['concurrencyStamp'],
      phoneNumber: json['phoneNumber'],
      phoneNumberConfirmed: json['phoneNumberConfirmed'],
      twoFactorEnabled: json['twoFactorEnabled'],
      lockoutEnd: json['lockoutEnd'],
      lockoutEnabled: json['lockoutEnabled'],
      accessFailedCount: json['accessFailedCount'],
      compID: json['compID'],
    );
  }
}
