import 'package:dartz/dartz.dart';
import 'package:tinder/core/error/failures.dart';
import 'package:tinder/domain/repository/index.dart';

import 'index.dart';

abstract class LogoutUseCase {
  Future<Either<Failure, bool>> logout({bool isRemoteLogout = true});
}

class LogoutUseCaseImpl extends BaseUseCase<bool> implements LogoutUseCase {
  AuthenticationRepository authenRepo;
  bool _isRemoteLogout = false;

  LogoutUseCaseImpl(this.authenRepo);

  @override
  Future<Either<Failure, bool>> logout({bool isRemoteLogout = true}) async {
    _isRemoteLogout = isRemoteLogout;
    return this.execute();
  }

  @override
  Future<bool> main() async {
    var result = await authenRepo.logout(remoteLogout: _isRemoteLogout);
    return result;
  }
}
