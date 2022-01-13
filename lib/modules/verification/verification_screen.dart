import 'package:chat_demo/modules/verification/cubit/cubit.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'cubit/states.dart';

class VerificationScreen extends StatelessWidget {
  final String code;

  VerificationScreen({required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => VerificationCubit()..listenSms(),
        child: BlocConsumer<VerificationCubit, VerificationStates>(
          listener: (context, state) {},
          builder: (context, state) => SafeArea(
            child: Padding(
              padding: EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    getLanguage(context)!.enterCode,
                    style: textBlackBold18(),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: 250.0,
                    height: 50.0,
                    child: PinFieldAutoFill(
                      onCodeChanged: (value) {
                        VerificationCubit.get(context).smsCode = value!;
                      },
                      decoration: UnderlineDecoration(
                        colorBuilder: PinListenColorBuilder(
                          kMainColor(),
                          kBlueColor(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  buildRaisedButton(
                    onPressed: () {
                      VerificationCubit.get(context).codeVerification(
                        context: context,
                        smsCode: VerificationCubit.get(context).smsCode,
                        firebaseCode: this.code,
                      );
                    },
                    text: getLanguage(context)!.verify,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
