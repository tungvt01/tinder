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
  String get appName => text('app_name');
  String get sessionExpiredMessage =>
      text('common_message_error_session_expired');
  String get commonMessageConnectionError =>
      text('common_message_connection_error');
  String get commonMessageServerMaintenance =>
      text('common_message_server_maintenance');
  String get commonMessagePasswordError =>
      text('common_message_password_error');
  String get commonMessageEmailError => text('common_message_email_error');
  String get commonMessageNoData => 'No Data';
  String get commonMessageEmailPlaceholder =>
      text('common_message_email_placeholder');

  String get commonMessagePasswordPlaceholder =>
      text('common_message_password_placeholder');
  String get commonMessagePasswordNotMatch =>
      text('common_message_password_not_match');
  String get commonMessageOtpFormatNotCorrect =>
      text('common_message_otp_format_not_correct');
  String get commonButtonConfirm => text('common_button_confirm');
  String get commonButtonNext => text('common_button_next');
  String get commonButtonChange => text('common_button_change');
  String get commonLabelFinish => text('common_label_finish');
  String get commonButtonApprove => text('common_button_approve');
  String get commonButtonReject => text('common_button_reject');

  String get loginPageForgetPasswordButton =>
      text('login_page_forget_password_button');
  String get loginPageLoginButton => text('login_page_login_button');
  String get requestOtpMessage => text('otp_request_message');
  String get requestOtpButton => text('otp_request_button');
  String get confirmPasswordOtpPlaceholder =>
      text('new_password_confirm_otp_placeholder');
  String get confirmPasswordNewPasswordPlaceholder =>
      text('new_password_confirm_password_placeholder');
  String get confirmPasswordRetypePasswordPlaceholder =>
      text('new_password_confirm_retype_password_placeholder');
  String get newPasswordConfirmOtpSentMessage =>
      text('new_password_confirm_otp_sent_message');
  String get commonTitleChangePassword => text('common_title_change_password');
  String get confirmCurrentPasswordPlaceHolder =>
      text('confirm_current_password_placeholder');
  String get currentPasswordNotMatchError =>
      text('confirm_current_password_not_match_message');
  String get changePasswordSuccessMessage =>
      text('change_password_success_message');
  String get changePasswordSuccessOpenProfileButton =>
      text('change_password_success_open_profile_button');
  String get createUserInfoPageChangeBtn => text('create_user_info_change_btn');
  String get createUserInfoPageCompany => text('create_user_info_company');
  String get createUserInfoPageCompanyHint =>
      text('create_user_info_company_hint');
  String get createUserInfoPagePhone => text('create_user_info_phone');
  String get createUserInfoPagePhoneHint => text('create_user_info_phone_hint');
  String get createUserInfoPageFirstName => text('create_user_info_fisrt_name');
  String get createUserInfoPageFirstNameHint =>
      text('create_user_info_fisrt_name_hint');
  String get createUserInfoPageLastName => text('create_user_info_last_name');
  String get createUserInfoPageLastNameHint =>
      text('create_user_info_last_name_hint');
  String get createUserInfoPageLicense => text('create_user_info_license');
  String get createUserInfoPageLicenseHint =>
      text('create_user_info_license_hint');
  String get createUserInfoPageExperience =>
      text('create_user_info_experience');
  String get createUserInfoPageExperienceHint =>
      text('create_user_info_experience_hint');
  String get createUserInfoPageDOB => text('create_user_info_dob');
  String get createUserInfoPageDOBHint => text('create_user_info_dob_hint');
  String get createUserInfoPageSex => text('create_user_info_sex');
  String get createUserInfoPageSexMale => text('create_user_info_sex_male');
  String get createUserInfoPageSexFemale => text('create_user_info_sex_female');
  String get createUserInfoPageSkill => text('create_user_info_skill');
  String get createUserInfoPageSkillHint => text('create_user_info_skill_hint');
  String get createUserInfoPageAddress => text('create_user_info_address');
  String get createUserInfoPageAddressHint =>
      text('create_user_info_address_hint');
  String get createUserInfoPageOffice => text('create_user_info_office');
  String get createUserInfoPageOfficeHint =>
      text('create_user_info_office_hint');
  String get confirm => text('confirm');

  String get homeListTaskTabName => text('home_list_task_tab_name');
  String get homeHistoryTabName => text('home_history_tab_name');
  String get homeProfileTabName => text('home_profile_tab_name');

  String get listTaskOpenningSegment => text('list_task_opening_segment');
  String get listTaskApprovedSegment => text('list_task_approved_segment');
  String get listTaskCanceledSegment => text('list_task_canceled_segment');

  String get taskDetailIdLabel => text('task_detail_task_id_label');
  String get taskDetailStartLocationLabel =>
      text('task_detail_start_location_label');
  String get taskDetailEndLocationLabel =>
      text('task_detail_end_location_label');
  String get taskDetailStatusWaitAnotherDriverLabel =>
      text('task_detail_status_waiting_another_driver_label');
  String get taskDetailStatusReadyToStartLabel =>
      text('task_detail_status_waiting_ready_to_start_label');
  String get taskDetailStatusStartLabel =>
      text('task_detail_status_start_label');

  Future<void> reloadLanguageBundle({required String languageCode}) async {
    String path = "assets/jsons/localization_jp.json";
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
