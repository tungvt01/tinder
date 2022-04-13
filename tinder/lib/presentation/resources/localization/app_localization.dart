import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppLocalizations {
  static AppLocalizations shared = AppLocalizations._();
  Map<dynamic, dynamic> _localisedValues = {};

  AppLocalizations._();

  static AppLocalizations of(BuildContext context) {
    return shared;
  }

  String text(String key) {
    return _localisedValues[key] ?? "$key not found";
  }

  // defined text
  String get commonMessageConnectionError =>
      text('common_message_connection_error');
  String get commonMessageServerMaintenance =>
      text('common_message_server_maintenance');
  String get commonMessageNoData => text('common_message_no_data');
  String get sessionExpiredMessage => text('common_message_session_expired');

  Future<void> reloadLanguageBundle({required String languageCode}) async {
    String path = "assets/jsons/localization_en.json";
    String jsonContent = "";
    try {
      jsonContent = await rootBundle.loadString(path);
    } catch (_) {
      //use default Vietnamese
      jsonContent =
          await rootBundle.loadString("assets/jsons/localization_vi.json");
    }
    _localisedValues = json.decode(jsonContent);
  }
}
