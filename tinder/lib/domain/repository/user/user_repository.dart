import 'package:tinder/domain/model/index.dart';

abstract class UserRepository {
  Future<UserListReponseModel> fetchMatchedUsers(
      {required FetchUsersParams params});
  Future<void> insertLikedUser({required UserModel user});
  Future<void> insertPassedUser({required UserModel user});
  Future<List<UserModel>> getPassedUsers();
  Future<List<UserModel>> getLikedUsers();
}
