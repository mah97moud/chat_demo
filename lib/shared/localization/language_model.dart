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
  final String darkMode;
  final String changeMode;
  final String appearance;
  final String users;

  LanguageModel({
    required this.numberError,
    required this.enterNumber,
    required this.receiveNotificationCode,
    required this.chats,
    required this.takePrivacy,
    required this.beYourself,
    required this.message,
    required this.continu,
    required this.termsPrivacy,
    required this.phoneNumber,
    required this.code,
    required this.next,
    required this.enterCode,
    required this.verify,
    required this.firstName,
    required this.lastName,
    required this.profile,
    required this.save,
    required this.text,
    required this.settings,
    required this.username,
    required this.language,
    required this.english,
    required this.arabic,
    required this.selectCode,
    required this.changeLanguage,
    required this.dark,
    required this.light,
    required this.darkMode,
    required this.changeMode,
    required this.appearance,
    required this.users,
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
      darkMode: json['dark-mode'] as String,
      changeMode: json['changeMode'] as String,
      appearance: json['appearance'] as String,
      users: json['users'] as String,
    );
  }
}
