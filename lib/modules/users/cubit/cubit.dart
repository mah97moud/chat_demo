import 'package:chat_demo/modules/users/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersStates> {
  UsersCubit() : super(UsersInitialState());
  static UsersCubit get(context) => BlocProvider.of(context);

  var users = FirebaseFirestore.instance.collection('users');

  var usersData = [];
  List? usersList;

  getRealTimeData() {
    emit(UsersLoadingState());
    users.get().then((value) {
      emit(UsersSuccessState());
      value.docs.forEach((element) {
        usersData.add(element.data());
      });
      // print(usersData[1]);
    }).catchError((handleError) {
      emit(UsersErrorState());
      print(handleError.toString());
    });
  }
}
