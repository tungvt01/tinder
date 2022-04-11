import 'dart:async';

import 'package:tinder/data/remote/api/index.dart';

const cardNumberRegex = r'^[0-9]{15,18}$';
const cvvRegex = r"^[0-9]{3,4}$";
const expiredDateRegex = r"^[0-9]{2}/[0-9]{4}$";
// final emailRegex = r"^[^.-]+[a-zA-Z0-9.-]+[^.-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
const emailRegex =
    r"^[a-zA-Z0-9]+([\-]?)+([\._]?[a-zA-Z0-9])+([\._(?!.*?\.\.)]?)@[^@][a-z0-9\-]{2,}(\.[a-z0-9]{2,4}){1,2}$";
// final phoneNumberRegex =
//     r"^[+]{1}[1-9]{2}([0-9]+){9,}$|^0([0-9]+){9,}$|^([+]{0,1}([0-9]+-[0-9]+)+[0-9]+$|^[+]{0,1}([0-9]+ [0-9]+)+[0-9]+){9,}$";
const userNameRegex = ".+"; //r"^[a-zA-Z0-9_\\-\\.]+$";
const passwordRegex =
    r'^[a-zA-Z0-9\u0027\|\{\}@#$%^&+=*.,\-_!`\[\]";:<>?/\\]+$';
const searchPhoneRegex = r"^[0-9\\s]+$";
const residentIdRegex = r"^[0-9]{8,12}$";
const idCardRegex = r"^[0-9]{9,12}$";
const bankAccountRegex = r"^[0-9]{8,15}$";
const userIdInputRegex = r"^[a-zA-Z0-9]*$";
const onlyNumbersRegex = r'[^\d]';
const phoneNumberRegex = r'^[0-9]+$';

// final emailRegister = r'^[a-zA-Z0-9]+([\-]?)+([\._]?[a-zA-Z0-9\-])+([\._]?)*([a-zA-Z0-9])@[a-zA-Z0-9\-]([\._]?[a-zA-Z0-9\-])*(\.\w{2,})+$';
const emailRegister =
    r'(?![a-zA-Z0-9._@-]*[.-]{2,}[a-zA-Z0-9._@-]*$)([a-zA-Z0-9._-]+)([a-zA-Z0-9]@[a-zA-Z0-9])([a-zA-Z0-9.-]+)([a-zA-Z0-9]\.[a-zA-Z]{2,3})+$';
const passwordRegister = r'^[a-zA-Z0-9@#$%^&+=*.\-_]{6,}$';

typedef ValidatorFunction = bool Function(String, String?);

const int MIN_LENGTH_PASSWORD = 6;
const int MAX_LENGTH_PASSWORD = 6;
const int MAX_LENGTH_NAME = 256;
const int MAX_LENGTH_KANA_NAME = 50;
const int MAX_LENGTH_OCCUPATION = 50;
const int VALID_LENGTH_ZIPCODE = 7;
const int MAX_LENGTH_ADDRESS = 100;
const int MAX_LENGTH_PHONE = 11;
const int MAX_LENGTH_EMAIL = 256;
const int MAX_LENGTH_SALON_NAME = 256;
const int MAX_LENGTH_ID_CARD = 12;

class Validators {
  final validatePasswordTransformer =
      StreamTransformer<String, bool>.fromHandlers(
          handleData: (password, sink) {
    RegExp regex = RegExp(passwordRegex);
    sink.add(regex.hasMatch(password));
  });

  static bool isPasswordValid(String inputPassword, String? text) {
    RegExp regex = RegExp(passwordRegister);
    return regex.hasMatch(inputPassword);
  }

  static bool isPhoneNumberValid(String inputPhoneNumber, String? text) {
    RegExp regex = RegExp(phoneNumberRegex);
    return regex.hasMatch(inputPhoneNumber);
  }

  static bool isEmailValid(String email, String? text) {
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  static bool isTheSameText(String password, String? passwordConfirm) {
    return password == passwordConfirm;
  }

  static bool isFullNameValid(String inputFullName, String? text) {
    return inputFullName.isNotEmpty;
  }

  static bool isIdCardValid(String idCard, String? text) {
    RegExp regex = RegExp(idCardRegex);
    return regex.hasMatch(idCard);
  }
}
