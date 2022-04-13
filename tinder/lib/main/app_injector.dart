import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tinder/data/local/index.dart';
import 'package:tinder/data/remote/api/index.dart';
import 'package:tinder/data/remote/base/index.dart';
import 'package:tinder/data/repository/index.dart';
import 'package:tinder/domain/usecase/user/get_liked_users_usecase.dart';
import 'package:tinder/domain/usecase/user/get_passed_users_usecase.dart';
import 'package:tinder/domain/usecase/user/liked_user_usecase.dart';
import 'package:tinder/domain/usecase/user/passed_user_usecase.dart';
import 'package:tinder/presentation/page/history/index.dart';

import 'package:tinder/presentation/page/matching/index.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/network/network_status.dart';
import '../data/net/index.dart';
import '../domain/provider/index.dart';
import '../domain/repository/index.dart';
import '../domain/usecase/index.dart';
import '../presentation/page/home/index.dart';
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
  injector.registerLazySingleton<UserCache>(() => UserCacheImpl());

  // Repository
  injector.registerFactory<UserRepository>(() => UserRepositoryImpl(
        injector(),
        injector(),
      ));
  //Bloc
  injector.registerFactory<MatchingBloc>(() => MatchingBloc(
        fetchUsersUsecase: injector(),
        likedUserUsecase: injector(),
        passUserUserUsecase: injector(),
      ));
  injector.registerFactory<HomeBloc>(() => HomeBloc());
  injector.registerFactory<HistoryBloc>(() => HistoryBloc(
      getLikedUsersUsecase: injector(), getPassedUsersUsecase: injector()));
  // router
  injector.registerFactory<MatchingRouter>(() => MatchingRouter());
  injector.registerFactory<HomeRouter>(() => HomeRouter());
  injector.registerFactory<HistoryRouter>(() => HistoryRouter());

  // use case
  injector.registerFactory<FetchMatchedUsersUsecase>(
      () => FetchMatchedUsersUsecaseImpl(injector()));
  injector.registerFactory<LikedUserUsecase>(
      () => LikedUserUsecaseImpl(injector()));
  injector.registerFactory<PassUserUserUsecase>(
      () => PassUserUserUsecaseImpl(injector()));
  injector.registerFactory<GetLikedUsersUsecase>(
      () => GetLikedUsersUsecaseImpl(injector()));
  injector.registerFactory<GetPassedUsersUsecase>(
      () => GetPassedUsersUsecaseImpl(injector()));
}
