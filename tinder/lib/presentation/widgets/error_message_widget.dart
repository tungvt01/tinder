import 'package:tinder/presentation/styles/index.dart';
import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String error;
  final TextStyle? style;

  const ErrorMessageWidget(
    this.error, {
    this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(error,
        maxLines: 10,
        style: style ??
            titleMedium.copyWith(
                color: AppColors.redDraken, fontWeight: FontWeight.w400));
  }
}
