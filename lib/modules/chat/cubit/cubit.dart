import 'package:chat_demo/modules/chat/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());
  static ChatCubit get(context) => BlocProvider.of(context);

  var users = FirebaseFirestore.instance.collection('users');
  String finalDate = '';
  Map<String, dynamic> data = {};
  List messagesList = [];
  bool isTyping = false;

  String getCurrentDate({date}) {
    emit(ChatCurrentDateState());
    var dateParse = DateTime.parse(date.toDate().toString());
    var formattedDate = "${dateParse.hour}:${dateParse.minute}";
    return formattedDate.toString();
  }

  getFriendData({@required String userId}) {
    emit(ChatLoadingFriendState());
    users.doc(userId).snapshots().listen((event) {
      emit(ChatSuccessFriendState());
      data = event.data();
    });
  }

  void createChat({@required String friendId}) {
    emit(ChatCreateState());
    users.doc(getUserId()).collection('chats').doc(friendId).set(data).then(
      (value) {
        users.doc(friendId).collection('chats').doc(getUserId()).set({
          'firstName': getFirstName(),
          'lastName': getLastName(),
          'userId': getUserId(),
          'imagePath': getUserImage(),
          'phone': getUserPhone(),
          'status': 'offline',
        }).then(
          (value) {
            emit(ChatSuccessCreateState());
          },
        ).catchError((onError) {});
      },
    ).catchError((onError) {});
  }

  void sendMessage({
    @required String message,
    @required date,
    @required String friendId,
  }) {
    emit(ChatSendingMessageState());
    users
        .doc(getUserId())
        .collection('chats')
        .doc(friendId)
        .collection('messages')
        .add(
      {
        'message': message,
        'date': date,
        'userId': getUserId(),
        'imageName': null,
      },
    ).then((value) {
      users
          .doc(friendId)
          .collection('chats')
          .doc(getUserId())
          .collection('messages')
          .add(
        {
          'message': message,
          'date': date,
          'userId': getUserId(),
          'imageName': null,
        },
      ).then((value) {
        emit(ChatSendSuccessState());
      });
      print(date);
    });
  }

  void getMessages({@required String friendId}) {
    emit(ChatGettingMessageState());
    users
        .doc(getUserId())
        .collection('chats')
        .doc(friendId)
        .collection('messages')
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      emit(ChatGetSuccessState());
      messagesList = event.docs;
    });
  }

  void typingNow({
    @required value,
  }) {
    if (value.length != 0) {
      emit(ChatTypingState());
      isTyping = true;
      updateUser(typing: 'Typing');
      getFriendData(userId: data['userId']);
    } else {
      emit(ChatStopTypingState());
      isTyping = false;
      updateUser(typing: 'online');
      getFriendData(userId: data['userId']);
    }
  }

  Future<void> updateUser({String typing}) {
    return users
        .doc(getUserId())
        .update({
          'status': typing,
        })
        .then((value) {})
        .catchError((error) => print("Failed to update user: $error"));
  }
}
