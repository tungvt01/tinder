import 'package:tinder/domain/model/index.dart';

abstract class AuthenticationRepository {
  Future<BaseResponse<LoginResponse>> login({required ParamsLogin params});

  Future<bool> isLogged();

  Future<bool> logout({bool remoteLogout = false});
}
