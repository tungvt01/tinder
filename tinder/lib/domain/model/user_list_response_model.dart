import 'package:tinder/domain/model/index.dart';

class UserListReponseModel {
  List<UserModel> data;
  int total;
  int page;
  int limit;

  UserListReponseModel({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
  });

  factory UserListReponseModel.fromJson({required Map<String, dynamic> json}) {
    final usersJson = json['data'];
    List<UserModel> users = [];
    if (usersJson is List<dynamic>) {
      users = usersJson
          .map<UserModel>((itemJson) => UserModel.fromJson(json: itemJson))
          .toList();
    }
    return UserListReponseModel(
        data: users,
        total: json['total'],
        page: json['page'],
        limit: json['limit']);
  }
}
