import 'package:dartz/dartz.dart';
import 'package:tinder/core/error/failures.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/domain/repository/index.dart';
import '../base_usecase.dart';

abstract class FetchUsersUsecase {
  Future<Either<Failure, UserListReponseModel>> fetchUsers(
      {required FetchUsersParams params});
}

class FetchUsersUsecaseImpl extends BaseUseCase<UserListReponseModel>
    implements FetchUsersUsecase {
  UserRepository userRepository;
  late FetchUsersParams _params;

  FetchUsersUsecaseImpl(
    this.userRepository,
  );

  @override
  Future<Either<Failure, UserListReponseModel>> fetchUsers(
      {required FetchUsersParams params}) async {
    _params = params;
    return execute();
  }

  @override
  Future<UserListReponseModel> main() {
    return userRepository.fetchUsers(params: _params);
  }
}
