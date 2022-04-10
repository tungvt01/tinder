export 'package:tinder/main/app_injector.dart';
import 'package:tinder/presentation/base/base_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/presentation/app/application_bloc.dart';
import '../navigator/page_navigator.dart';
import 'base_state.dart';

export 'package:tinder/presentation/monitor/bloc_monitor_delegate.dart';
export 'package:tinder/presentation/app/application_event.dart';
export 'package:tinder/presentation/utils/page_tag.dart';

abstract class BaseRouter {
  ApplicationBloc applicationBloc(BuildContext context) {
    final bloc = BlocProvider.of<ApplicationBloc>(context);
    return bloc;
  }

  dynamic onNavigateByState(
      {required BuildContext context, required BaseState state}) async {}

  dynamic onNavigateByEvent(
      {required BuildContext context, required BaseEvent event}) async {
    if (event is OnBackEvent) {
      return navigator.popBack(context: context);
    }
  }
}
