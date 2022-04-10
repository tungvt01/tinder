import 'package:tinder/domain/model/index.dart';

abstract class AuthenApi {
  Future<BaseResponse<LoginResponse>> login({required ParamsLogin params});

  Future<bool> logout();
}
