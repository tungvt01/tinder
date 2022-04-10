import 'package:tinder/core/utils/validations.dart';
import 'package:flutter/services.dart';

List<TextInputFormatter> nameFormatter = [
  LengthLimitingTextInputFormatter(MAX_LENGTH_NAME),
];

List<TextInputFormatter> nameKanaFormatter = [
  LengthLimitingTextInputFormatter(MAX_LENGTH_KANA_NAME),
];

List<TextInputFormatter> occupationFormatter = [
  LengthLimitingTextInputFormatter(MAX_LENGTH_OCCUPATION),
];

List<TextInputFormatter> phoneNumberFormatter = [
  LengthLimitingTextInputFormatter(MAX_LENGTH_PHONE),
  FilteringTextInputFormatter.allow(
      RegExp(phoneNumberRegex)), // only allow number
];

List<TextInputFormatter> onlyNumberFormatter = [
  FilteringTextInputFormatter.allow(
      RegExp(phoneNumberRegex)), // only allow number
];

List<TextInputFormatter> passwordFormatter = [
  FilteringTextInputFormatter.deny(RegExp(r"[ ]")),
  LengthLimitingTextInputFormatter(MAX_LENGTH_PASSWORD),
  FilteringTextInputFormatter.allow(RegExp(phoneNumberRegex))
];

List<TextInputFormatter> emailFormatter = [
  FilteringTextInputFormatter.deny(RegExp(r"[ ]")),
  LengthLimitingTextInputFormatter(MAX_LENGTH_EMAIL),
];

List<TextInputFormatter> commonInputFormatter = [
  LengthLimitingTextInputFormatter(MAX_LENGTH_NAME),
];

List<TextInputFormatter> commonIdCard = [
  LengthLimitingTextInputFormatter(MAX_LENGTH_ID_CARD),
  FilteringTextInputFormatter.allow(RegExp(phoneNumberRegex)),
];
