import 'package:bench_test_service/model/response/get_user_response.dart';
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
      return response.data['message'];
    } on DioError catch (err) {
      throw ErrorResponse.fromJson(err.response.data);
    }
  }

  updateCountry(int countryId, String token) async {
    try {
      Response response = await dio.put('/user-country',
          data: {"country": countryId},
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }));
      return response.data['message'];
    } on DioError catch (err) {
      throw ErrorResponse.fromJson(err.response.data);
    }
  }

  update(String name, String token) async {
    try {
      Response response = await dio.post('/user-data/update',
          data: {"name": name},
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }));
      return response.data['message'];
    } on DioError catch (err) {
      throw ErrorResponse.fromJson(err.response.data);
    }
  }

  fetch(String token) async {
    try {
      Response response = await dio.get('/user-data/get',
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          }));
      return GetUserResponse.fromJson(response.data['data'][0]);
    } on DioError catch (err) {
      throw ErrorResponse.fromJson(err.response.data);
    }
  }
}
