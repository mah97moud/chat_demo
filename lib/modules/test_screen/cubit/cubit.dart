import 'package:chat_demo/modules/test_screen/cubit/states.dart';
import 'package:chat_demo/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestCubit extends Cubit<TestStates> {
  TestCubit() : super(InitTestSt());
  static TestCubit get(context) => BlocProvider.of(context);

  void sendMessage() {
    emit(SendTestSt());
    DioHelper.postData(
      data: {
        "to":
            "doTKJAHWRR-Rm0PcmCgIvE:APA91bGxlX0b9hcU_NIm_HMp8LcO1FYfVgUJL8MTuREVlUX8-FZqG9wqGnuI8HoEk-0jC2bWf4XZ7i27TKMa2oP4aGJzhAp-6l2VFDPof8ms8XximAlAw5Pbuz6kBH-0uJ8Zq6hRKzFq",
        "notification": {
          "title": "Username",
          "body": "Message body",
          "sound": false
        },
        "data": {
          "title": "Data Payload Title",
          "description": "Data Payload is need to be handled",
          "timestamp": 4674467474
        },
        "content_available": true
      },
    ).then((value) {
      emit(SucTestSt());
      print(value.data);
    }).catchError((onError) {
      emit(ErrTestSt());
    });
  }
}
