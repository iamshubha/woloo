// ignore_for_file: non_constant_identifier_names

class APIConstants {
  // static var BASE_URL = 'http://13.232.85.166'; // DEV
  static var BASE_URL = 'http://3.109.4.218'; // QA

  static var SEND_OTP = '$BASE_URL/api/user/send-otp';
  static var COUNTRIES = '$BASE_URL/api/address/country';
  static var MARKET_TYPES = '$BASE_URL/api/market/dropdownList?type=market_Type';
  static var CURRENCY = '$BASE_URL/api/address/currency';
  static var LANGUAGE = '$BASE_URL/api/address/language';
  static var DROPDOWN_LIST = '$BASE_URL/api/market/dropdownList';
  static var VERIFY_OTP = '$BASE_URL/api/user/verify-otp';
  static var CATEGORY = '$BASE_URL/api/product/category';

  /// Dashboard
  static var DASHBOARD_API = '$BASE_URL/';

  /// MarketList
  static var MARKETS_LIST = '$BASE_URL/api/market/all';
  static var CREATE_MARKET = '$BASE_URL/api/market';
  static var EDIT_MARKET = '$BASE_URL/api/market';

  /// marketById
  static var MARKETS_BY_ID = '$BASE_URL/api/market/byId';

  /// ProductsList
  static var PRODUCTS_API = '$BASE_URL/api/product/all';
  static var MAPPED_PRODUCTS = '$BASE_URL/api/product/mappedProductMarket';
  static var CREATE_PRODUCT = '$BASE_URL/api/product';
  static var PRODUCT_BY_ID = '$BASE_URL/api/product/byId';
  static var MAPPING = '$BASE_URL/api/product/mapping';
  static var GET_MAPPED_MARKETS_TO_PRODUCT = '$BASE_URL/api/product/mappedMarketsToProduct';
  static var GET_MAPPED_MARKETS_TO_MEMBERS = '$BASE_URL/api/user/mappedMarketsToUser';
  static var GET_MAPPED_MARKETS_TO_MANAGERS = '$BASE_URL/api/user/mappedMarketsToUser';
  static var GET_MAPPED_MARKETS_TO_USER = '$BASE_URL/api/user/mappedMarketsToUser';
  static var SUBSCRIBE_TO_MARKET = '$BASE_URL/api/market/subscriptions';

  /// Managers
  static var MANAGERS_API = '$BASE_URL/api/user/list';
  static var MAPPED_MANAGERS = '$BASE_URL/api/user/mappedUserMarket';
  static var CREATE_MANAGER = '$BASE_URL/api/user';
  static var MANAGER_BY_ID = '$BASE_URL/api/user/ById';
  static var UPDATE_MANAGER = '$BASE_URL/api/user';
  static var USER_ROLES = '$BASE_URL/api/user/usersRole';
  static var COUNTRY_CODE = '$BASE_URL/api/address/countryCode';

  static var MEMBERS_API = '$BASE_URL/api/user/list';
  static var MAPPED_MEMBERS = '$BASE_URL/api/user/mappedUserMarket';

  static var DELETE_MARKET = '$BASE_URL/api/market';
  static var DELETE_PRODUCT = '$BASE_URL/api/product';
  static var DELETE_MAPPED_PRODUCT = '$BASE_URL/api/product/deleteMappedProduct';
  static var DELETE_MANAGER = '$BASE_URL/api/user/';

  static var DELETE_MAPPED_MANAGER = '$BASE_URL/api/user/deleteMappedUser';
  static var APPROVE_MANAGER = '$BASE_URL/api/user/updateUserStatus';
  static var APPROVE_MEMBER = '$BASE_URL/api/user/updateUserStatus';
  static var CREATE_MEMBER = '$BASE_URL/api/user';
  static var DELETE_MEMBER = '$BASE_URL/api/user/';
  static var DELETE_MAPPED_MEMBER = '$BASE_URL/api/user/deleteMappedUser';
  static var MEMBER_BY_ID = '$BASE_URL/api/user/ById';
  static var UPDATE_MEMBER = '$BASE_URL/api/user';
  static var USER_MAPPING = '$BASE_URL/api/user/mapping';

  /// RBAC
  static var GET_RBAC = '$BASE_URL/api/rbac/roles/pages/cta/app';

  static var SEND_FCM_TOKEN = '$BASE_URL/api/user/editToken';
  static var GET_NOTIFICATIONS = '$BASE_URL/api/user/getNotifications';
}
