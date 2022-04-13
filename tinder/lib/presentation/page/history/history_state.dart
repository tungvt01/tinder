import 'package:tinder/core/error/failures.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/presentation/base/index.dart';

class HistoryState extends BaseState {
  List<UserModel> users;
  HistoryState({
    required this.users,
    ExecuteStatus? loadingStatus,
    Failure? failure,
  }) : super(
            loadingStatus: loadingStatus ?? ExecuteStatus.none,
            failure: failure);

  HistoryState copyWith(
      {List<UserModel>? users,
      ExecuteStatus? loadingStatus,
      Failure? failure}) {
    return HistoryState(
        loadingStatus: loadingStatus,
        failure: failure,
        users: users ?? this.users);
  }
}
