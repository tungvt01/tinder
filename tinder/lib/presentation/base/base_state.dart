import 'package:tinder/core/error/failures.dart';

enum ExecuteStatus {
  none,
  loading,
  success,
}

abstract class BaseState {
  ExecuteStatus loadingStatus = ExecuteStatus.none;
  Failure? failure;

  BaseState({this.loadingStatus = ExecuteStatus.none, this.failure});
}

class IdlState extends BaseState {}

// class ErrorState extends BaseState {
//   String? messageError;
//   String? code;
//   ErrorState({this.messageError, this.code});
// }

// class ValidatedState extends BaseState {}

// class LoadingState extends BaseState {}
