import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio;
  DioHelper() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm/send',
      ),
    );
  }

  static Future<Response> postData({
    path,
    data,
    token,
    query,
  }) async {
    if (token != null) {
      dio.options.headers = {
        'Authorization': 'key= $token',
      };
    }
    return await dio.post(
      path,
      data: data ?? null,
      queryParameters: query ?? null,
    );
  }
}
