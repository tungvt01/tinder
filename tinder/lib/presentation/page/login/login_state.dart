import 'package:tinder/core/error/failures.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/presentation/base/base_page_mixin.dart';
import 'package:tinder/presentation/base/index.dart';

class LoginState extends BaseState {
  UserModel? user;

  LoginState({
    this.user,
    ExecuteStatus? loadingStatus,
    Failure? failure,
  }) : super(
            loadingStatus: loadingStatus ?? ExecuteStatus.none,
            failure: failure);

  LoginState copyWith(
      {UserModel? userModel, ExecuteStatus? loadingStatus, Failure? failure}) {
    return LoginState(
        user: userModel ?? this.user,
        loadingStatus: loadingStatus,
        failure: failure);
  }
}

class LoginSuccessState extends LoginState {
  LoginSuccessState({required UserModel user}) : super(user: user);
}

class NotCurrentUserState extends LoginState {
  NotCurrentUserState({UserModel? user}) : super(user: user);
}
