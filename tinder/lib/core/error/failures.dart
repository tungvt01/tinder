abstract class Failure {
  String? message;
  String? code;
  Failure({this.message, this.code});
}

class RemoteFailure extends Failure {
  dynamic data;
  String? code;
  RemoteFailure({String? msg, this.data, this.code})
      : super(message: msg, code: code);
}

class CacheFailure extends Failure {
  CacheFailure({String? msg}) : super(message: msg);
}

class PlatformFailure extends Failure {
  PlatformFailure({String? msg}) : super(message: msg);
}

class UnknownFailure extends Failure {
  UnknownFailure({String? msg}) : super(message: msg);
}

const CANNOT_BOOKING_THIS_TIME_MESSAGE =
    'Selected booking segment time is not available';
// const UNKNOWN_ERROR_MESSAGE = 'unknown_error_message';
const LOGOUT_ERROR_MESSAGE = 'Cannot Logout';
const INTERNET_ERROR_MESSAGE = 'Network error';
const SOCKET_ERROR_MESSAGE = 'Cannot connect to server';
const SERVER_ERROR_MESSAGE = 'server_error_message';
const FILE_NOT_FOUND_MESSAGE = "File not found";

const LARGE_CATEGORY_NOT_FOUND = "Large category not found";

// /// register response error mail
const LOGIN_ID_ALREADY_USED = 'Login id already been used.';

/// login error code
const LOGIN_NEW_DEVICE = '406';
const REGISTER_SNS_ACCOUNT = '404';
const LOGIN_NET_WORK_ERROR = '0';
const LOGIN_WRONG_PASSWORD = '400';
const HTTP_STATUS_SERVER_MAINTAIN = 520;
const HTTP_STATUS_SERVER_BAD_GATEWAY = 502;

const ACCESS_TOKEN_EXPIRED_CODE = "401";
const ACCESS_TOKEN_EXPIRED_MESSAGE = "Unauthorized";
