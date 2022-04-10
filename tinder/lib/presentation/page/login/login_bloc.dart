import 'package:tinder/core/error/failures.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/domain/usecase/index.dart';
import 'package:tinder/presentation/base/index.dart';
import 'package:tinder/presentation/page/login/index.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginBloc extends BaseBloc<BaseEvent, LoginState> {
  AuthenticationUseCases _authenticationUseCases;
  LogoutUseCase logoutUseCase;

  LoginBloc(
    this._authenticationUseCases,
    this.logoutUseCase,
  ) : super(initState: LoginState()) {
    on<TapBtnLoginEvent>((e, m) => _loginClickHandler(e.phone!, e.pass!, m));
    on<SignUpSuccessEvent>((e, m) => _loginClickHandler(e.phone!, e.pass!, m));
    on<NotMeButtonCLickEvent>(_onNotMeButtonClickHandler);
  }

  _loginClickHandler(
      String phone, String pass, Emitter<LoginState> emitter) async {
    emitter(state.copyWith(loadingStatus: ExecuteStatus.loading));
  }

  _onNotMeButtonClickHandler(
      BaseEvent event, Emitter<LoginState> emitter) async {
    final result = await logoutUseCase.logout(isRemoteLogout: false);
    emitter(NotCurrentUserState(user: state.user));
  }

  @override
  dispose() {}

  @override
  void onPageInitStateEvent(PageInitStateEvent event) {
    super.onPageInitStateEvent(event);
    //PushNotificationHandler.shared.setupPushNotification();
  }
}
