import 'package:intl/intl.dart';

extension StringToBool on String {
  bool toBoolValue() {
    if (isNotEmpty) {
      return toLowerCase() == 'true' || toLowerCase() == '1';
    }
    return false;
  }

  double? toDoubleValue() {
    if (isNotEmpty) {
      return double.tryParse(this);
    }
    return null;
  }

  int? toIntValue() {
    if (isNotEmpty) {
      return int.tryParse(this);
    }
    return null;
  }
}

extension DateTimeToString on DateTime {
  String formatToDayMonthYearString() {
    final _stringToDateTime = DateFormat('dd/MM/yyyy');
    return _stringToDateTime.format(this).toString();
  }
}

extension StringToDateTime on String {
  DateTime convertToDateTime() {
    final _stringToDateTime = DateFormat('yyyy-MM-dd HH:mm');
    return _stringToDateTime.parse(this);
  }

  DateTime convertToDateTimeddMMYY() {
    final _stringToDateTime = DateFormat('dd/MM/yyyy');
    return _stringToDateTime.parse(this);
  }

  DateTime convertToYearMonthDay() {
    final _stringToDateTime = DateFormat('yyyy-MM-dd');
    return _stringToDateTime.parse(this);
  }

  String formatToYearMonthDayString() {
    final _stringToDateTime = DateFormat('yyyy/MM/dd');
    return _stringToDateTime.format(DateTime.parse(this)).toString();
  }

  String formatToTimeString() {
    final _stringToTime = DateFormat('HH:mm');
    return _stringToTime.format(DateTime.parse(this)).toString();
  }

  DateTime convertToTime() {
    final _stringToTime = DateFormat('HH:mm');
    return _stringToTime.parse(this);
  }

  DateTime fromISOStringToDateTime() {
    return DateTime.parse(this);
  }
}

extension LongToDateString on int {
  String formatLongToDateTimeString() {
    var dt = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    return DateFormat('dd/MM/yyyy HH:mm').format(dt); // 31/12/2000, 22:00
  }
}

extension FormartMoney on int {
  String formatMoney() {
    final formatCurrency = NumberFormat.currency(locale: 'VI');
    return formatCurrency.format(this).toString();
  }
}
