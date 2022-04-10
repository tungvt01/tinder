import 'package:intl/intl.dart';

extension StringToBool on String {
  bool toBoolValue() {
    if (this.isNotEmpty) {
      return this.toLowerCase() == 'true' || this.toLowerCase() == '1';
    }
    return false;
  }

  double? toDoubleValue() {
    if (this.isNotEmpty) {
      return double.tryParse(this);
    }
    return null;
  }

  int? toIntValue() {
    if (this.isNotEmpty) {
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

extension StringLikeCardNumber on String {
  String formatNumberCard() {
    final String? number = this.replaceAll(RegExp(r'(?<=.{4})\d(?=.{4})'), '*');
    var buffer = new StringBuffer();
    for (int i = 0; i < number!.length; i++) {
      buffer.write(number[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != number.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    return buffer.toString();
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
    final formatCurrency = new NumberFormat.currency(locale: 'VI');
    return formatCurrency.format(this).toString();
  }
}
