import 'package:intl/intl.dart';

extension DateTimeDisplayString on DateTime {
  String toDateAndTimeString() {
    final formatter = DateFormat('yyyy/MM/dd HH:mm');
    return formatter.format(this);
  }
}
