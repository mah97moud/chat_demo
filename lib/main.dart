import 'package:chat_demo/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/home/home_screen.dart';
import 'modules/profile/cubit/cubit.dart';
import 'modules/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initPref();

  var user = FirebaseAuth.instance.currentUser;
  Widget myWidget;
  if (user != null) {
    myWidget = HomeScreen();
  } else {
    myWidget = WelcomeScreen();
  }

  runApp(
    MyApp(
      myWidget: myWidget,
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  final Widget myWidget;

  const MyApp({@required this.myWidget});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  AppLifecycleState _lastLifecycleState;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      _lastLifecycleState = state;
      print(_lastLifecycleState.toString());
    });
  }

  void updateUserData({String status}) {
    users.doc(getUserId()).update({
      'status': status,
    }).then((value) {});
  }

  getToke() async {
    String token = await FirebaseMessaging().getToken();
    print(token.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (_lastLifecycleState == AppLifecycleState.inactive) {
      updateUserData(
        status: 'offline',
      );
      print('Not Active ->>>>' + _lastLifecycleState.toString());
    }
    if (_lastLifecycleState == AppLifecycleState.resumed) {
      updateUserData(
        status: 'online',
      );
      print('Active ->>>>' + _lastLifecycleState.toString());
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit()..getRealTimeData(),
        )
      ],
      child: MaterialApp(
        title: 'Chat App Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kMainColor(),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: kBlueColor(),
          ),
        ),
        home: widget.myWidget,
      ),
    );
  }
}