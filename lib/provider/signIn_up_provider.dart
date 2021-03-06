import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:bench_test_service/bench_test_service.dart';
import 'package:bench_test_service/service/exercise.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInUp with ChangeNotifier {
  String userErrorText;
  String emailErrorText;
  String passwordErrorText;

  bool passwordInvisible = true;

  bool isLoading = false;
  bool emailVerified = false;
  var logInResponse;

  void changePasswordVisibility() {
    passwordInvisible = !passwordInvisible;
    notifyListeners();
  }
  void clearData(){
    userErrorText=null;
    emailErrorText=null;
    passwordErrorText=null;
  }

  Future<void> signUp(
      userName, emailAddress, password, confirmPassword, context) async {
    userErrorText = null;
    emailErrorText = null;
    passwordErrorText = null;
    isLoading = true;
    notifyListeners();
    try {
      RegisterResponse registerResponse = await User().register(
          RegisterRequest(userName, emailAddress, password, password));
      logInResponse = registerResponse.data;
      // await Provider.of<UserLogData>(context, listen: false)
      //     .assigningData(logInResponse, context, "don'tInitialize");
      isLoading = false;
      notifyListeners();
    } on ErrorResponse catch (error) {
      isLoading = false;
      notifyListeners();
      var errorMessage = error.message;
      if (errorMessage.contains('name') || errorMessage.contains('Name')) {
        userErrorText = errorMessage;
        passwordErrorText = null;
        emailErrorText = null;
      } else if (errorMessage.contains('password') ||
          errorMessage.contains('Password')) {
        passwordErrorText = errorMessage;
        userErrorText = null;
        emailErrorText = null;
      } else if (errorMessage == 'Email already in Use.') {
        emailErrorText = errorMessage;
        userErrorText = null;
        passwordErrorText = null;
      } else if (errorMessage.contains('email') ||
          (errorMessage.contains('Email'))) {
        emailErrorText = errorMessage;
        userErrorText = null;
        passwordErrorText = null;
      }

      notifyListeners();
      throw errorMessage;
    }
  }

  Future<String> emailVerification(String email, int code) async {
    try {
      String message = await Exercise().emailVerification(email, code);
      emailVerified = true;
      notifyListeners();
      return message;
    } catch (error) {
      print('error $error');
      throw error;
    }
  }

  Future<String> resendCodeForVerification(String mail) async {
    try {
      String message = await Exercise().resendEmailVerification(mail);
      return message;
    } catch (error) {
      throw error;
    }
  }
}

class SignIn with ChangeNotifier {
  String emailErrorText;
  String passwordErrorText;

  bool passwordInvisible = true;
  String forgetEmailId;
  bool isLoading = false;

  void changePasswordVisibility() {
    passwordInvisible = !passwordInvisible;
    notifyListeners();
  }
  void changeLoading(){
    isLoading=!isLoading;
  }
  void clearData(){
    emailErrorText=null;
    passwordErrorText=null;
  }

  Future<dynamic> signIn(emailAddress, password, context) async {
    emailErrorText = null;
    var userData;
    var response;
    passwordErrorText = null;
    isLoading = true;
    notifyListeners();
    try {
      await User()
          .login(LoginRequest(emailAddress, password))
          .then((value) async {
        userData = value.data;
        response = await Provider.of<UserLogData>(context, listen: false)
            .assigningData(userData, context, "initializeSetUpQuestion");
      });
      if (response.isEmpty) {
        return [];
      }
      return [1];//1 refers, there is setup questions available for the user
    } catch (error) {
      print('ReachedError');
      print(error);
      isLoading = false;
      notifyListeners();
      var errorMessage = error.message;
      if (errorMessage.contains('password') ||
          errorMessage.contains('Invalid Credentials')) {
        passwordErrorText = errorMessage;
        emailErrorText = null;
      } else if (errorMessage.contains('email') ||
          (errorMessage.contains('User')) ||
          (errorMessage.contains('Invalid Credentials'))) {
        emailErrorText = errorMessage;
        passwordErrorText = null;
      }
      notifyListeners();
    }
  }

  Future<String> sendTheLink(String emailAddress) async {
    emailErrorText = null;
    forgetEmailId = emailAddress;
    try {
      String response = await User().forgotPassword(forgetEmailId);
      return response;
    } on ErrorResponse catch (error) {
      emailErrorText = error.message;
      throw emailErrorText;
    }
  }

  Future codeVerification(String code) async {
    try {
      var response =
          await User().resetPasswordCodeVerification(forgetEmailId, code);
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future changeUserPassword(String newPassword, context) async {
    try {
      LoginResponse userData =
          await User().resetPassword(forgetEmailId, newPassword);
      await Provider.of<UserLogData>(context, listen: false)
          .assigningData(userData.data, context, "don'tInitialize");
      return userData.message;
    } catch (error) {
      throw error;
    }
  }
}
