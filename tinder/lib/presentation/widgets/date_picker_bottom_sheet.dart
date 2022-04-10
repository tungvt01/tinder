import 'package:flutter/cupertino.dart';
import 'package:tinder/presentation/base/base_page_mixin.dart';
import 'package:tinder/presentation/navigator/page_navigator.dart';

class DatePickerBottomSheet {
  static Future<void> show(
      {required DateTime initialDate,
      required ValueChanged<DateTime> onDateChanged,
      required BuildContext context}) async {
    return await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DatePicker(
            initialDate: initialDate, onDateChanged: onDateChanged);
      },
    );
  }
}

class DatePicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;

  const DatePicker({
    Key? key,
    required this.initialDate,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    navigator.popBack(context: context);
                  },
                  child: SizedBox(
                    height: 36,
                    child: Icon(
                      Icons.close,
                      color: AppColors.gray[400],
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Chọn ngày",
                    style: titleMedium.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 44),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.white24,
          ),
          Column(
            children: [
              SizedBox(
                height: 250,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle:
                          titleLarge.copyWith(color: Colors.black),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    initialDateTime: widget.initialDate,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (date) => selectedDate = date,
                    use24hFormat: false,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    widget.onDateChanged(selectedDate!);
                  },
                  child: Ink(
                    color: Colors.transparent,
                    child: Center(
                      child: Text(AppLocalizations.shared.confirm,
                          style: titleMedium),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
