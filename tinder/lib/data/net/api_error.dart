import 'package:tinder/core/error/exceptions.dart';

class ApiError extends RemoteException {
  ApiError({int? httpStatusCode, String? errorCode, String? errorMessage})
      : super(
            httpStatusCode: httpStatusCode,
            errorCode: errorCode,
            errorMessage: errorMessage);

  factory ApiError.initCombine(int? httpStatusCode, Map<String, dynamic> json,
      {String? statusMessage}) {
    try {
      final errorCode = json['statusCode'];
      final errorMessage = json['msg'];
      return ApiError(
          httpStatusCode: httpStatusCode,
          errorCode: errorCode,
          errorMessage: errorMessage ?? statusMessage);
    } on FormatException catch (ex) {
      throw ex;
    } catch (ex) {
      throw ex;
    }
  }
}
