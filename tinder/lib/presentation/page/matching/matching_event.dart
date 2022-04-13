import 'package:tinder/domain/model/index.dart';
import 'package:tinder/presentation/base/index.dart';

class LikedEvent extends BaseEvent {
  final UserModel user;
  LikedEvent({required this.user});
}

class DislikedEvent extends BaseEvent {
  final UserModel user;
  DislikedEvent({required this.user});
}
