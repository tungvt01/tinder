import 'package:tinder/data/remote/base/index.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/domain/repository/user/user_repository.dart';
import 'package:tinder/presentation/base/index.dart';
import 'package:tinder/presentation/page/login/index.dart';

class LoginBloc extends BaseBloc<BaseEvent, LoginState> {
  LoginBloc() : super(initState: LoginState()) {
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
    emitter(NotCurrentUserState(user: state.user));
  }

  @override
  dispose() {}

  @override
  void onPageInitStateEvent(PageInitStateEvent event) async {
    super.onPageInitStateEvent(event);
    final users = await injector
        .get<UserRepository>()
        .fetchUsers(params: FetchUsersParams(limit: 10, page: 0));
  }
}
