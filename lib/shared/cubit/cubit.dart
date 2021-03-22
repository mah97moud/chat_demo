import 'package:chat_demo/shared/cubit/states.dart';
import 'package:chat_demo/shared/localization/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitState());
  static AppCubit get(context) => BlocProvider.of(context);

  LanguageModel languageModel;
  TextDirection textDirectionApp = TextDirection.ltr;

  loadLanguage({
    @required String languageJson,
  }) {
    languageModel = LanguageModel.fromJson(languageJson);
    emit(LoadLanguageState());
  }

  void changeDirection({TextDirection textDirection}) {
    textDirectionApp = textDirection;
    emit(ChangeDirectionState());
  }
}
