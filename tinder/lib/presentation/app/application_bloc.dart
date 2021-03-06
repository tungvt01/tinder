import 'dart:async';
import 'package:tinder/presentation/base/index.dart';
import 'package:rxdart/subjects.dart';
import 'application_state.dart';

class ApplicationBloc extends BaseBloc<ApplicationEvent, ApplicationState> {
  final PublishSubject<BaseEvent> _broadcastEventManager =
      PublishSubject<BaseEvent>();

  ApplicationBloc()
      : super(initState: ApplicationState(tag: AppLaunchTag.splash)) {
    on<AppLaunched>(
        (_, emitter) => emitter(ApplicationState(tag: AppLaunchTag.home)));
  }

  @override
  void dispose() {
    _broadcastEventManager.close();
  }
}

//broadcast event
extension AppEventCenter on ApplicationBloc {
  Stream<BaseEvent> get broadcastEventStream => _broadcastEventManager.stream;

  void postBroadcastEvent(BaseEvent event) {
    _broadcastEventManager.add(event);
  }
}
