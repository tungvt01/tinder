import 'package:tinder/core/error/failures.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/presentation/base/index.dart';

class MatchingState extends BaseState {
  List<UserModel>? listUsers;

  MatchingState({
    this.listUsers,
    ExecuteStatus? loadingStatus,
    Failure? failure,
  }) : super(
            loadingStatus: loadingStatus ?? ExecuteStatus.none,
            failure: failure);

  MatchingState copyWith(
      {List<UserModel>? listUsers,
      ExecuteStatus? loadingStatus,
      Failure? failure}) {
    return MatchingState(
        listUsers: listUsers ?? this.listUsers,
        loadingStatus: loadingStatus,
        failure: failure);
  }
}
