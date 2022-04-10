import 'package:tinder/presentation/base/base_event.dart';

abstract class ApplicationEvent extends BaseEvent {}

class LoadingEvent extends ApplicationEvent {}

class AppLaunched extends ApplicationEvent {}

class AccessTokenExpiredEvent extends ApplicationEvent {}

class ReloadUiWithNewDataEvent extends ApplicationEvent {
  dynamic data;

  ReloadUiWithNewDataEvent({this.data});
}

class NotificationClickEvent extends ApplicationEvent {
  final String sendNotifyCd;

  NotificationClickEvent({required this.sendNotifyCd});
}

class RegisterSuccessEvent extends ApplicationEvent {
  final bool hasUserData;
  RegisterSuccessEvent({required this.hasUserData});
}

class LoginSuccessEvent extends ApplicationEvent {
  final bool hasUserData;
  LoginSuccessEvent({required this.hasUserData});
}

class SignUpSuccessEvent extends ApplicationEvent {
  final String? phone;
  final String? pass;

  SignUpSuccessEvent({this.pass, this.phone});
}
