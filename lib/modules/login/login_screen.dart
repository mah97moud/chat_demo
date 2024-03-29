import 'package:chat_demo/modules/login/cubit/cubit.dart';
import 'package:chat_demo/modules/login/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final phoneController = TextEditingController();
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        builder: (context, state) {
          return Scaffold(
            body: ConditionalBuilder(
              condition: state is! LoginLoadingState,
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) => SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          getLanguage(context)!.enterNumber,
                          textAlign: TextAlign.center,
                          style: textBlackBold20().copyWith(
                            fontSize: 22.0,
                          ),
                        ),
                        Container(
                          width: 270.0,
                          child: Text(
                            getLanguage(context)!.receiveNotificationCode,
                            style: textBlack14(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 60.0,
                              height: 50.0,
                              child: TextFormField(
                                controller: codeController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: getLanguage(context)!.code,
                                  hintText: '+',
                                  hintStyle: textBlackBold20(),
                                  labelStyle: textBlackBold14().copyWith(
                                    color: kBlueColor(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: Container(
                                width: 250.0,
                                height: 50.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: phoneController,
                                  // maxLength: 10,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    labelText:
                                        getLanguage(context)!.phoneNumber,
                                    labelStyle: textBlackBold14().copyWith(
                                      color: kBlueColor(),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.0,
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        buildRaisedButton(
                          text: getLanguage(context)!.next,
                          onPressed: () {
                            print(phoneController.text);
                            print(codeController.text);
                            LoginCubit.get(context).phoneVerification(
                              code: codeController.text,
                              phone: phoneController.text,
                              context: context,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is LoginErrorState)
            showToastApp(
              errorMsg: getLanguage(context)!.numberError,
            );
        },
      ),
    );
  }
}
