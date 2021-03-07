import 'package:chat_demo/modules/settings/cubit/states.dart';
import 'package:chat_demo/shared/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());
  static SettingsCubit get(context) => BlocProvider.of(context);

  var users = FirebaseFirestore.instance.collection('users');

  var userData = {};

  getRealTimeData() {
    emit(SettingsLoadingDataState());
    users.doc(getUserId()).snapshots().listen((event) {
      emit(SettingsSuccessDataState());
      userData = event.data();
      saveFirstName(firstName: userData['firstName']);
      saveLastName(lastName: userData['lastName']);
    }).onError((handleError) {
      emit(SettingsErrorState());
      print(handleError.toString());
    });
  }
}
