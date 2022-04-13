import 'package:tinder/domain/model/index.dart';
import 'package:tinder/domain/usecase/index.dart';
import 'package:tinder/domain/usecase/user/liked_user_usecase.dart';
import 'package:tinder/domain/usecase/user/passed_user_usecase.dart';
import 'package:tinder/presentation/base/index.dart';
import 'package:tinder/presentation/page/matching/index.dart';

class MatchingBloc extends BaseBloc<BaseEvent, MatchingState> {
  final FetchMatchedUsersUsecase fetchUsersUsecase;
  final LikedUserUsecase likedUserUsecase;
  final PassUserUserUsecase passUserUserUsecase;
  List<UserModel> _listUsers = [];
  int _currentPage = 0;

  MatchingBloc({
    required this.fetchUsersUsecase,
    required this.likedUserUsecase,
    required this.passUserUserUsecase,
  }) : super(initState: MatchingState()) {
    on<PageInitStateEvent>((e, m) => _onFetchingUser(m));
    on<LikedEvent>((e, m) => _onLikedEventHanlder(m));
    on<DislikedEvent>((e, m) => _onDislikedEventHanlder(m));
  }

  _onFetchingUser(Emitter<MatchingState> emitter) async {
    emitter(state.copyWith(loadingStatus: ExecuteStatus.loading));
    final results = await fetchUsersUsecase.fetchUsers(
        params: FetchUsersParams(limit: 10, page: _currentPage));

    await results.fold((failure) async {
      emitter(state.copyWith(
          failure: failure, loadingStatus: ExecuteStatus.failure));
    }, (r) async {
      _listUsers = r.data;
      emitter(state.copyWith(
          listUsers: r.data, loadingStatus: ExecuteStatus.success));
    });
  }

  _onLikedEventHanlder(Emitter<MatchingState> emitter) async {
    final user = _listUsers.removeLast();
    final result = await likedUserUsecase.likeUser(likedUser: user);
    await result.fold((failure) async {
      emitter(state.copyWith(
          failure: failure, loadingStatus: ExecuteStatus.failure));
    }, (r) {
      emitter(state.copyWith(
          listUsers: _listUsers, loadingStatus: ExecuteStatus.success));
    });

    await _checkLoadmoreIfNeeds(emitter);
  }

  _onDislikedEventHanlder(Emitter<MatchingState> emitter) async {
    final user = _listUsers.removeLast();
    final result = await passUserUserUsecase.passedUser(likedUser: user);
    await result.fold((failure) async {
      emitter(state.copyWith(
          failure: failure, loadingStatus: ExecuteStatus.failure));
    }, (r) {
      emitter(state.copyWith(
          listUsers: _listUsers, loadingStatus: ExecuteStatus.success));
    });

    await _checkLoadmoreIfNeeds(emitter);
  }

  _checkLoadmoreIfNeeds(Emitter<MatchingState> emitter) async {
    if (_listUsers.isEmpty) {
      _currentPage++;
      await _onFetchingUser(emitter);
    }
  }

  @override
  dispose() {}
}
