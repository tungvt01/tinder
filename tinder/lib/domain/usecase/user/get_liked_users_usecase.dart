import 'package:dartz/dartz.dart';
import 'package:tinder/core/error/failures.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/domain/repository/index.dart';
import '../base_usecase.dart';

abstract class GetLikedUsersUsecase {
  Future<Either<Failure, List<UserModel>>> getLikedUsers();
}

class GetLikedUsersUsecaseImpl extends BaseUseCase<List<UserModel>>
    implements GetLikedUsersUsecase {
  UserRepository userRepository;

  GetLikedUsersUsecaseImpl(
    this.userRepository,
  );

  @override
  Future<Either<Failure, List<UserModel>>> getLikedUsers() async {
    return execute();
  }

  @override
  Future<List<UserModel>> main() {
    return userRepository.getLikedUsers();
  }
}
