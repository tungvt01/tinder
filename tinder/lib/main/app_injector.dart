import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tinder/data/local/index.dart';
import 'package:tinder/data/remote/api/index.dart';
import 'package:tinder/data/remote/base/index.dart';
import 'package:tinder/data/repository/index.dart';

import 'package:tinder/presentation/page/login/index.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/network/network_status.dart';
import '../data/net/index.dart';
import '../domain/provider/index.dart';
import '../domain/repository/index.dart';
import '../domain/usecase/index.dart';
import '../presentation/utils/environment_provider_impl.dart';

GetIt injector = GetIt.asNewInstance();

initInjector() {
  // Utils
  injector.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  injector.registerLazySingleton<Connectivity>(() => Connectivity());
  injector.registerLazySingleton<EndPointProvider>(() => EndPointProvider());
  injector.registerLazySingleton<EnviromentProvider>(
      () => EnvironmentProviderImpl());
  injector.registerLazySingleton<NotifyProvider>(() => NotifyProvider.shared);
  //API
  injector.registerLazySingleton<ApiConfig>(() => ApiConfigImpl(
        enviromentProvider: injector(),
      ));
  injector.registerFactory<UserApi>(() => UserApiImpl());

  injector.registerLazySingleton<NetworkStatus>(
      () => NetworkStatusImpl(injector(), injector()));

  injector.registerFactory<RequestHeaderBuilder>(
      () => RequestHeaderBuilder(apiConfig: injector()));

  //Cache
  injector
      .registerFactory<LocalDataStorage>(() => SharePreferenceStorageImpl());

  // Repository
  injector.registerFactory<UserRepository>(() => UserRepositoryImpl(
        injector(),
      ));
  //Bloc
  injector.registerFactory<LoginBloc>(() => LoginBloc());
  // router
  injector.registerFactory<LoginRouter>(() => LoginRouter());

  // use case
  injector.registerFactory<FetchUsersUsecase>(
      () => FetchUsersUsecaseImpl(injector()));
}
