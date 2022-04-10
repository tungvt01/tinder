import 'package:tinder/presentation/base/index.dart';
import 'package:tinder/presentation/page/login/index.dart';
import 'package:flutter/material.dart';

class LoginRouter with BaseRouter {
  @override
  onNavigateByState({required BuildContext context, required BaseState state}) {
    if (state is LoginSuccessState) {
      //navigator.materialPushAndRemoveAll(context: context, page: HomePage(pageTag: PageTag.home));
    }
    if (state is NotCurrentUserState) {
      applicationBloc(context).dispatchEvent(LogoutSuccessEvent());
    }
  }

  @override
  onNavigateByEvent(
      {required BuildContext context, required BaseEvent event}) {}
}
