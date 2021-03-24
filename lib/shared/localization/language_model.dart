import 'dart:convert';

class LanguageModel {
  final String chats;
  final String takePrivacy;
  final String beYourself;
  final String message;
  final String continu;
  final String termsPrivacy;
  final String enterNumber;
  final String receiveNotificationCode;
  final String phoneNumber;
  final String code;
  final String next;
  final String numberError;
  final String enterCode;
  final String verify;
  final String firstName;
  final String lastName;
  final String profile;
  final String save;
  final String text;
  final String settings;
  final String username;
  final String language;
  final String english;
  final String arabic;
  final String selectCode;
  final String changeLanguage;
  final String dark;
  final String light;

  LanguageModel({
    this.numberError,
    this.enterNumber,
    this.receiveNotificationCode,
    this.chats,
    this.takePrivacy,
    this.beYourself,
    this.message,
    this.continu,
    this.termsPrivacy,
    this.phoneNumber,
    this.code,
    this.next,
    this.enterCode,
    this.verify,
    this.firstName,
    this.lastName,
    this.profile,
    this.save,
    this.text,
    this.settings,
    this.username,
    this.language,
    this.english,
    this.arabic,
    this.selectCode,
    this.changeLanguage,
    this.dark,
    this.light,
  });

  factory LanguageModel.fromJson(language) {
    Map<String, dynamic> json = jsonDecode(language);
    return LanguageModel(
      chats: json['chats'] as String,
      takePrivacy: json['take-privacy'] as String,
      beYourself: json['be-yourself'] as String,
      message: json['message'] as String,
      continu: json['continue'] as String,
      termsPrivacy: json['terms-privacy'] as String,
      enterNumber: json['enter-number'] as String,
      receiveNotificationCode: json['receive-notification-code'] as String,
      phoneNumber: json['phone-number'] as String,
      code: json['code'] as String,
      next: json['next'] as String,
      numberError: json['number-error'] as String,
      enterCode: json['enter-code'] as String,
      verify: json['verify'] as String,
      firstName: json['first-name'] as String,
      lastName: json['last-name'] as String,
      profile: json['profile'] as String,
      save: json['save'] as String,
      text: json['text'] as String,
      settings: json['settings'] as String,
      username: json['username'] as String,
      language: json['Language'] as String,
      english: json['english'] as String,
      arabic: json['arabic'] as String,
      selectCode: json['select-code'] as String,
      changeLanguage: json['change-language'] as String,
      dark: json['dark'] as String,
      light: json['light'] as String,
    );
  }
}
