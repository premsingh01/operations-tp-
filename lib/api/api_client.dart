import 'package:dio/dio.dart';

class ApiClient {
  Dio init() {
    Dio _dio = Dio();
    _dio.options.baseUrl = 'https://fakestoreapi.com';
    return _dio;
  }
}
