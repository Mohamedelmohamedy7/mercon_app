import 'dart:convert';

///dashboard http://31.220.84.50:888
///http://31.220.84.50:888/#/pages/login
Decoding(String res) => json.decode(res);

class AppConstants {
  static const String APP_NAME = 'Cornado';
  static const String APP_VERSION = '1.0';
  static const String BASE_URL = 'http://31.220.84.50:777/API/';//live
 // static const String BASE_URL = 'http://31.220.84.50:666/API/'; //test
  //static const String BASE_URL = 'http://31.220.84.50:800/API/';
  static const String BASE_URL_IMAGE = 'http://31.220.84.50:777//';
  static const String USER_ID = 'userId';

  // sharePreference
  static const String TOKEN = 'token';
  static const String USER = 'user';
  static const String USER_EMAIL = 'user_email';
  static const String USER_PASSWORD = 'user_password';
  static const String HOME_ADDRESS = 'home_address';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String OFFICE_ADDRESS = 'office_address';
  static const String CART_LIST = 'cart_list';
  static const String CONFIG = 'config';
  static const String GUEST_MODE = 'guest_mode';
  static const String CURRENCY = 'currency';
  static const String LANG_KEY = 'lang';
  static const String INTRO = 'intro';
  static String errorInternetNotAvailable = 'Your internet is not working';
  static const String THEME = 'theme';

  static const String IS_OWNER = 'UintOwner';
  static const String IS_SuperAdmin = 'SuperAdmin';
  static const String IS_FullSuperAdmin = 'FullSuperAdmin';
  static const String IS_SecurityOfficer = 'SecurityOfficer';
  static const String IS_Accounting = 'Accountant';
  static const String IS_Supervisor = 'Supervisor';
  static const String IS_CustomerService = 'CustomerService';
  static const String IS_Employee = 'Employee';
}

/// APP FUNCTIONS 🥇🎗️
const String LOGIN = 'Authentication/login';
const String REGISTER = 'Authentication/Registration';
const String REGISTERSUB = 'Authentication/RegistrationSubOwner';
const String GETOWNERBYPHONENUMBER = 'Authentication/GetOwner?searchText=';

const String VERIVYCODE = 'Authentication/CheckCodeCompound?CodeCompound=';
const String RESET_PASSWORD = 'Authentication/SendResetPassword';
const String CHANGE_PASSWORD = 'Authentication/ChangePassword';
const String AddComplaint = 'Complaint/AddComplaint';
const String EDIT_ACCOUNT = 'UnitOwner/UpdateUnitOwnr';
const String GET_SUB_SERVICE_BY_ID =
    'SubServices/GetSubServicesBasedOnTime?ServiceID=';
const String LOGOUT = 'Authentication/Logout';
const String DELETE_ACCOUNT = 'Authentication/DeleteAccount';
const String MOBILESLIDERS = 'Lookup/MobileSliders';
const String ADDREGULATIONS = 'Lookup/GetInternalRegulation';
const String GET_ALL_UNITS = 'UnitData/GetAllUints';
const String GET_ALL_NOTIFICATION = 'Notification/GetUserNotification?UserID=';
const String GET_QRCODE_STATUS = 'UnitOwner/ScanEntranceQRCode?OnwerUserId=';
const String GET_QRCODE_STATUS_FOR_CHECKOUT = 'NoticeVisitAndRent/CheckoutUser';
const String GET_QRCODE_STATUS_FOR_CHECKIN =
    'NoticeVisitAndRent/ScanNoticQRCode';
const String SELECT_CHECKOUT_USER_STATUS = 'UnitOwner/SelectCheckOutStatus';
const String SEND_Status_QRCODE_FOR_CHECKIN =
    'NoticeVisitAndRent/AllowVisitorToAccess';
const String HOTLINE_NUMBER = 'Lookup/GetHotLineNumber';
const String WHATS_NUMBER = 'Authentication/GetAdminNumber';
const String REFRESH_TOKEN = 'Authentication/Refresh';
const String GET_ALL_NEWS = 'News/GetAllNews';
const String Genrate_Entrance_QrCode = 'UnitOwner/GenrateEntranceQrCode';
const String GET_ALL_SERVICES = 'ServiceType/GetAllServiceType';
const String GET_ALL_OWNER_PAYMENT =
    'OwnerPayment/GetAllOwnerPaymentByUserId?UserId=';
const String GetAllTransactionTypes = 'Transactions/GetAllTransactionTypes';
const String GET_ALL_GUEST_ACCESS = 'NoticeVisitAndRent/GetAllNotice';
const String GET_ALL_MODELS = 'Lookup/GetAllUintModels';
const String GET_ALL_MODELS_FOR_MOBILE = 'Lookup/GetAllUintModelsForMobile';
const String GET_ALL_MODELS_FOR_USER = 'ServiceRequest/GetUnitModelByUserId';
const String GET_BUILDING_BY_ID = 'Lookup/GetBuildingByModelId?Id=';
const String GET_BUILDING_BY_ID_FOR_USER =
    'ServiceRequest/GetbuildingByUserIdAndUnitModel';
const String GET_ALL_LEVELS_BY_ID = 'Lookup/GetlevelsByBuildingId?Id=';
const String GET_ALL_LEVELS_BY_ID_FOR_USER =
    'ServiceRequest/GetlevelsByUserIdAndbuilding';
const String GET_ALL_UNITS_BY_ID =
    'ServiceRequest/GetUnitNumberByUserIdAndlevel?UserId=';
const String ADD_SERVICE_REQUEST = 'ServiceRequest/AddServiceRequest';
const String GET_ALL_SERVICE_REQUEST = 'ServiceRequest/GetUserServiceRequest';
const String NOTICE_VISIT_AND_RENT = 'NoticeVisitAndRent/AddNotice';
const String GET_MY_UNITS_NUMBERS = 'OwnerUnits/GetOwnerUnitsByUserId?userId=';
const String SEND_MESSAGE_TO_SECURITY =
    'Notification/SendOrderDeliveryNotification';
const String GET_UNIT_DATA_BY_LEVELS = 'Lookup/GetUnitDataBylevelsId';
const String GET_UNIT_DATA_BY_LEVELS_FOR_ADD_NEW_UNIT =
    'Lookup/GetUnitDataBylevelsIdAndUserID';
const String ADD_NEW_UNIT = 'OwnerUnits/AddNewOwnerUnit';
const String Get_All_Delivery = 'Delivery/GetAllDelivery';
const String Get_Delivery_Menu_By_Id =
    'Delivery/GetDeliveryMenuByDeliveryID?DeliveryID=';

const String GET_COMPOUND_DATA = 'Authentication/GetLogoCompounnd';
const String Terms_And_Conditions = 'Lookup/GetTermsAndConditions';

const String GetVisitorsNotApprovedCount =
    "NoticeVisitAndRent/GetVisitorsNotApprovedCount";
const String GetNewRequests = "ServiceRequest/GetNewRequests";
const String GetVisitorsNotExitResponse =
    "NoticeVisitAndRent/GetVisitorsNotExit";
const String GetRentsNotApproved = "NoticeVisitAndRent/GetRentsNotApproved";
const String GetVisitsNotApproved = "NoticeVisitAndRent/GetVisitsNotApproved";
const String GetUnitOwnersNotApproved = "UnitOwner/GetUnitOwnersNotApproved";
const String GetRentsNotApprovedCount =
    'NoticeVisitAndRent/GetRentsNotApprovedCount';
const String GetVisitorsNotExitCount =
    'NoticeVisitAndRent/GetVisitorsNotExitCount';
const String GetNewOwnersCount = 'UnitOwner/GetNewOwnersCount';
const String GetVisitorsNotExit = 'NoticeVisitAndRent/GetVisitorsNotExit';
const String GetNewRequestsCount = 'ServiceRequest/GetNewRequestsCount';
const String GetUnitsForDashboard = 'UnitData/GetUnitsForDashboard';

const String GetAllUintOwners = 'UnitOwner/GetAllUintOwners';
const String GetAllUintOwnersSearch = 'UnitOwner/SearchUnitOwner';
const String BlockOrUnBlockUser = 'UnitOwner/BlockOrUnBlockUser?Id=';
const String SendDenialReason = 'Authentication/SendDenialReason';
const String Accept = 'Authentication/AcceptRegistrationRequests?Id=';
const String GetUnitOwnerDetails = 'UnitOwner/GetUnitOwnerById?Id=';

const String DeleteUser = 'UnitOwner/DeleteUnitOwnr';
const String DeleteOwnrUnit = 'OwnerUnits/DeleteOwnrUnit';
const String GetUnitPayments = 'UnitOwner/GetUnitPayments?Id=';

const String PaidOwnerPayment = 'UnitOwner/PaidOwnerPayment?Id=';
const String CheckUnitBelongingToAnotherOwner =
    'UnitOwner/CheckUnitBelongingToAnotherOwner';
const String StatusForOwnerAndUnit = 'UnitOwner/StatusForOwnerAndUnit';

const String GetAllRequestAnnexProperty =
    'OwnerUnits/GetAllRequestAnnexProperty';

const String GetRequestAnnexPropertyUnitOwnerById =
    'OwnerUnits/GetRequestAnnexPropertyUnitOwnerById?Id=';

const String GetAllGateLogs = 'GateLogs/GetAllGateLogs';

const String NoticeVisitAndRent = 'NoticeVisitAndRent/SearchNotice';
const String NoticeVisitAndRentDetailsEp =
    'NoticeVisitAndRent/GetNoticById?Id=';

const String ApproveOrCancelNotice =
    'NoticeVisitAndRent/ApproveOrCancelNotice?Id=';

const String GetAllServiceRequest = 'ServiceRequest/GetAllServiceRequest';

const String GetServiceRequestById = 'ServiceRequest/GetServiceRequestById?Id=';
const String StartingRequest = 'ServiceRequest/StartingRequest?Id=';
const String UpdateServiceRequest = 'ServiceRequest/UpdateServiceRequest';
const String SaveReasonOfRefuseAdmin =
    'NoticeVisitAndRent/SaveReasonOfRefuseAdmin';
const String UpdateServiceStatus = 'ServiceRequest/UpdateServiceStatus';

const String GetAllNotificationForAdmin = 'Notification/GetAllNotification';
const String SendNotification = 'Notification/SendNotification';
const String GetOwnersPaymentLogs = 'OwnerPayment/GetOwnersPaymentLogs';
const String AddOwnerUnitPayment = 'OwnerPayment/AddOwnerUnitPayment';
const String GetAllPaymentType = 'PaymentTypes/GetAllPaymentType';

const String GetComplaintList = 'Complaint/GetAllComplaint';

const String GetComplaintById = 'Complaint/GetComplaintById?Id=';
const String DeleteComplaintById = 'Complaint/DeleteComplaintId?Id=';

const String GET_ALL_SERVICE_Rates = 'Lookup/GetAllServiceRates';

const String RateServiceRequest = 'ServiceRequest/RateServiceRequest';

const String UpdateServicePrice = 'ServiceRequest/UpdateServicePrice';

const SendReplayToComplanint = 'Complaint/SendReply';
const String GetUserByID = 'Authentication/GetUserByID?UserId=';

const String UpdateUser = 'Authentication/UpdateUser';

const String GetAllTransactionTypesList = 'Transactions/GetAllTransactionTypes';

const String GetAllTransactionsList = 'Transactions/GetAllTransactions';

const String CreateTransactionEp = 'Transactions/CreateTransaction';
const String UpdateTransactionEp = 'Transactions/UpdateTransaction';
const String DeleteTransactionEp = 'Transactions/DeleteTransaction?ID=';

const String GetTransactionDetailsEp = 'Transactions/GetTransactionById?id=';

const String GetChairsCountEp = 'ChairRequest/GetChairsCount';//
const String GetAllChairRequestStatusesEp =
    'ChairRequest/GetAllChairRequestStatuses';//
const String DeleteChairRequestEp = 'ChairRequest/DeleteChairRequest?id=';//
const String UpdateChairRequestEp = 'ChairRequest/UpdateChairRequest';//
const String CreateChairRequestEp = 'ChairRequest/CreateChairRequest';//
const String GetAllChairRequestsEp = 'ChairRequest/GetAllChairRequests'; //
const String GetAllChairRequestsBuUserIdEp = 'ChairRequest/GetChairRequestsByUserID?UserID='; //
const String SetChairsCount = 'ChairRequest/SetChairsCount?ChairsCount=';
//const String GetChairRequestStatusByIdEp = 'ChairRequest/GetChairRequestStatusById?id=';
//const String GetChairRequestByIdEp = 'ChairRequest/GetChairRequestById?id=';


const String GenerateQrCodeForEmployeeEp = 'GateLogs/GenerateEmployeeQrCode';

const String GET_QRCODE_STATUS_For_Employee = 'GateLogs/ScanEmployeeQRCode?employeeQrCode=';
const String CheckUserValidationEp = 'Validation/CheckUserValidation';