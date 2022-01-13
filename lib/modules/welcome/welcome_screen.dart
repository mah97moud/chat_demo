import 'package:chat_demo/modules/login/login_screen.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(60.0),
        child: Column(
          children: [
            SizedBox(
              height: 60.0,
            ),
            Expanded(
              child: Image(
                image: AssetImage('assets/images/welcome_logo.png'),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              getLanguage(context)!.takePrivacy,
              style: textBlackBold20(),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              getLanguage(context)!.beYourself,
              style: textBlackBold20(),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              getLanguage(context)!.message,
              style: textBlackBold20(),
            ),
            SizedBox(
              height: 40.0,
            ),
            buildRaisedButton(
              text: getLanguage(context)!.continu,
              onPressed: () {
                navigateTo(
                  context: context,
                  widget: LoginScreen(),
                );
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                getLanguage(context)!.termsPrivacy,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
