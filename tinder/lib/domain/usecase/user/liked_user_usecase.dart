import 'package:dartz/dartz.dart';
import 'package:tinder/core/error/failures.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/domain/repository/index.dart';
import '../base_usecase.dart';

abstract class LikedUserUsecase {
  Future<Either<Failure, bool>> likeUser({required UserModel likedUser});
}

class LikedUserUsecaseImpl extends BaseUseCase<bool>
    implements LikedUserUsecase {
  UserRepository userRepository;
  late UserModel _likedUser;

  LikedUserUsecaseImpl(
    this.userRepository,
  );

  @override
  Future<Either<Failure, bool>> likeUser({required UserModel likedUser}) async {
    _likedUser = likedUser;
    return execute();
  }

  @override
  Future<bool> main() async {
    await userRepository.insertLikedUser(user: _likedUser);
    return true;
  }
}
