import 'package:chat_demo/modules/profile/profile_screen.dart';
import 'package:chat_demo/modules/settings/cubit/cubit.dart';
import 'package:chat_demo/modules/settings/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:chat_demo/shared/cubit/cubit.dart';
import 'package:chat_demo/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        return Directionality(
          textDirection: changeDirection(context),
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
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                    getUserPhone().toString(),
                                    style: Theme.of(context).textTheme.caption,
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return buildAlertDialog(
                                  title: getLanguage(context).changeLanguage,
                                  context: context,
                                  value: appCubit(context).isDark,
                                  onChange: (isDark) {
                                    appCubit(context).changeAppTheme(isDark);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        buildRaisedButton(
                                          onPressed: () {
                                            AppCubit.get(context)
                                                .changeLanguage(
                                              code: 'en',
                                            )
                                                .then(
                                              (value) {
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                          text: getLanguage(context).english,
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        buildRaisedButton(
                                          onPressed: () {
                                            AppCubit.get(context)
                                                .changeLanguage(
                                              code: 'ar',
                                            )
                                                .then(
                                              (value) {
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                          text: getLanguage(context).arabic,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          leading: Icon(
                            Icons.translate_outlined,
                          ),
                          contentPadding: EdgeInsets.only(left: 0.0),
                          title: Column(
                            children: [
                              Text(
                                getLanguage(context).changeLanguage,
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                getLanguage(context).selectCode,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return buildAlertDialog(
                                  title: getLanguage(context).changeMode,
                                  context: context,
                                  value: getIsDark(),
                                  onChange: (isDark) {
                                    appCubit(context).changeAppTheme(isDark);
                                  },
                                  text: getIsDark()
                                      ? getLanguage(context).dark
                                      : getLanguage(context).light,
                                );
                              },
                            );
                          },
                          leading: Icon(
                            Icons.wb_sunny_rounded,
                          ),
                          contentPadding: EdgeInsets.only(left: 0.0),
                          title: Column(
                            children: [
                              Text(getLanguage(context).appearance),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                getLanguage(context).changeMode,
                                style: Theme.of(context).textTheme.caption,
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
      },
      listener: (context, state) {},
    );
  }
}
