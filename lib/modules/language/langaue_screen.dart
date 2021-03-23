import 'package:chat_demo/shared/components.dart';
import 'package:chat_demo/shared/cubit/cubit.dart';
import 'package:chat_demo/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return Directionality(
          textDirection: changeDirection(context),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                getLanguage(context).language,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildMainButton(
                    onPressed: () {
                      AppCubit.get(context).changeLanguage(
                        code: 'en',
                      );
                      AppCubit.get(context).changeDirection(
                        textDirection: TextDirection.ltr,
                      );
                    },
                    text: getLanguage(context).english,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildMainButton(
                    onPressed: () {
                      AppCubit.get(context).changeLanguage(
                        code: 'ar',
                      );
                      AppCubit.get(context).changeDirection(
                        textDirection: TextDirection.rtl,
                      );
                    },
                    text: getLanguage(context).arabic,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
