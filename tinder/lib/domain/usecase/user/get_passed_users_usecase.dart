import 'package:dartz/dartz.dart';
import 'package:tinder/core/error/failures.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/domain/repository/index.dart';
import '../base_usecase.dart';

abstract class GetPassedUsersUsecase {
  Future<Either<Failure, List<UserModel>>> getPassedUsers();
}

class GetPassedUsersUsecaseImpl extends BaseUseCase<List<UserModel>>
    implements GetPassedUsersUsecase {
  UserRepository userRepository;
  GetPassedUsersUsecaseImpl(
    this.userRepository,
  );

  @override
  Future<Either<Failure, List<UserModel>>> getPassedUsers() async {
    return execute();
  }

  @override
  Future<List<UserModel>> main() {
    return userRepository.getPassedUsers();
  }
}
