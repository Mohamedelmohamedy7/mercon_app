import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class globalAccountData {
  static SharedPreferences? _preferences;

  static const _username = 'username';
  static const _loginInState = 'LogInState';
  static const _email = 'email';
  static const _id = 'UID';
  static const _state = 'State';
  static const _address = 'Address';
  static const _expiredTime = '_expiredTime';
  static const _refreshTime = '_refreshTime';
  static const _accessToken = '_accessToken';
  static const _contactNumber = 'contactNumber';
  static const _fingerPrint = 'fingerPrint';
  static const _currentCompound = 'currentCompound';
  static const _unitModel = 'unitModel';
  static const _unitNumber = 'unitNumber';
  static const _userType = 'userType';
  static const _ownerUserId = 'ownerUserId';
  static const _profilePic = 'profilePic';

  static const _compoundId = 'compoundId';
  static const _compoundLogo = 'compoundLogo';
  static const _compoundName = 'compoundName';

  static Future setProfilePic(String profilePic) async =>
      await _preferences?.setString(_profilePic, profilePic);
  static String? getProfilePic() => _preferences?.getString(_profilePic);

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences?.setString(_username, username);

  static String? getUsername() => _preferences?.getString(_username);

  static String? getOwnerUserId() => _preferences?.getString(_ownerUserId);

  static Future setOwnerUserId(String ownerUserId) async =>
      await _preferences?.setString(_ownerUserId, ownerUserId);

  static Future setUserType(String userType) async =>
      await _preferences?.setString(_userType, userType);

  static String? getUserType() => _preferences?.getString(_userType);

  static Future setFingerAvalible(bool fingerprint) async =>
      await _preferences?.setBool(_fingerPrint, fingerprint);
  static Future setCurrentCompound(String  currentCompound) async =>
      await _preferences?.setString(_currentCompound, currentCompound);
  static String? getCurrentCompound() => _preferences?.getString(_currentCompound);


  static bool? getFingerPrint() => _preferences?.getBool(_fingerPrint);

  static Future setUnitModel(String unitModel) async =>
      await _preferences?.setString(_unitModel, unitModel);

  static String? getUnitModel() => _preferences?.getString(_unitModel);

  static Future setUnitNumberl(String unitNumber) async =>
      await _preferences?.setString(_unitNumber, unitNumber);

  static String? getUnitNumber() => _preferences?.getString(_unitNumber);

  static Future SetExpiredTime(String expiredTime) async =>
      await _preferences?.setString(_expiredTime, expiredTime);

  static String? GetExpiredTime() => _preferences?.getString(_expiredTime);

  static Future SetRefreshToken(String refreshTime) async =>
      await _preferences?.setString(_refreshTime, refreshTime);

  static String? GetRefreshToken() => _preferences?.getString(_refreshTime);

  static Future SetAccessToken(String accessToken) async =>
      await _preferences?.setString(_accessToken, accessToken);

  static String? GetAccessToken() => _preferences?.getString(_accessToken);

  static Future setLoginInState(bool loginInState) async =>
      await _preferences?.setBool(_loginInState, loginInState);

  static bool? getLoginInState() => _preferences?.getBool(_loginInState);

  static Future setEmail(String email) async =>
      await _preferences?.setString(_email, email);

  static String? getEmail() => _preferences?.getString(_email);

  static Future setId(String id) async =>
      await _preferences?.setString(_id, id);

  static String? getId() => _preferences?.getString(_id);

  static Future setState(String state) async =>
      await _preferences?.setString(_state, state);

  static String? getState() => _preferences?.getString(_state);

  static Future setAddress(String address) async =>
      await _preferences?.setString(_address, address);

  static String? getAddress() => _preferences?.getString(_address);

  static Future setPhoneNumber(String contactNumber) async =>
      await _preferences?.setString(_contactNumber, contactNumber);

  static String? getPhoneNumber() => _preferences?.getString(_contactNumber)??"";

  static Future setCompoundId(String compoundId) async =>
      await _preferences?.setString(_compoundId, compoundId);

  static String? getCompoundId() => _preferences?.getString(_compoundId)??"";

  static Future setCompoundName(String compoundName) async =>
      await _preferences?.setString(_compoundName, compoundName);

  static String? getCompoundName() => _preferences?.getString(_compoundName)??"";

  static Future setCompoundLogo(String compoundId) async =>
      await _preferences?.setString(_compoundLogo, compoundId);

  static String? getCompoundLogo() => _preferences?.getString(_compoundLogo)??"";

  static clearSharedPreferencesForLogOut() async {
    _preferences?.remove(_id);
    _preferences?.remove(_contactNumber);
    _preferences?.remove(_email);
    _preferences?.remove(_username);
    _preferences?.remove(_fingerPrint);
    _preferences?.remove(_address);
    _preferences?.remove(_state);
    _preferences?.remove(_loginInState);
    _preferences?.remove(_accessToken);
    _preferences?.remove(_refreshTime);
    _preferences?.remove(_expiredTime);
    _preferences?.remove(_userType);

    _preferences?.remove(_compoundId);
    _preferences?.remove(_compoundLogo);
    _preferences?.remove(_compoundName);
  }
}
