import 'package:tinder/data/remote/base/interface_api.dart';
import 'package:tinder/domain/model/index.dart';
import '../../domain/repository/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserApi userApi;

  UserRepositoryImpl(
    this.userApi,
  );

  @override
  Future<UserListReponseModel> fetchUsers(
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
}
