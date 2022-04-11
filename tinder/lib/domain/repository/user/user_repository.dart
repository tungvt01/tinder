import 'package:tinder/domain/model/index.dart';

abstract class UserRepository {
  Future<UserListReponseModel> fetchUsers({required FetchUsersParams params});
}
