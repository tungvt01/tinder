import 'package:tinder/data/local/index.dart';
import 'package:tinder/data/remote/base/interface_api.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/domain/repository/index.dart';
import 'package:logger/logger.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenApi _authenApi;
  AuthenCache _authenCache;

  AuthenticationRepositoryImpl(
    this._authenApi,
    this._authenCache,
  );

  @override
  Future<BaseResponse<LoginResponse>> login(
      {required ParamsLogin params}) async {
    final response = await _authenApi.login(params: params);
    _authenCache.putToken(
        TokenModel(token: response.data!.token!), params.password);
    return response;
  }

  @override
  Future<bool> isLogged() async {
    var tokenCached = await _authenCache.getCachedToken();
    return (tokenCached?.token.isNotEmpty ?? false);
  }

  @override
  Future<bool> logout({bool remoteLogout = false}) async {
    if (remoteLogout) {
      bool result = false;
      try {
        result = await _authenApi.logout();
      } finally {
        clearCached();
      }
      return result;
    }
    await clearCached();
    return true;
  }

  Future clearCached() async {
    await Future.wait([
      _authenCache.removeToken(),
    ]);
  }
}
