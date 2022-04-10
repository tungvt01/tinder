import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tinder/core/error/exceptions.dart';
import 'package:tinder/core/error/failures.dart';
import 'package:tinder/core/network/network_status.dart';
import 'package:tinder/data/remote/api/index.dart';
import 'package:logger/logger.dart';
import 'api_endpoint_input.dart';
import 'api_error.dart';

class ApiConnection {
  ApiConfig _apiConfig;
  NetworkStatus? networkStatus;
  Map<String, dynamic> header;

  ApiConnection(this._apiConfig, this.header, {this.networkStatus});

  Future<dynamic> execute(ApiInput input) async {
    Logger().d(
        '[Debug]: url ${_apiConfig.baseUrl}${input.endPoint.path} header: $header');

    Future<Response> future;
    switch (input.endPoint.method) {
      case ApiMethod.get:
        future = _get(input);
        break;
      case ApiMethod.post:
        future = _post(input);
        break;
      case ApiMethod.delete:
        future = _delete(input);
        break;
      case ApiMethod.put:
        future = _put(input);
        break;
    }
    return future.then(_parseResponse).catchError((ex) {
      _handleError(ex);
    });
  }

  Future<dynamic> download(
    String downloadUrl,
    String storePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Options? options,
  }) {
    final future = _httpClient(
      receiveTimeout: 0,
    ).download(
      downloadUrl,
      storePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      options: options,
    );
    return future.then(_parseResponse).catchError((ex) {
      _handleError(ex);
    });
  }

  Future<dynamic> upload(
    String filePath,
    ApiInput input, {
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    Options? options,
    ContentType? contentType,
  }) {
    var file = File(filePath);
    if (!file.existsSync()) {
      throw ApiError(errorMessage: FILE_NOT_FOUND_MESSAGE);
    }
    header[HttpHeaders.contentLengthHeader] = file.lengthSync();
    header[HttpHeaders.contentTypeHeader] = contentType ?? ContentType.binary;
    final future = _httpClient(
      receiveTimeout: 0,
    ).post(
      input.endPoint.path,
      data: input.body,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
    return future.then(_parseResponse).catchError((ex) {
      _handleError(ex);
    });
  }

  Future<dynamic> uploadMultiPart(
    FormData formData,
    ApiInput input, {
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    Options? options,
    ContentType? contentType,
  }) {
    final client = _httpClient(
      receiveTimeout: 0,
    );
    Future<Response> future;
    if (input.endPoint.method == ApiMethod.post) {
      future = client.post(
        input.endPoint.path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );
    } else {
      future = client.put(
        input.endPoint.path,
        data: formData,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );
    }
    return future.then(_parseResponse).catchError((ex) {
      _handleError(ex);
    });
  }

  _handleError(error) {
    Logger().d("APIConnection _handleError $error");
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.response:
          final httpStatusCode = error.response?.statusCode ?? 0;
          if (httpStatusCode == HTTP_STATUS_SERVER_MAINTAIN ||
              httpStatusCode == HTTP_STATUS_SERVER_BAD_GATEWAY) {
            throw ApiError(
                httpStatusCode: httpStatusCode,
                errorCode: TIMEOUT_EXCEPTION,
                errorMessage: SERVER_ERROR_MESSAGE);
          } else {
            throw ApiError.initCombine(
              httpStatusCode,
              _convertToJsonIfNeeds(error.response?.data),
              statusMessage: error.response?.statusMessage,
            );
          }
        case DioErrorType.sendTimeout:
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
          throw ApiError(
              httpStatusCode: 404,
              errorCode: TIMEOUT_EXCEPTION,
              errorMessage: SERVER_ERROR_MESSAGE);
        case DioErrorType.cancel:
        default:
          if (error.error is SocketException) {
            throw ApiError(
                httpStatusCode: 0,
                errorCode: SOCKET_EXCEPTION,
                errorMessage: SOCKET_ERROR_MESSAGE);
          } else {
            throw ApiError(
                httpStatusCode: 0,
                errorCode: UNKNOWN_EXCEPTION,
                errorMessage: SERVER_ERROR_MESSAGE);
          }
      }
    } else {
      throw error;
    }
  }

  Future<dynamic> _parseResponse(Response response) async {
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      return response.data;
    } else {
      throw ApiError.initCombine(response.statusCode, response.data,
          statusMessage: response.statusMessage);
    }
  }

  Future<Response> _get(ApiInput input) async {
    return _httpClient().get(
      input.endPoint.path,
      queryParameters: input.params,
    );
  }

  Future<Response> _post(ApiInput input) async {
    return _httpClient().post(
      input.endPoint.path,
      data: input.data ?? input.body,
      queryParameters: input.params,
    );
  }

  Future<Response> _put(ApiInput input) async {
    return _httpClient().put(
      input.endPoint.path,
      data: input.data ?? input.body,
      queryParameters: input.params,
    );
  }

  Future<Response> _delete(ApiInput input) async {
    return _httpClient().delete(
      input.endPoint.path,
      data: input.data ?? input.body,
      queryParameters: input.params,
    );
  }

  Dio _httpClient(
      {String? baseUrl,
      int? connectTimeout,
      int? receiveTimeout,
      Map<String, dynamic>? requestHeader}) {
    var options = BaseOptions(
        baseUrl: baseUrl ?? _apiConfig.baseUrl,
        connectTimeout: connectTimeout ?? _apiConfig.connectTimeout,
        receiveTimeout: receiveTimeout ?? _apiConfig.receiveTimeout,
        headers: requestHeader ?? header);
    return Dio(options);
  }

  Map<String, dynamic> _convertToJsonIfNeeds(dynamic data) {
    if (data is String) {
      try {
        return convert.json.decode(data);
      } catch (ex) {
        return Map<String, dynamic>();
      }
    }
    return data;
  }
}
