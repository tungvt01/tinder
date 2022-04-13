import 'package:tinder/domain/model/index.dart';

abstract class UserCache {
  Future<void> insertLikedUser({required UserModel user});
  Future<List<UserModel>> getLikedUsers();

  Future<void> insertPasseddUser({required UserModel user});
  Future<List<UserModel>> getPassedUsers();
}

class UserCacheImpl extends UserCache {
  final List<UserModel> _likedUsers = [];
  final List<UserModel> _passedUsers = [];

  @override
  Future<List<UserModel>> getLikedUsers() async {
    return _likedUsers;
  }

  @override
  Future<List<UserModel>> getPassedUsers() async {
    return _passedUsers;
  }

  @override
  Future<void> insertLikedUser({required UserModel user}) async {
    _likedUsers.add(user);
  }

  @override
  Future<void> insertPasseddUser({required UserModel user}) async {
    _passedUsers.add(user);
  }
}
