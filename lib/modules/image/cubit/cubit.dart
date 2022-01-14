import 'dart:io';

import 'package:chat_demo/modules/image/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImageCubit extends Cubit<ImageStates> {
  ImageCubit() : super(ImageInitialStates());

  static ImageCubit get(context) => BlocProvider.of(context);

  var users = FirebaseFirestore.instance.collection('users');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  dynamic image;
  String? imageName;
  String imageUr = '';

  Map<String, dynamic> data = {};

  final picker = ImagePicker();

  Future getImage() async {
    emit(ImagePickStates());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(ImagePickEndStates());
      image = File(pickedFile.path);
      imageName = image.path.split('/').last;
      uploadFile();
    } else {
      image = null;
    }
  }

  // Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load('assets/$path');

  //   final file = File('${(await getTemporaryDirectory()).path}/$path');
  //   await file.writeAsBytes(byteData.buffer
  //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  //   return file;
  // }

  Future<void> uploadFile() async {
    emit(ImageUploadStates());
    try {
      await storage.ref(imageName).putFile(image).then((value) {
        emit(ImageUploadSuccessStates());
        print(value.ref.fullPath);
        imageUrl();
      });
    } catch (e) {
      // e.g, e.code == 'canceled'
      print(e.toString());
    }
  }

  Future<void> imageUrl() async {
    try {
      emit(ImageUrlStates());
      await storage.ref(imageName).getDownloadURL().whenComplete(() {
        print('success');
      }).then((value) {
        emit(ImageUrlSuccessStates());
        print(value);
        imageUr = value;
      });
    } catch (e) {
      // e.g, e.code == 'canceled'
      print(e.toString());
    }
  }

  void sendMessage({
    required String imageName,
    required date,
    required String friendId,
    context,
  }) {
    emit(ImageSendStates());
    users
        .doc(getUserId())
        .collection('chats')
        .doc(friendId)
        .collection('messages')
        .add(
      {
        'imageName': imageName,
        'date': date,
        'userId': getUserId(),
        'message': null,
      },
    ).then((value) {
      users
          .doc(friendId)
          .collection('chats')
          .doc(getUserId())
          .collection('messages')
          .add(
        {
          'imageName': imageName,
          'date': date,
          'userId': getUserId(),
          'message': null,
        },
      ).then((value) {
        emit(ImageSendSuccessStates());
        print(friendId);
        Navigator.pop(context);
      });
    });
  }

  getFriendData({required String userId}) {
    emit(LoadingFriendState());
    users.doc(userId).snapshots().listen((event) {
      emit(SuccessFriendState());
      data = event.data()!;
    });
  }
}
