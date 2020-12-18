import 'package:dio/dio.dart';

import '../model/request/login.dart';
import '../model/request/register.dart';
import '../model/response/login.dart';
import '../model/response/register.dart';
import '../model/response/response_status.dart';
import 'base_service.dart';

class User {
  Dio dio;

  User() {
    dio = BaseService().getClient();
  }

  register(RegisterRequest registerRequest) async {
    try {
      Response response =
          await dio.post('/register', data: registerRequest.toJson());
      return RegisterResponse.fromJson(response.data);
    } on DioError catch (err) {
      throw ErrorResponse.fromJson(err.response.data);
    }
  }

  login(LoginRequest loginRequest) async {
    try {
      Response response = await dio.post('/login', data: loginRequest.toJson());
      return LoginResponse.fromJson(response.data);
    } on DioError catch (err) {
      throw ErrorResponse.fromJson(err.response.data);
    }
  }

  forgotPassword(String email) async {
    try {
      Response response =
          await dio.post('/forgot-password', data: {"email": email});
      // todo:  Remove
      return 'GK: It has bug in Backend do some other stuff';
      return response.data['message'];
    } on DioError catch (err) {
      // todo:  Remove
      return "GK: It has bug in Backend do some other stuff";
      throw ErrorResponse.fromJson(err.response.data);
    }
  }

  getUser() {}
}
