import 'dart:convert';

import 'package:bench_test_service/model/response/countries.dart';
import 'package:bench_test_service/model/response/get_user_response.dart';
import 'package:bench_test_service/model/response/signup_question_response.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

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

  String baseUrl = 'https://innercircle.caapidsimplified.com/api';

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
      print(response.data);
      return LoginResponse.fromJson(response.data);
    } on DioError catch (err) {
      throw ErrorResponse.fromJson(err.response.data);
    }
  }

  Future resetPasswordCodeVerification(String mail, String code) async {
    try {
      http.Response response =
          await http.post('$baseUrl/reset-password/code/verify', body: {
        "email": mail,
        "code": code,
      });
      if (response.statusCode == 422) {
        throw jsonDecode(response.body)["message"];
      }
      return "Valid code";
    } catch (error) {
      throw jsonDecode(error)["message"];
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

  Future resetPassword(String mail, String newPassword) async {
    try {
      Response response = await dio.post('/reset-password',
          data: {"email": mail, "password": newPassword});
      return LoginResponse.fromJson(response.data);
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

  getCountries(String token) async {
    try {
      Response response = await dio.get('/countries',
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }));
      // if ((response.data)["message"] == "already answered") {
      //   return [];
      // }
      return CountryResponse.fromJson(response.data);
    } on DioError catch (err) {
      throw ErrorResponse.fromJson(err.response.data);
    }
  }

  getQuestions(String token) async {
    try {
      Response response = await dio.get('/signup-questions',
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }));
      if ((response.data)["message"] == "already answered") {
        return SignupQuestionResponse(message: []);
      } else {
        print('reached');
        print(SignupQuestionResponse.fromJson(response.data));
        return SignupQuestionResponse.fromJson(response.data);}
    } on DioError catch (err) {
      throw ErrorResponse.fromJson(err.response.data);
    }
  }

  postAnswers(List<int> answers, String token) async {
    if (answers.length == 0) throw "answers must not be empty";
    try {
      Response response = await dio.post('/signup-answers',
          data: {"answers": answers},
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          }));
      return response.data['message'];
    } on DioError catch (err) {
      throw ErrorResponse.fromJson(err.response.data);
    }
  }

  getAllAnswers(String token) async {
    try {
      Response response = await dio.get('/exercise/all',
          options: Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token"
            },
          ));
      return CountryResponse.fromJson(response.data);
    } on DioError catch (exception) {
      throw ErrorResponse.fromJson(exception.response.data);
    }
  }
}
