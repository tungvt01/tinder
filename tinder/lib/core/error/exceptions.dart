class RemoteException implements Exception {
  String? errorCode;
  String? errorMessage;
  int? httpStatusCode;

  RemoteException({this.httpStatusCode, this.errorCode, this.errorMessage});
}

class CacheException implements Exception {
  String? errorMessage;
  CacheException({this.errorMessage});
}

class InputException implements Exception {
  String? errorMessage;
  InputException({this.errorMessage});
}

const SOCKET_EXCEPTION = "SOCKET_EXCEPTION";
const TIMEOUT_EXCEPTION = "TIMEOUT_EXCEPTION";
const UNKNOWN_EXCEPTION = "UNKNOWN_EXCEPTION";
