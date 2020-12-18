import 'package:dio/dio.dart';

class BaseService {
  static final BaseService _instance = BaseService._initiator();
  Dio _dio;

  BaseService._initiator() {
    _dio = Dio(
      BaseOptions(baseUrl: "https://innercircle.caapidsimplified.com/api"),
    );
  }

  getClient() {
    return _dio;
  }

  factory BaseService() {
    return _instance;
  }
}
