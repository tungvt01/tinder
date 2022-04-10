import 'package:tinder/data/net/api_connection.dart';
import 'package:tinder/data/remote/api/index.dart';
import 'package:logger/logger.dart';
import '../../local/token_cache.dart';

class BookingRequestHeaderBuilder {
  AuthenCache tokenCache;
  ApiConfig apiConfig;

  BookingRequestHeaderBuilder({
    required this.tokenCache,
    required this.apiConfig,
  });

  Map<String, String> _defaultHeader({
    String? token,
    String contentType = 'application/json',
  }) {
    Logger().d("tungvt   --->> build request header token: $token");
    var header = {
      'content-type': contentType,
    };
    if (token?.isNotEmpty ?? false) {
      header['x-access-token'] = '$token';
    }

    return header;
  }

  Future<String> _validateAccessToken(AuthenCache authenCache) async {
    String? token = (await authenCache.getCachedToken())?.token;
    return token ?? '';
  }

  Future<Map<String, String>> buildHeader() async {
    String accesstoken;
    accesstoken = await _validateAccessToken(tokenCache);
    // todo dummy token
    var token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTIzNzA1ZTI0ODlkYzI4MjI2ZDdmODYiLCJwaG9uZU51bWJlciI6IjAzNDkxMDI1OTkiLCJmY21Ub2tlbiI6InVuZGVmaW5lZCIsImRldmljZUlkIjoiMzc4MjIzOTItRDg4QS00QTZGLUFFOEEtMEIyMkYxNUI1MzMyIiwibmFtZSI6IkhpZXUgVHJhbiIsInZlcnNpb25Db2RlIjoiMS4wIiwiZGV2aWNlVHlwZSI6MSwiZGV2aWNlTmFtZSI6Ik1vYmlsZSBpT1MgLSBBcHBsZSgxNS4wKSAtIGlQaG9uZSAxMiIsImxvZ2luVHlwZSI6MSwiaWF0IjoxNjMwMTI2NjgwLCJleHAiOjE2MzI3MTg2ODB9.o0oJOiFaP1tlwWqjGVwtiTn85WhXRztKUY-9nRzyeAw';
    var header = _defaultHeader(
      token: accesstoken,
    );
    return header;
  }
}
