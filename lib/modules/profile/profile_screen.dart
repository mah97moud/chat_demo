import 'package:chat_demo/modules/profile/cubit/cubit.dart';
import 'package:chat_demo/modules/profile/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        return Directionality(
          textDirection: changeDirection(context),
          child: Scaffold(
            appBar: AppBar(
              title: Text(getLanguage(context).profile),
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
                        ConditionalBuilder(
                          builder: (context) {
                            return Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                if (getUserImage() != null)
                                  CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: NetworkImage(
                                      getUserImage(),
                                    ),
                                  ),
                                if (ProfileCubit.get(context).image != null)
                                  CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: FileImage(
                                        ProfileCubit.get(context).image),
                                  ),
                                if (getUserImage() == null &&
                                    ProfileCubit.get(context).image == null)
                                  CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage:
                                        AssetImage('assets/images/default.jpg'),
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
                                        ProfileCubit.get(context).getImage();
                                      },
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          condition: state is! ProfilePickImageState &&
                              state is! ProfileUpLoadState &&
                              state is! ProfileGetUrlState,
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '${getFirstName() ?? getLanguage(context).username} ${getLastName() ?? ''}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          showCursor: false,
                          controller: firstNameController,
                          decoration: InputDecoration(
                            hintText: getLanguage(context).firstName,
                            hintStyle: Theme.of(context).textTheme.subtitle1,
                            contentPadding: EdgeInsets.only(left: 15.0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: appCubit(context).isDark
                                    ? kYellowColor()
                                    : kBlueColor(),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: appCubit(context).isDark
                                    ? kYellowColor()
                                    : kBlueColor(),
                                width: 2.0,
                              ),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: appCubit(context).isDark
                                    ? kYellowColor()
                                    : kBlueColor(),
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          showCursor: false,
                          controller: lastNameController,
                          decoration: InputDecoration(
                            hintText: getLanguage(context).lastName,
                            hintStyle: Theme.of(context).textTheme.subtitle1,
                            contentPadding: EdgeInsets.only(left: 15.0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: appCubit(context).isDark
                                    ? kYellowColor()
                                    : kBlueColor(),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: appCubit(context).isDark
                                    ? kYellowColor()
                                    : kBlueColor(),
                                width: 2.0,
                              ),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: appCubit(context).isDark
                                    ? kYellowColor()
                                    : kBlueColor(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                getLanguage(context).text,
                                style: Theme.of(context).textTheme.subtitle1,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: buildRaisedButton(
                      onPressed: () {
                        ProfileCubit.get(context).updateUser(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                        );
                        ProfileCubit.get(context).clearTextField(
                            firstNameController: firstNameController,
                            lastNameController: lastNameController);
                      },
                      text: getLanguage(context).save,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
