import 'package:tinder/core/utils/index.dart';
import 'package:tinder/domain/model/login/token_model.dart';
import 'storage/local_data_storage.dart';

abstract class AuthenCache {
  Future<TokenModel?> getCachedToken();

  Future<bool> putToken(TokenModel token, String password);

  Future<bool> removeToken();
}

class AuthenCacheImpl extends AuthenCache {
  LocalDataStorage _storage;

  AuthenCacheImpl(this._storage);

  static const String TOKEN_KEY = "EWALLET_TOKEN_KEY";
  static const String PASSWORD_KEY = "PASSWORD_KEY";

  @override
  Future<TokenModel?> getCachedToken() async {
    var token = await _storage.getString(TOKEN_KEY) ?? '';
    return TokenModel(token: token);
  }

  @override
  Future<bool> putToken(TokenModel token, String pass) async {
    await _storage.saveString(TOKEN_KEY, token.token);
    await _storage.saveString(PASSWORD_KEY, pass);
    return true;
  }

  @override
  Future<bool> removeToken() async {
    await _storage.remove(TOKEN_KEY);
    await _storage.remove(PASSWORD_KEY);
    return true;
  }
}
