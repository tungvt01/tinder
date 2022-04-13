import 'package:tinder/data/local/index.dart';
import 'package:tinder/data/remote/base/interface_api.dart';
import 'package:tinder/domain/model/index.dart';
import '../../domain/repository/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserApi userApi;
  UserCache userCache;

  UserRepositoryImpl(this.userApi, this.userCache);

  @override
  Future<UserListReponseModel> fetchMatchedUsers(
      {required FetchUsersParams params}) async {
    var response = await userApi.fetchUsers(params: params);
    List<UserModel> listUsersDetail = [];
    // fetch user detail
    List<Future> fetchUserDetailFutures = response.data.map<Future>((e) async {
      final userDetail = await userApi.fetchUserDetail(userID: e.id);
      listUsersDetail.add(userDetail);
    }).toList();
    //wait fetching all users detail
    await Future.wait(fetchUserDetailFutures);
    response.data = listUsersDetail;
    return response;
  }

  @override
  Future<List<UserModel>> getLikedUsers() {
    return userCache.getLikedUsers();
  }

  @override
  Future<List<UserModel>> getPassedUsers() {
    return userCache.getPassedUsers();
  }

  @override
  Future<void> insertLikedUser({required UserModel user}) async {
    userCache.insertLikedUser(user: user);
  }

  @override
  Future<void> insertPassedUser({required UserModel user}) async {
    userCache.insertPasseddUser(user: user);
  }
}
