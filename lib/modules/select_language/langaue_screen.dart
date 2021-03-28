import 'package:chat_demo/modules/welcome/welcome_screen.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:chat_demo/shared/cubit/cubit.dart';
import 'package:chat_demo/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectLanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return Directionality(
          textDirection: changeDirection(context),
          child: SafeArea(
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: AssetImage('assets/images/logo.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(
                          height: 70.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Select your Language",
                            style: textBlackBold20(),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "من فضلك اختر اللغه",
                            style: textBlackBold20(),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildRaisedButton(
                          onPressed: () {
                            AppCubit.get(context).changeLanguage(
                              code: 'en',
                            );
                            navigateTo(
                                context: context, widget: WelcomeScreen());
                          },
                          text: 'English',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        buildRaisedButton(
                          onPressed: () {
                            AppCubit.get(context).changeLanguage(
                              code: 'ar',
                            );
                            navigateTo(
                                context: context, widget: WelcomeScreen());
                          },
                          text: 'اللغه العربيه',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
