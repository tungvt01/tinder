import 'package:flutter/material.dart';
import 'package:tinder/presentation/styles/app_colors.dart';
import 'package:tinder/presentation/styles/text_style.dart';

class CustomRadio<T> extends StatefulWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String title;
  const CustomRadio(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.title})
      : super(key: key);

  @override
  _CustomRadioState createState() => _CustomRadioState<T>();
}

class _CustomRadioState<T> extends State<CustomRadio<T>> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);

    return InkWell(
      onTap: () {
        widget.onChanged(widget.value);
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gray[300]!)),
              child: Icon(
                Icons.circle,
                size: 17,
                color: selected ? AppColors.primaryColor : Colors.transparent,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.title,
              style: bodyMedium.copyWith(color: AppColors.gray[400]!),
            ),
          ],
        ),
      ),
    );
  }
}
