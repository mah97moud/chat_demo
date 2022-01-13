import 'dart:io';

import 'package:chat_demo/modules/profile/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());
  static ProfileCubit get(context) => BlocProvider.of(context);

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  dynamic userData = {};
  List? myChats = [];

  File image = File('');
  String? imagePath;
  String imageUr = '';

  final picker = ImagePicker();

  Future getImage() async {
    emit(ProfilePickImageState());
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(ProfilePickImageSuccessState());
      image = File(pickedFile.path);
      imagePath = image.path.split('/').last;
      uploadFile();
    } else {
      // image = null;
      print('No image selected.');
    }
  }

  Future<void> uploadFile() async {
    try {
      emit(ProfileUpLoadState());
      await storage.ref(getUserId()).putFile(image!).then((value) {
        emit(ProfileUpLoadSuccessState());
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
      emit(ProfileGetUrlState());
      await storage.ref(getUserId()).getDownloadURL().whenComplete(() {
        print('success');
      }).then((value) {
        emit(ProfileGetUrlSuccessState());
        print(value);
        imageUr = value;
        updateUserImage();
      });
    } catch (e) {
      // e.g, e.code == 'canceled'
      print(e.toString());
    }
  }

  Future<void> updateUser({String? firstName, String? lastName}) async {
    emit(ProfileSendState());
    //TODO : make firstName and lastName != null
    if (firstName!.length != 0 && lastName!.length != 0) {
      return users.doc(getUserId()).update({
        'firstName': firstName,
        'lastName': lastName,
      }).then((value) {
        emit(ProfileSendSuccessState());
        print(firstName.length);
        getRealTimeData();
        print(getFirstName());
        print(getLastName());
      }).catchError((error) => print("Failed to update user: $error"));
    }
    if (firstName.length != 0 && lastName!.length == 0) {
      return users.doc(getUserId()).update({
        'firstName': firstName,
        'lastName': '',
      }).then((value) {
        emit(ProfileSendSuccessState());
        print(firstName.length);
        getRealTimeData();
        print(getFirstName());
        print(getLastName());
      }).catchError((error) => print("Failed to update user: $error"));
    }
    if (firstName.length == 0 && lastName!.length != 0) {
      return users.doc(getUserId()).update({
        'firstName': '',
        'lastName': lastName,
      }).then((value) {
        emit(ProfileSendSuccessState());
        print(firstName.length);
        getRealTimeData();
        print(getFirstName());
        print(getLastName());
      }).catchError((error) => print("Failed to update user: $error"));
    }
    if (firstName.length == 0 && lastName!.length == 0) {
      return users.doc(getUserId()).update({
        'firstName': getFirstName(),
        'lastName': getLastName(),
      }).then((value) {
        emit(ProfileSendSuccessState());
        print(firstName.length);
        getRealTimeData();
        print(getFirstName());
        print(getLastName());
      }).catchError((error) => print("Failed to update user: $error"));
    }
  }

  Future<void> updateUserImage() {
    emit(ProfileUpLoadImageUrlState());
    return users.doc(getUserId()).update({
      'imagePath': imageUr,
    }).then((value) {
      emit(ProfileSendImageSuccessState());
      getRealTimeData();
    }).catchError((error) => print("Failed to update user: $error"));
  }

  void clearTextField({firstNameController, lastNameController}) {
    emit(ProfileClearState());
    firstNameController.clear();
    lastNameController.clear();
  }

  getRealTimeData() {
    emit(ProfileGetDataState());
    users.doc(getUserId()).snapshots().listen((event) {
      emit(ProfileGetDataSuccessState());
      userData = event.data();
      saveUserImage(imagePath: userData['imagePath']);
      saveUserPhone(phone: userData['phone']);
      saveFirstName(firstName: userData['firstName']);
      saveLastName(lastName: userData['lastName']);
    }).onError((handleError) {
      emit(ProfileErrorState());
      print(handleError.toString());
    });
  }
}
