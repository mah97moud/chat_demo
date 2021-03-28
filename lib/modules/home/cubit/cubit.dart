import 'package:chat_demo/modules/home/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  var users = FirebaseFirestore.instance.collection('users');

  var userData = {};
  var myChats = [];

  void getRealTimeData() {
    emit(HomeLoadingState());
    users.doc(getUserId()).snapshots().listen((event) {
      emit(HomeSuccessDataState());
      userData = event.data();
      saveUserImage(imagePath: userData['imagePath']);
      saveUserPhone(phone: userData['phone']);
      saveFirstName(firstName: userData['firstName']);
      saveLastName(lastName: userData['lastName']);
    }).onError((handleError) {
      emit(HomeErrorState());
      print(handleError.toString());
    });
  }

  void getMyChats() {
    emit(HomeLoadingMyChatsState());
    users.doc(getUserId()).collection('chats').get().then((value) {
      emit(HomeSuccessMyChatsState());
      print(value.docs);
      value.docs.forEach((element) {
        myChats.add(element.data());
      });
      // print(myChats[0]['imagePath'].toString());
    }).catchError((handleError) {
      emit(HomeErrorState());
      print(handleError.toString());
    });
  }
}
