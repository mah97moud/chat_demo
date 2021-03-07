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
              'Take Privacy with you.',
              style: textBlackBold20(),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Be yourself in every',
              style: textBlackBold20(),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'message.',
              style: textBlackBold20(),
            ),
            SizedBox(
              height: 40.0,
            ),
            buildMainButton(
              text: 'Continue',
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
                'Terms & Privacy Policy',
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
