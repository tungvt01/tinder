import 'package:flutter/material.dart';
import 'package:tinder/core/utils/index.dart';
import 'package:tinder/presentation/utils/index.dart';
import 'package:tinder/presentation/widgets/index.dart';
import '../../resources/index.dart';
import '../../styles/index.dart';

class EmailInputWidget extends StatelessWidget {
  final PropertyController? controller;
  final Function(String)? onInputChanged;

  const EmailInputWidget({
    this.controller,
    this.onInputChanged,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return ValidatedInputField(
      style: bodyLarge.copyWith(color: AppColors.gray[800]!),
      hintText: AppLocalizations.shared.commonMessageEmailPlaceholder,
      propertyController: controller,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: emailFormatter,
      validator: Validators.isEmailValid,
      onInputChanged: onInputChanged,
    );
  }
}
