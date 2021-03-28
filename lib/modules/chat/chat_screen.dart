import 'package:chat_demo/modules/chat/cubit/cubit.dart';
import 'package:chat_demo/modules/chat/cubit/states.dart';
import 'package:chat_demo/modules/image/image_screen.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  final String userId;
  final messageController = TextEditingController();

  ChatScreen({this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()
        ..getFriendData(
          userId: userId,
        )
        ..getMessages(friendId: userId),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {
          if (state is ChatSuccessFriendState)
            print(ChatCubit.get(context).data['firstName']);
        },
        builder: (context, state) {
          return Directionality(
            textDirection: changeDirection(context),
            child: Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildProfileAvatar(
                        profileData: ChatCubit.get(context).data),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${ChatCubit.get(context).data['firstName']} ${ChatCubit.get(context).data['lastName']}',
                            style: textWhiteBold14(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            '${ChatCubit.get(context).data['status']}',
                            style: textWhiteBold12(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // actions: [
                //   GestureDetector(
                //     child: Icon(Icons.videocam),
                //     onTap: () {
                //       print('Photo Camera');
                //     },
                //   ),
                //   SizedBox(
                //     width: 15.0,
                //   ),
                //   GestureDetector(
                //     child: Icon(Icons.phone),
                //     onTap: () {
                //       print('Phone Call');
                //     },
                //   ),
                //   SizedBox(
                //     width: 15.0,
                //   ),
                //   GestureDetector(
                //     child: Icon(Icons.more_vert),
                //     onTap: () {
                //       print('More');
                //     },
                //   ),
                //   SizedBox(
                //     width: 10.0,
                //   ),
                // ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ListView.separated(
                      reverse: true,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 2.0,
                        );
                      },
                      itemCount: ChatCubit.get(context).messagesList.length,
                      itemBuilder: (context, index) {
                        if (ChatCubit.get(context).messagesList[index]
                                ['userId'] ==
                            getUserId())
                          return myItemMessage(
                            context: context,
                            message: ChatCubit.get(context).messagesList[index],
                            messageDate: ChatCubit.get(context).getCurrentDate(
                              date: ChatCubit.get(context).messagesList[index]
                                  ['date'],
                            ),
                          );

                        if (ChatCubit.get(context).messagesList[index]
                                ['userId'] ==
                            userId)
                          return userItemMessage(
                            context: context,
                            message: ChatCubit.get(context).messagesList[index],
                            messageDate: ChatCubit.get(context).getCurrentDate(
                              date: ChatCubit.get(context).messagesList[index]
                                  ['date'],
                            ),
                            profileData: ChatCubit.get(context).data,
                          );
                        if (ChatCubit.get(context).messagesList.length == 0)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        return Container();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: kGreyColor(),
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                color: kGreyColor(),
                                width: 1.0,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: messageController,
                                    maxLines: null,
                                    cursorHeight: 20.0,
                                    cursorColor: kMainColor(),
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Typing message...',
                                        hintStyle: textGrey14(),
                                        contentPadding:
                                            EdgeInsets.only(left: 10.0)),
                                    onChanged: (value) {
                                      ChatCubit.get(context).typingNow(
                                        value: value,
                                      );
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    navigateTo(
                                      context: context,
                                      widget: ImageScreen(
                                        userId: userId,
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    color: kGreyColor500(),
                                  ),
                                  splashRadius: 20.0,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.mic_none_outlined,
                                    color: kGreyColor500(),
                                  ),
                                  splashRadius: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        CircleAvatar(
                          radius: 23.0,
                          child: IconButton(
                            splashRadius: 25.0,
                            icon: Icon(
                              Icons.send,
                              size: 24.0,
                            ),
                            onPressed: ChatCubit.get(context).isTyping
                                ? () {
                                    ChatCubit.get(context).createChat(
                                      friendId: userId,
                                    );
                                    ChatCubit.get(context).sendMessage(
                                      friendId: userId,
                                      message: messageController.text,
                                      date: DateTime.now(),
                                    );
                                    messageController.clear();
                                  }
                                : null,
                            color: kWhiteColor(),
                          ),
                        ),
                      ],
                    ),
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
