import 'package:tinder/domain/usecase/index.dart';
import 'package:tinder/presentation/resources/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import '../data/net/index.dart';
import '../domain/provider/index.dart';
import '../domain/repository/index.dart';
import '../presentation/app/index.dart';
import '../presentation/base/index.dart';
import '../presentation/page/login/index.dart';
import '../presentation/widgets/index.dart';

late ApplicationBloc appBloc;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    appBloc.dispatchEvent(AppLaunched());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colors.transparent),
      ),
      home: LayoutBuilder(builder: (_context, snapshot) {
        return BlocBuilder<ApplicationBloc, BaseState>(
            bloc: appBloc,
            builder: (context, state) {
              final loadingView = ProgressHud(
                child: LoginPage(
                  pageTag: PageTag.login,
                ),
                inAsyncCall: true,
              );

              if (state is ApplicationState) {
                switch (state.tag) {
                  case AppLaunchTag.login:
                    return LoginPage(pageTag: PageTag.login);
                  default:
                    return loadingView;
                }
              }
              // loading view
              return loadingView;
            });
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    NotifyProvider.shared.dispose();
  }
}

class AppEntry {
  runWithFlavor({required EnviromentFlavor flavor}) async {
    WidgetsFlutterBinding.ensureInitialized();
    // Bloc.observer = blocMonitorDelegate;
    // await Firebase.initializeApp();
    await initializeDateFormatting('vi_VN');
    AppLocalizations.shared.reloadLanguageBundle(languageCode: 'vi');
    await initInjector();
    injector.get<EnviromentProvider>().setFlavor(flavor: flavor);
    await Future.wait([
      injector.get<EndPointProvider>().load(),
    ]);

    appBloc = ApplicationBloc(
        repository: injector<AuthenticationRepository>(),
        logoutUseCase: injector<LogoutUseCase>());

    runApp(
      MultiProvider(
        providers: [
          Provider<NotifyProvider>(create: (_) => NotifyProvider.shared),
        ],
        child: BlocProvider<ApplicationBloc>(
          create: (BuildContext context) => appBloc,
          child: const MyApp(),
        ),
      ),
    );
  }
}
