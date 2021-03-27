import 'package:chat_demo/modules/home/home_screen.dart';
import 'package:chat_demo/modules/profile/cubit/cubit.dart';
import 'package:chat_demo/modules/profile/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoScreen extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                          '${getFirstName() ?? 'Username'} ${getLastName() ?? ''}',
                          style: textBlack18(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          showCursor: false,
                          controller: firstNameController,
                          decoration: InputDecoration(
                            hintText: getLanguage(context).firstName,
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
                            hintText: getLanguage(context).lastName,
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
                    child: buildRaisedButton(
                      onPressed: () {
                        ProfileCubit.get(context)
                            .updateUser(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                            )
                            .then((value) => navigateTo(
                                context: context, widget: HomeScreen()));
                        ProfileCubit.get(context).clearTextField(
                            firstNameController: firstNameController,
                            lastNameController: lastNameController);
                      },
                      text: getLanguage(context).continu,
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
