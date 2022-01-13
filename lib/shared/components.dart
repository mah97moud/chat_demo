import 'package:chat_demo/modules/view_image/view_image_screen.dart';
import 'package:chat_demo/shared/cubit/cubit.dart';
import 'package:chat_demo/shared/localization/language_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Color components
Color kMainColor() => Color(0xff3B7744);
Color kGreenColor() => Color(0xff00ff00);
Color kWhiteColor() => Color(0xffffffff);
Color kBlackColor() => Color(0xff000000);
Color kBlueColor() => Color(0xff2C6BEE);
Color kGreyColor() => Color(0xffE9E9E9);
Color kGreyColor500() => Color(0xff8b8b8b);
Color kYellowColor() => Color(0xffffd481);
Color kGreyDaColor() => Color(0xffcacdd2);
//TextStyle component

TextStyle textBlack12() => TextStyle(
      fontSize: 12.0,
      color: kBlackColor(),
    );
TextStyle textBlack14() => TextStyle(
      fontSize: 14.0,
      color: kBlackColor(),
    );
TextStyle textBlack16() => TextStyle(
      fontSize: 16.0,
      color: kBlackColor(),
    );
TextStyle textBlack18() => TextStyle(
      fontSize: 18.0,
      color: kBlackColor(),
    );
TextStyle textBlack20() => TextStyle(
      fontSize: 20.0,
      color: kBlackColor(),
    );
TextStyle textBlackBold12() => TextStyle(
      fontSize: 12.0,
      color: kBlackColor(),
      fontWeight: FontWeight.bold,
    );
TextStyle textBlackBold14() => TextStyle(
      fontSize: 14.0,
      color: kBlackColor(),
      fontWeight: FontWeight.bold,
    );
TextStyle textBlackBold16() => TextStyle(
      fontSize: 16.0,
      color: kBlackColor(),
      fontWeight: FontWeight.bold,
    );
TextStyle textBlackBold18() => TextStyle(
      fontSize: 18.0,
      color: kBlackColor(),
      fontWeight: FontWeight.bold,
    );
TextStyle textBlackBold20() => TextStyle(
      fontSize: 20.0,
      color: kBlackColor(),
      fontWeight: FontWeight.bold,
    );
TextStyle textGrey12() => TextStyle(
      fontSize: 12.0,
      color: kGreyColor500(),
    );
TextStyle textGrey14() => TextStyle(
      fontSize: 14.0,
      color: kGreyColor500(),
    );
TextStyle textGrey16() => TextStyle(
      fontSize: 16.0,
      color: kGreyColor500(),
    );
TextStyle textGrey18() => TextStyle(
      fontSize: 18.0,
      color: kGreyColor500(),
    );
TextStyle textGrey20() => TextStyle(
      fontSize: 20.0,
      color: kGreyColor500(),
    );
TextStyle textGreyBold12() => TextStyle(
      fontSize: 12.0,
      color: kGreyColor500(),
      fontWeight: FontWeight.bold,
    );
TextStyle textGreyBold14() => TextStyle(
      fontSize: 14.0,
      color: kGreyColor500(),
      fontWeight: FontWeight.bold,
    );
TextStyle textGreyBold16() => TextStyle(
      fontSize: 16.0,
      color: kGreyColor500(),
      fontWeight: FontWeight.bold,
    );
TextStyle textGreyBold18() => TextStyle(
      fontSize: 18.0,
      color: kGreyColor500(),
      fontWeight: FontWeight.bold,
    );
TextStyle textGreyBold20() => TextStyle(
      fontSize: 20.0,
      color: kGreyColor500(),
      fontWeight: FontWeight.bold,
    );
TextStyle textWhite12() => TextStyle(
      fontSize: 12.0,
      color: kWhiteColor(),
    );
TextStyle textWhite14() => TextStyle(
      fontSize: 14.0,
      color: kWhiteColor(),
    );
TextStyle textWhite16() => TextStyle(
      fontSize: 16.0,
      color: kWhiteColor(),
    );
TextStyle textWhite18() => TextStyle(
      fontSize: 18.0,
      color: kWhiteColor(),
    );
TextStyle textWhite20() => TextStyle(
      fontSize: 20.0,
      color: kWhiteColor(),
    );
TextStyle textWhiteBold12() => TextStyle(
      fontSize: 12.0,
      color: kWhiteColor(),
      fontWeight: FontWeight.bold,
    );
TextStyle textWhiteBold14() => TextStyle(
      fontSize: 14.0,
      color: kWhiteColor(),
      fontWeight: FontWeight.bold,
    );
TextStyle textWhiteBold16() => TextStyle(
      fontSize: 16.0,
      color: kWhiteColor(),
      fontWeight: FontWeight.bold,
    );
TextStyle textWhiteBold18() => TextStyle(
      fontSize: 18.0,
      color: kWhiteColor(),
      fontWeight: FontWeight.bold,
    );
TextStyle textWhiteBold20() => TextStyle(
      fontSize: 20.0,
      color: kWhiteColor(),
      fontWeight: FontWeight.bold,
    );

//Navigate Method

void navigateTo(
        {required context, required Widget widget, Function? setState}) =>
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish({
  required context,
  required Widget widget,
}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false);
}

//Widget Component

Widget buildRaisedButton({
  required GestureTapCallback onPressed,
  required String text,
  TextStyle? style,
}) {
  return Container(
    width: double.infinity,
    height: 40.0,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        textAlign: TextAlign.center,
        style: style,
      ),
    ),
  );
}

//Build user Item

Widget buildItem({
  required GestureTapCallback onTap,
  item,
  TextStyle? style,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.only(
        top: 20.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildProfileAvatar(profileData: item, radius: 22.0),
          SizedBox(
            width: 15.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${item['firstName'] + ' ' + item['lastName']}',
                style: style,
              ),
              // SizedBox(
              //   height: 5.0,
              // ),
              // Text(
              //   'This is the instruction manual.',
              //   style: textGrey14(),
              // ),
            ],
          ),
          Spacer(),
          // Column(
          //   children: [
          //     Text(
          //       'Now',
          //       style: textBlackBold14(),
          //     ),
          //     Container(
          //       width: 30.0,
          //       child: Stack(
          //         children: [
          //           Align(
          //             child: CircleAvatar(
          //               radius: 8.0,
          //               backgroundColor: kGreyColor500(),
          //               child: Icon(
          //                 Icons.check,
          //                 size: 10.0,
          //                 color: kWhiteColor(),
          //               ),
          //             ),
          //           ),
          //           Align(
          //             child: CircleAvatar(
          //               radius: 8.0,
          //               backgroundColor: kGreyColor500(),
          //               child: Icon(
          //                 Icons.check,
          //                 size: 10.0,
          //                 color: kWhiteColor(),
          //               ),
          //             ),
          //             alignment: Alignment.centerRight,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    ),
  );
}

//Message Item
Widget myItemMessage({@required message, @required messageDate, context}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(60.0, 5.0, 15.0, 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (message['message'] != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    message['message'],
                    style: textBlack14(),
                  ),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: kGreyColor(),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                      topRight: Radius.circular(0.0),
                      topLeft: Radius.circular(15.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: 5.0,
                  ),
                  child: Text(
                    messageDate,
                    style: textBlackBold12().copyWith(
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (message['imageName'] != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(
                      context: context,
                      widget: ViewImageScreen(
                        image: message['imageName'],
                      ),
                    );
                  },
                  child: Container(
                    child: Image(
                      image: NetworkImage(message['imageName']),
                      fit: BoxFit.contain,
                      height: 300.0,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: kGreyColor(),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: 5.0,
                  ),
                  child: Text(
                    messageDate,
                    style: textBlackBold12().copyWith(
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget userItemMessage(
    {@required message,
    @required messageDate,
    @required profileData,
    context}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: 15.0,
      vertical: 5.0,
    ),
    child: Row(
      children: [
        buildProfileAvatar(profileData: profileData),
        SizedBox(
          width: 10.0,
        ),
        if (message['message'] != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    message['message'],
                    style: textWhite14(),
                  ),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: kMainColor(),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(0.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 5.0,
                  ),
                  child: Text(
                    messageDate,
                    style: textBlackBold12().copyWith(
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (message['imageName'] != null)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(
                      context: context,
                      widget: ViewImageScreen(
                        image: message['imageName'],
                      ),
                    );
                  },
                  child: Container(
                    child: Image(
                      image: NetworkImage(message['imageName']),
                      fit: BoxFit.contain,
                      height: 300.0,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: kGreyColor(),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: 5.0,
                  ),
                  child: Text(
                    messageDate,
                    style: textBlackBold12().copyWith(
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

//End of Item

//Profile Avatar
Stack buildProfileAvatar({required profileData, double radius = 18.0}) {
  return Stack(
    alignment: Alignment.bottomRight,
    children: [
      CircleAvatar(
        radius: radius,
        backgroundImage: AssetImage('assets/images/default.jpg'),
      ),
      if (profileData['status'] == 'online' ||
          profileData['status'] == 'Typing')
        CircleAvatar(
          backgroundColor: kWhiteColor(),
          radius: 7.0,
          child: CircleAvatar(
            radius: 5.0,
            backgroundColor: kGreenColor(),
          ),
        ),
    ],
  );
}
//End Profile Avatar

// End Of Widgets

//SharedPreferences

SharedPreferences? preferences;

Future<void> initPref() async => await SharedPreferences.getInstance().then(
      (value) {
        preferences = value;
      },
    );

Future<bool> saveFirstName({required String firstName}) =>
    preferences!.setString('firstName', firstName);
Future<bool> saveLastName({required String lastName}) =>
    preferences!.setString('LastName', lastName);

Future<bool> saveUserId({required String userId}) =>
    preferences!.setString('userId', userId);

Future<bool> saveUserImage({required String imagePath}) =>
    preferences!.setString('imagePath', imagePath);

Future<bool> saveUserPhone({required String? phone}) =>
    preferences!.setString('phone', phone!);
Future<bool> saveLanguageCode({required String code}) =>
    preferences!.setString('code', code);
Future<bool> saveDirection({required bool isRtf}) =>
    preferences!.setBool('isRtf', isRtf);
Future<bool> saveIsDark({required bool isDark}) =>
    preferences!.setBool('isDark', isDark);

String getFirstName() => preferences!.get('firstName').toString();
String getLastName() => preferences!.get('LastName').toString();
String getUserId() => preferences!.get('userId').toString();
String getUserImage() => preferences!.get('imagePath').toString();
String getUserPhone() => preferences!.get('phone').toString();
String getLanguageCode() => preferences!.get('code').toString();
bool? getDirection() => preferences!.getBool('isRtf');
bool? getIsDark() => preferences!.getBool('isDark');

// End of SharedPreferences

LanguageModel? getLanguage(context) => AppCubit.get(context).languageModel;
TextDirection changeDirection(context) =>
    getDirection() == true ? TextDirection.rtl : TextDirection.ltr;
appCubit(context) => AppCubit.get(context);

String code = 'en';

//Toast

void showToastApp({
  required String errorMsg,
}) =>
    Fluttertoast.showToast(
      msg: errorMsg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

// Start Dialog

AlertDialog buildAlertDialog({
  required BuildContext context,
  String? text,
  required String title,
  required bool value,
  required Function(bool value) onChange,
  Widget? child,
}) {
  return AlertDialog(
    title: Text(title),
    content: child ??
        Row(
          children: [
            Text(
              text!,
              style: Theme.of(context).textTheme.headline6,
            ),
            Spacer(),
            CupertinoSwitch(
              value: value,
              onChanged: onChange,
            ),
          ],
        ),
  );
}

//End Dialog
