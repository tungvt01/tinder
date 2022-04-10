import 'package:flutter/material.dart';
import 'package:tinder/core/utils/index.dart';
import 'package:tinder/presentation/widgets/index.dart';
import '../../resources/index.dart';
import '../../styles/index.dart';

class PasswordInputWidget extends StatelessWidget {
  final PropertyController? controller;
  final Function(String)? onInputChanged;
  final String? hintText;
  final ValidatorFunction? validator;

  const PasswordInputWidget({
    this.controller,
    this.onInputChanged,
    this.hintText,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValidatedInputField(
      style: bodyLarge.copyWith(color: AppColors.gray[800]!),
      hintText:
          hintText ?? AppLocalizations.shared.commonMessagePasswordPlaceholder,
      propertyController: controller,
      validator: validator ?? Validators.isPasswordValid,
      onInputChanged: onInputChanged,
      obscureText: true,
      isShowObscureControl: true,
    );
  }
}
