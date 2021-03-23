import 'package:chat_demo/shared/components.dart';
import 'package:chat_demo/shared/cubit/states.dart';
import 'package:chat_demo/shared/localization/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitState());
  static AppCubit get(context) => BlocProvider.of(context);

  LanguageModel languageModel;
  TextDirection textDirectionApp = TextDirection.ltr;

  void changeLanguage({
    @required String code,
  }) async {
    String translation =
        await rootBundle.loadString('assets/translations/$code.json');

    loadLanguage(
      languageJson: translation,
    );
    saveLanguageCode(code: code);
    emit(ChangeLanguageState());
  }

  void loadLanguage({
    @required String languageJson,
  }) {
    languageModel = LanguageModel.fromJson(languageJson);
    print(languageJson);
    emit(LoadLanguageState());
  }

  void changeDirection({TextDirection textDirection}) {
    textDirectionApp = textDirection;
    emit(ChangeDirectionState());
  }
}
