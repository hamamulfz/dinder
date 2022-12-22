import 'package:dio/dio.dart';

class BaseDio {
  dioInitialization() {
    final options = BaseOptions(
      baseUrl: "https://dog.ceo/api",
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    return Dio(options);
  }
}
