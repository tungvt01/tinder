import 'package:tinder/presentation/base/index.dart';
import 'package:tinder/presentation/resources/index.dart';
import 'package:tinder/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'index.dart';

class LoginPage extends BasePage {
  const LoginPage({
    required PageTag pageTag,
    Key? key,
  }) : super(tag: pageTag, key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends BasePageState<LoginBloc, LoginPage, LoginRouter> {
  final PropertyController _emailController = PropertyController(
      initValidValue: true,
      initMessage: AppLocalizations.shared.commonMessageEmailError);

  final PropertyController _passwordController = PropertyController(
      initValidValue: true,
      initMessage: AppLocalizations.shared.commonMessagePasswordError);

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  bool get willListenApplicationEvent => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void stateListenerHandler(BaseState state) async {
    super.stateListenerHandler(state);
  }

  @override
  Widget buildLayout(BuildContext context, BaseBloc bloc) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      var page = SafeArea(
        child: GestureDetector(
          onTap: () => hideKeyboard(context),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppLogoWidget(),
                    const SizedBox(height: 50),
                    EmailInputWidget(
                      controller: _emailController,
                    ),
                    const SizedBox(height: 20),
                    PasswordInputWidget(
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 20),
                    const _LoginButton(),
                    const SizedBox(height: 20),
                    const _ForgotPasswordButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      return ProgressHud(
        child: page,
        inAsyncCall: state.loadingStatus == ExecuteStatus.loading,
      );
    });
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return SolidButton(title: AppLocalizations.shared.loginPageLoginButton);
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.read<LoginRouter>().onNavigateByEvent(
              context: context, event: OnForgotPasswordClickEvent());
        },
        child: Text(
          AppLocalizations.shared.loginPageForgetPasswordButton,
          style: bodyLarge.copyWith(color: AppColors.blue[400]),
        ));
  }
}
