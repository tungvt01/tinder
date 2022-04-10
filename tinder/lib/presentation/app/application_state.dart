import 'package:tinder/core/error/failures.dart';
import 'package:tinder/presentation/base/base_state.dart';

class ApplicationState extends BaseState {
  AppLaunchTag tag;
  ApplicationState({
    required this.tag,
    Failure? failure,
    ExecuteStatus? status,
  }) : super(failure: failure, loadingStatus: status ?? ExecuteStatus.none);

  ApplicationState copyWith({
    AppLaunchTag? tag,
    Failure? failure,
    ExecuteStatus? status,
  }) {
    return ApplicationState(
        tag: tag ?? this.tag, failure: failure, status: status);
  }
}

const APP_LAUNCH_ERROR_MESSAGE = "application cannot start";

enum AppLaunchTag { splash, login, home, policy, updateUser }
