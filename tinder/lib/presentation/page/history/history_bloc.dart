import 'package:tinder/domain/usecase/user/get_liked_users_usecase.dart';
import 'package:tinder/domain/usecase/user/get_passed_users_usecase.dart';
import 'package:tinder/presentation/base/index.dart';
import 'index.dart';

class HistoryBloc extends BaseBloc<BaseEvent, HistoryState> {
  GetLikedUsersUsecase getLikedUsersUsecase;
  GetPassedUsersUsecase getPassedUsersUsecase;
  HistoryBloc({
    required this.getLikedUsersUsecase,
    required this.getPassedUsersUsecase,
  }) : super(initState: HistoryState(users: [])) {
    on<FetchLikedUsersEvent>(((event, emit) => _onFetchLikedUser(emit)));
    on<FetchPassedUsersEvent>(((event, emit) => _onFetchPassUser(emit)));
  }

  _onFetchLikedUser(Emitter<HistoryState> emitter) async {
    emitter(state.copyWith(loadingStatus: ExecuteStatus.loading));
    final results = await getLikedUsersUsecase.getLikedUsers();

    await results.fold((failure) async {
      emitter(state.copyWith(
          failure: failure, loadingStatus: ExecuteStatus.failure));
    }, (r) async {
      emitter(state.copyWith(users: r, loadingStatus: ExecuteStatus.success));
    });
  }

  _onFetchPassUser(Emitter<HistoryState> emitter) async {
    emitter(state.copyWith(loadingStatus: ExecuteStatus.loading));
    final results = await getPassedUsersUsecase.getPassedUsers();

    await results.fold((failure) async {
      emitter(state.copyWith(
          failure: failure, loadingStatus: ExecuteStatus.failure));
    }, (r) async {
      emitter(state.copyWith(users: r, loadingStatus: ExecuteStatus.success));
    });
  }

  @override
  dispose() {}
}
