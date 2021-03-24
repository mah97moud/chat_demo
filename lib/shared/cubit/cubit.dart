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
  bool isRtf = false;

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
    changeDirection(
      code,
    );
  }

  void loadLanguage({
    @required String languageJson,
  }) {
    languageModel = LanguageModel.fromJson(languageJson);
    print(languageJson);
    emit(LoadLanguageState());
  }

  void changeDirection(languageCode) {
    if (languageCode == 'ar') {
      isRtf = true;
      saveDirection(isRtf: isRtf);
    } else {
      isRtf = false;
      saveDirection(isRtf: isRtf);
    }
    emit(ChangeDirectionState());
  }

  // void isRTL({bool isRTl}) {
  //   if (isRTl) {
  //     textDirectionApp = TextDirection.rtl;
  //   } else {
  //     textDirectionApp = TextDirection.ltr;
  //   }
  // }
}
