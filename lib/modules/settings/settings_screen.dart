import 'package:chat_demo/modules/profile/profile_screen.dart';
import 'package:chat_demo/modules/settings/cubit/cubit.dart';
import 'package:chat_demo/modules/settings/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(getLanguage(context).settings),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(context: context, widget: ProfileScreen());
                  },
                  child: BlocProvider(
                    create: (context) => SettingsCubit()..getRealTimeData(),
                    child: BlocConsumer<SettingsCubit, SettingsStates>(
                      builder: (context, state) => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            backgroundImage: getUserImage() != null
                                ? NetworkImage(getUserImage())
                                : AssetImage('assets/images/default.jpg'),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${getFirstName() ?? getLanguage(context).username} ${getLastName() ?? ''}',
                                style: textBlackBold18(),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                getUserPhone().toString(),
                                style: textGreyBold12(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      listener: (context, state) {},
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 25.0,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.message,
                        color: kBlackColor(),
                      ),
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Column(
                        children: [
                          Text('SMS and MMS'),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            'Off',
                            style: textBlack14(),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.notifications,
                        color: kBlackColor(),
                      ),
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Column(
                        children: [
                          Text('Notifications'),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            'On',
                            style: textBlack14(),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.lock,
                        color: kBlackColor(),
                      ),
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Column(
                        children: [
                          Text('Privacy'),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            'Screen lock off, Registration lock off',
                            style: textBlack14(),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.wb_sunny_rounded,
                        color: kBlackColor(),
                      ),
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Column(
                        children: [
                          Text('Appearance'),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            'Theme System default,Language System default',
                            style: textBlack14(),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.image,
                        color: kBlackColor(),
                      ),
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Column(
                        children: [
                          Text('Chats and media'),
                          SizedBox(
                            height: 2.0,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.store,
                        color: kBlackColor(),
                      ),
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Column(
                        children: [
                          Text('Storage'),
                          SizedBox(
                            height: 2.0,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.link,
                        color: kBlackColor(),
                      ),
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Column(
                        children: [
                          Text('Linked devices'),
                          SizedBox(
                            height: 2.0,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.help,
                        color: kBlackColor(),
                      ),
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Column(
                        children: [
                          Text('Help'),
                          SizedBox(
                            height: 2.0,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.settings_ethernet,
                        color: kBlackColor(),
                      ),
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Column(
                        children: [
                          Text('Advanced'),
                          SizedBox(
                            height: 2.0,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.favorite,
                        color: kBlackColor(),
                      ),
                      trailing: Icon(
                        Icons.open_in_new_outlined,
                        color: kBlackColor(),
                      ),
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Column(
                        children: [
                          Text('Donate to App'),
                          SizedBox(
                            height: 2.0,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
