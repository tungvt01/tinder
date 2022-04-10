import 'dart:async';

import 'package:tinder/core/error/exceptions.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/presentation/app/index.dart';
import 'package:tinder/presentation/navigator/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:tinder/main/app_injector.dart';
import 'package:tinder/core/error/failures.dart';
import 'package:tinder/presentation/base/index.dart';
import 'package:tinder/presentation/utils/page_tag.dart';
import 'package:provider/provider.dart';
import '../app/application_bloc.dart';
import 'base_bloc.dart';
import 'base_event.dart';
import 'base_page_mixin.dart';
import 'base_router.dart';
import 'base_state.dart';

export 'package:logger/logger.dart';
export 'package:tinder/presentation/styles/index.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:tinder/presentation/utils/input_formatter.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({
    required this.tag,
    Key? key,
  }) : super(key: key);
  final PageTag tag;
}

abstract class BasePageState<
    T extends BaseBloc<BaseEvent, BaseState>,
    P extends BasePage,
    R extends BaseRouter> extends State<P> with BasePageMixin {
  late T bloc;
  late BuildContext subContext;
  late R router;
  late ApplicationBloc applicationBloc;

  bool get willListenApplicationEvent => false;

  bool get usingAppBackgroundPhoto => true;

  bool get resizeToAvoidBottomInset => false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.onPageDidChangeDependenciesEvent(
        PageDidChangeDependenciesEvent(context: context));
  }

  @override
  void initState() {
    bloc = injector.get<T>();
    router = injector.get<R>();
    applicationBloc = BlocProvider.of<ApplicationBloc>(context);

    bloc.onPageInitStateEvent(PageInitStateEvent(context: context));
    super.initState();
  }

  navigateByEvent({required BaseEvent event}) async {
    final result =
        await router.onNavigateByEvent(context: context, event: event);
    bloc.onRouteNavigationResult(result);
  }

  Widget buildLayout(BuildContext context, BaseBloc bloc);

  void stateListenerHandler(BaseState state) async {
    if (state.failure != null) {
      if (state.failure!.code == ACCESS_TOKEN_EXPIRED_CODE) {
        final result = await showAlert(
          primaryColor: AppColors.primaryColor,
          context: context,
          message: AppLocalizations.shared.sessionExpiredMessage,
        );
        if (result) {
          navigator.popToRoot(context: context);
          applicationBloc.dispatchEvent(AccessTokenExpiredEvent());
        }
        return;
      }
      String message = '';
      if (state.failure!.message == INTERNET_ERROR_MESSAGE ||
          state.failure!.message == SOCKET_ERROR_MESSAGE) {
        message = AppLocalizations.shared.commonMessageConnectionError;
      } else if (state.failure!.message == SERVER_ERROR_MESSAGE) {
        message = AppLocalizations.shared.commonMessageServerMaintenance;
      } else {
        message = state.failure!.message ?? UNKNOWN_EXCEPTION;
      }
      showAlert(
        context: context,
        message: message,
        primaryColor: AppColors.primaryColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () {
        bloc.onPageDidAppearEvent(
            PageDidAppearEvent(tag: widget.tag, context: context));
      },
      onFocusLost: () {
        bloc.onPageDidDisappearEvent(
            PageDidDisappearEvent(tag: widget.tag, context: context));
      },
      onForegroundLost: () {
        bloc.onAppEnterBackgroundEvent(
            AppEnterBackgroundEvent(context: context, tag: widget.tag));
      },
      onForegroundGained: () {
        bloc.onAppGainForegroundEvent(
            AppGainForegroundEvent(context: context, tag: widget.tag));
      },
      child: Provider<R>(
        create: (_) => router,
        child: Scaffold(
          // backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: BlocProvider<T>(
            create: (context) => bloc,
            child: BlocListener<T, BaseState>(listener: (context, state) async {
              stateListenerHandler(state);
              final res = await router.onNavigateByState(
                  context: context, state: state);
              bloc.onRouteNavigationResult(res);
            }, child: LayoutBuilder(builder: (sub, _) {
              subContext = sub;
              return buildLayout(subContext, bloc);
            })),
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    bloc.dispose();
    bloc.close();
    super.dispose();
  }
}
