import 'package:chat_demo/modules/test_screen/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/states.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
          ),
          BlocProvider(
            create: (_) => TestCubit(),
            child: BlocConsumer<TestCubit, TestStates>(
              builder: (_, state) {
                return RaisedButton(
                  onPressed: () {
                    TestCubit.get(_).sendMessage();
                  },
                  child: Text(
                    'Post Message',
                  ),
                );
              },
              listener: (BuildContext context, state) {},
            ),
          ),
        ],
      ),
    );
  }
}
