import 'package:tinder/core/error/failures.dart';
import 'package:tinder/presentation/base/index.dart';

class HomeState extends BaseState {
  HomeState({
    ExecuteStatus? loadingStatus,
    Failure? failure,
  }) : super(
            loadingStatus: loadingStatus ?? ExecuteStatus.none,
            failure: failure);

  HomeState copyWith({ExecuteStatus? loadingStatus, Failure? failure}) {
    return HomeState(loadingStatus: loadingStatus, failure: failure);
  }
}
