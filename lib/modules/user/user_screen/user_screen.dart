import 'dart:io';

import 'package:chat_demo/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File _image;
  String imagePath = '';
  String imageUr = '';

  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: _image != null
                            ? FileImage(_image)
                            : AssetImage('assets/images/default.jpg'),
                      ),
                      CircleAvatar(
                        backgroundColor: kGreyColor(),
                        radius: 15.0,
                        child: Center(
                          child: IconButton(
                            splashRadius: 25.0,
                            color: kGreyColor500(),
                            iconSize: 15.0,
                            icon: Icon(Icons.camera_alt),
                            onPressed: () {
                              getImage();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${getFirstName() + ' ' + getLastName()}',
                    style: textBlack18(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    showCursor: false,
                    controller: firstNameController,
                    decoration: InputDecoration(
                      hintText: 'first name',
                      hintStyle: textGrey16(),
                      contentPadding: EdgeInsets.only(left: 15.0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kBlueColor(),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kBlueColor(),
                          width: 2.0,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kBlueColor(),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    showCursor: false,
                    controller: lastNameController,
                    decoration: InputDecoration(
                      hintText: 'last name',
                      hintStyle: textGrey16(),
                      contentPadding: EdgeInsets.only(left: 15.0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kBlueColor(),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kBlueColor(),
                          width: 2.0,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kBlueColor(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: buildMainButton(
                onPressed: () {
                  updateUser();
                  clearTextField();
                },
                text: 'save',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imagePath = _image.path.split('/').last;
        uploadFile();
        print(imagePath);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadFile() async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(imagePath)
          .putFile(_image)
          .then((value) {
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
      await storage.ref(imagePath).getDownloadURL().whenComplete(() {
        print('success');
      }).then((value) {
        print(value);
      });
    } catch (e) {
      // e.g, e.code == 'canceled'
      print(e.toString());
    }
  }

  Future<void> updateUser() {
    return users
        .doc(getUserId())
        .set({
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
        })
        .then((value) {})
        .catchError((error) => print("Failed to update user: $error"));
  }

  void clearTextField() {
    firstNameController.clear();
    lastNameController.clear();
  }
}
