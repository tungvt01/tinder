import '../../net/index.dart';
import '../base/base_api.dart';
import '../base/interface_api.dart';
import 'package:tinder/domain/model/index.dart';

class UserApiImpl extends BaseApi with UserApi {
  UserApiImpl() : super();

  @override
  Future<UserModel> fetchUserDetail({required String userID}) async {
    final connection = await initConnection();
    final json = await connection.execute(ApiInput(
      endPointProvider!.endpoints['user_detail']!.appendPath("/$userID"),
    ));
    final response = UserModel.fromJson(json: json);
    return response;
  }

  @override
  Future<UserListReponseModel> fetchUsers(
      {required FetchUsersParams params}) async {
    final connection = await initConnection();
    final json = await connection.execute(ApiInput(
      endPointProvider!.endpoints['user_list']!,
      param: params.toJson(),
    ));
    final response = UserListReponseModel.fromJson(json: json);
    return response;
  }
}
