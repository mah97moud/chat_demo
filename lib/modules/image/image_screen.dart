import 'package:chat_demo/modules/image/cubit/cubit.dart';
import 'package:chat_demo/modules/image/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageScreen extends StatelessWidget {
  final userId;

  const ImageScreen({@required this.userId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Chose Image'),
      ),
      backgroundColor: kGreyColor500(),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ImageCubit()..getFriendData(userId: userId),
          child: BlocConsumer<ImageCubit, ImageStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return ConditionalBuilder(
                condition:
                    state is! ImageUrlStates && state is! ImageUploadStates,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 400.0,
                            width: double.infinity,
                            child: ImageCubit.get(context).image != null
                                ? Image(
                                    image: FileImage(
                                        ImageCubit.get(context).image),
                                    fit: BoxFit.contain,
                                  )
                                : null,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton(
                                heroTag: 'pick',
                                onPressed: () {
                                  ImageCubit.get(context).getImage();
                                },
                                backgroundColor: kGreyColor(),
                                child: Icon(
                                  Icons.image,
                                  color: kBlackColor(),
                                ),
                              ),
                              FloatingActionButton(
                                heroTag: 'send',
                                onPressed: () {
                                  ImageCubit.get(context).sendMessage(
                                      imageName:
                                          ImageCubit.get(context).imageUr,
                                      date: DateTime.now(),
                                      friendId: ImageCubit.get(context)
                                          .data['userId'],
                                      context: context);
                                },
                                backgroundColor: kGreyColor(),
                                child: Icon(
                                  Icons.send,
                                  color: kBlackColor(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                fallback: (context) => Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
