import 'package:dartz/dartz.dart';
import 'package:tinder/core/error/failures.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/domain/repository/index.dart';
import '../base_usecase.dart';

abstract class FetchMatchedUsersUsecase {
  Future<Either<Failure, UserListReponseModel>> fetchUsers(
      {required FetchUsersParams params});
}

class FetchMatchedUsersUsecaseImpl extends BaseUseCase<UserListReponseModel>
    implements FetchMatchedUsersUsecase {
  UserRepository userRepository;
  late FetchUsersParams _params;

  FetchMatchedUsersUsecaseImpl(
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
    return userRepository.fetchMatchedUsers(params: _params);
  }
}
