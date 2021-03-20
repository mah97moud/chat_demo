import 'package:chat_demo/modules/chat/chat_screen.dart';
import 'package:chat_demo/modules/home/cubit/cubit.dart';
import 'package:chat_demo/modules/settings/settings_screen.dart';
import 'package:chat_demo/modules/users/users_screen.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getMyChats()
        ..getRealTimeData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is HomeSuccessMyChatsState)
            print(HomeCubit.get(context).myChats.length);
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! HomeLoadingState,
            fallback: (context) => Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            builder: (context) => Scaffold(
              backgroundColor: kWhiteColor(),
              appBar: AppBar(
                elevation: 0.0,
                title: InkWell(
                  onTap: () {
                    navigateTo(context: context, widget: SettingsScreen());
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: getUserImage() != null
                            ? NetworkImage(getUserImage())
                            : AssetImage('assets/images/default.jpg'),
                        // backgroundColor: kBlueColor(),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        '${getFirstName() ?? 'Username'}  ${getLastName() ?? ''}',
                        style: textWhite20(),
                      ),
                    ],
                  ),
                ),
                actions: [
                  GestureDetector(
                    child: Icon(Icons.search),
                    onTap: () {
                      print('Search');
                    },
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  GestureDetector(
                    child: Icon(Icons.more_vert),
                    onTap: () {
                      print('More');
                    },
                  ),
                ],
              ),
              body: ConditionalBuilder(
                condition: state is! HomeLoadingMyChatsState,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chats',
                          style: textGreyBold18(),
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: HomeCubit.get(context).myChats.length,
                            itemBuilder: (context, index) {
                              return buildItem(
                                onTap: () {
                                  navigateTo(
                                    context: context,
                                    widget: ChatScreen(
                                      userId: HomeCubit.get(context)
                                          .myChats[index]['userId'],
                                    ),
                                  );
                                },
                                item: HomeCubit.get(context).myChats[index],
                              );
                            },
                            separatorBuilder: (context, index) => Container(
                              height: 2.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 'cameraButton',
                    onPressed: () {},
                    child: Icon(
                      Icons.camera_alt,
                      color: kGreyColor500(),
                    ),
                    backgroundColor: kWhiteColor(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FloatingActionButton(
                    heroTag: 'users',
                    onPressed: () {
                      navigateTo(context: context, widget: UsersScreen());
                    },
                    child: Icon(Icons.create),
                    backgroundColor: kBlueColor(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
