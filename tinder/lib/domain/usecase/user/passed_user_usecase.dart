import 'package:dartz/dartz.dart';
import 'package:tinder/core/error/failures.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/domain/repository/index.dart';
import '../base_usecase.dart';

abstract class PassUserUserUsecase {
  Future<Either<Failure, bool>> passedUser({required UserModel likedUser});
}

class PassUserUserUsecaseImpl extends BaseUseCase<bool>
    implements PassUserUserUsecase {
  UserRepository userRepository;
  late UserModel _likedUser;

  PassUserUserUsecaseImpl(
    this.userRepository,
  );

  @override
  Future<Either<Failure, bool>> passedUser(
      {required UserModel likedUser}) async {
    _likedUser = likedUser;
    return execute();
  }

  @override
  Future<bool> main() async {
    await userRepository.insertPassedUser(user: _likedUser);
    return true;
  }
}
