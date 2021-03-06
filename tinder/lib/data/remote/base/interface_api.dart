import 'package:tinder/domain/model/index.dart';

abstract class UserApi {
  Future<UserListReponseModel> fetchUsers({required FetchUsersParams params});
  Future<UserModel> fetchUserDetail({required String userID});
}
