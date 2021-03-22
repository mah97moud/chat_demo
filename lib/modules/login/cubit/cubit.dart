import 'package:chat_demo/modules/login/cubit/states.dart';
import 'package:chat_demo/modules/verification/verification_screen.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> phoneVerification({
    @required String phone,
    @required String code,
    context,
  }) async {
    emit(LoginLoadingState());
    if (phone == "") {
      emit(LoginErrorState());
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+$code$phone',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int resendToken) {
          emit(LoginSuccessState());
          navigateTo(
            context: context,
            widget: VerificationScreen(
              code: verificationId,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }
}
