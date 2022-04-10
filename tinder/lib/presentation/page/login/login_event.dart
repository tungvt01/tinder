import 'package:tinder/presentation/base/index.dart';

class LoginEvent extends BaseEvent {}

class TapBtnLoginEvent extends LoginEvent {
  String? phone;
  String? pass;

  TapBtnLoginEvent({this.phone, this.pass});
}

class LoginBiometricCLickedEvent extends LoginEvent {}

class NotMeButtonCLickEvent extends BaseEvent {}

class BiometrictButtonClickEvent extends BaseEvent {}

class RequestLoginEvent extends BaseEvent {
  String pass;
  RequestLoginEvent({required this.pass});
}

class OnForgotPasswordClickEvent extends BaseEvent {}
