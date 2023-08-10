// ignore_for_file: non_constant_identifier_names

class APIConstants {
  // static var BASE_URL = 'https://whms-api.woloo.in'; // QA
  static var BASE_URL = 'http://15.207.20.149'; // QA

  static var SEND_OTP = '$BASE_URL/api/whms/users/sendOTP';
  static var VERIFY_OTP = '$BASE_URL/api/whms/users/verifyOTP';

  /// clock-In - clock-Out
  static var ATTENDANCE = '$BASE_URL/api/whms/users/attendance';

  /// Template List
  static var GET_ALL_TASK_TAMPLATES = '$BASE_URL/api/whms/taskAllocation/getAllTaskByJanitorId';

  /// upload selfie
  static var UPLOAD_SELFIE = '$BASE_URL/api/whms/users/upload_image';

  /// task-list
  static var GET_ALL_TASKS = '$BASE_URL/api/whms/task/getAllTasksByTempleteId';
  static var SUBMIT_TASKS = '$BASE_URL/api/whms/users/submitTask';

  /// Status_update
  static var UPDATE_STATUS = '$BASE_URL/api/whms/users/updateStatus';
}
