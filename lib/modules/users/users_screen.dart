import 'package:chat_demo/modules/chat/chat_screen.dart';
import 'package:chat_demo/modules/users/cubit/cubit.dart';
import 'package:chat_demo/modules/users/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          getLanguage(context)!.users,
        ),
      ),
      body: BlocProvider(
        create: (context) => UsersCubit()..getRealTimeData(),
        child: BlocConsumer<UsersCubit, UsersStates>(
          builder: (context, state) {
            return ConditionalBuilder(
              condition: state is! UsersLoadingState,
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) => Padding(
                padding: EdgeInsets.all(15.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (UsersCubit.get(context).usersData.length > 0)
                      ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (getUserId() !=
                              UsersCubit.get(context).usersData[index]
                                  ['userId'])
                            return buildItem(
                              style: Theme.of(context).textTheme.headline6,
                              // item: allUserData[index],
                              item: UsersCubit.get(context).usersData[index],
                              onTap: () {
                                navigateTo(
                                  context: context,
                                  widget: ChatScreen(
                                    userId: UsersCubit.get(context)
                                        .usersData[index]['userId'],
                                  ),
                                );
                              },
                            );
                          return Container();
                        },
                        separatorBuilder: (context, index) => Container(
                          height: 2.0,
                        ),
                        itemCount: UsersCubit.get(context).usersData.length,
                      ),
                    if (UsersCubit.get(context).usersData.length == 0)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
