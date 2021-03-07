import 'package:chat_demo/modules/home/home_screen.dart';
import 'package:chat_demo/modules/verification/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerificationCubit extends Cubit<VerificationStates> {
  VerificationCubit() : super(VerificationInitialState());

  static VerificationCubit get(context) => BlocProvider.of(context);

  String smsCode = '';

  Future<void> listenSms() async {
    await SmsAutoFill().listenForCode;
  }

  void codeVerification(
      {@required String smsCode,
      @required context,
      @required String firebaseCode}) {
    emit(VerificationLoadingState());
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: firebaseCode, smsCode: smsCode);

    FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then(
      (value) {
        saveUserPhone(phone: value.user.phoneNumber);
        saveUserId(userId: value.user.uid);
        FirebaseFirestore.instance.collection('users').doc(value.user.uid).set({
          'firstName': 'Username',
          'lastName': '',
          'userId': getUserId(),
          'imagePath':
              'https://previews.123rf.com/images/triken/triken1608/triken160800028/61320729-male-avatar-profile-picture-default-user-avatar-guest-avatar-simply-human-head-vector-illustration-i.jpg',
          'phone': getUserPhone(),
          'status': 'offline',
        }).then(
          (value) {
            emit(VerificationSuccessStates());
            navigateAndFinish(
              context: context,
              widget: HomeScreen(),
            );
          },
        ).catchError(
          (error) {
            emit(VerificationErrorState());
            // print(error.toString());
          },
        );
      },
    ).catchError(
      (e) {},
    );
  }
}
