import 'dart:async';
import 'dart:math';

import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

class NotifyProvider {
  static NotifyProvider shared = NotifyProvider._();

  int _notifyNumber = 0;
  int get notifyNumber => _notifyNumber;

  ReplaySubject<int> _notificationCountSubject =
      ReplaySubject<int>(sync: true, maxSize: 1);

  Stream<int> get notifyCountStream => _notificationCountSubject.stream;

  ReplaySubject<String> _notificationCountDisplaysubject =
      ReplaySubject<String>(sync: true, maxSize: 1);
  Stream<String> get notifyCountDisplayStream =>
      _notificationCountDisplaysubject.stream;
  StreamSubscription? _subscription;

  NotifyProvider._() {
    _subscription = notifyCountStream.listen((number) {
      final display =
          (number == 0) ? '' : ((number > 9) ? '9+' : number.toString());
      Logger().d('tungvt ---->> display number: $number');
      _notificationCountDisplaysubject.add(display);
    });
    _notificationCountSubject.add(_notifyNumber);
  }

  void setNotify({required int numberRead}) {
    this._notifyNumber = max(numberRead, 0);
    _notificationCountSubject.add(this._notifyNumber);
  }

  void increaseNotifyCount({required int increaseCount}) {
    this._notifyNumber += increaseCount;
    _notificationCountSubject.add(this._notifyNumber);
  }

  void decreaseNotifyCount({required int decreaseCount}) {
    this._notifyNumber -= decreaseCount;
    this._notifyNumber = max(this._notifyNumber, 0);
    _notificationCountSubject.add(this._notifyNumber);
  }

  dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
