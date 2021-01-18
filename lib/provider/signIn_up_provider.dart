import 'package:bench_test_buddies/provider/user_data_token.dart';

import 'package:flutter/material.dart';
import 'package:bench_test_service/bench_test_service.dart';

class SignInUp with ChangeNotifier {
  String userErrorText;
  String emailErrorText;
  String passwordErrorText;

  bool passwordInvisible = true;

  bool isLoading = false;

  void changePasswordVisibility() {
    passwordInvisible = !passwordInvisible;
    notifyListeners();
  }

  Future<void> signUp(userName, emailAddress, password, confirmPassword,context) async {
    userErrorText = null;
    emailErrorText = null;
    passwordErrorText = null;
    isLoading = true;
    notifyListeners();
    try {
      RegisterResponse registerResponse = await User().register(
          RegisterRequest(userName, emailAddress, password, password));
      var dartMapResponse = registerResponse.toJson();
      await UserLogData().assigningData(dartMapResponse["data"],context,"signUp");
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
      } else if (errorMessage.contains('email') ||
          (errorMessage.contains('Email'))) {
        emailErrorText = errorMessage;
        userErrorText = null;
        passwordErrorText = null;
      }

      notifyListeners();
      throw error;
    }
  }
}

class SignIn with ChangeNotifier {
  String emailErrorText;
  String passwordErrorText;

  bool passwordInvisible = true;

  bool isLoading = false;

  void changePasswordVisibility() {
    passwordInvisible = !passwordInvisible;
    notifyListeners();
  }

  Future<dynamic> signIn(emailAddress, password,context) async {
    emailErrorText = null;
    passwordErrorText = null;
    isLoading = true;
    notifyListeners();
    try {
      LoginResponse logIn =
          await User().login(LoginRequest(emailAddress, password));
      var dartMapResponse = logIn.toJson();
      await UserLogData().assigningData(dartMapResponse["data"],context,"signIn");
      return dartMapResponse["data"];
    } on ErrorResponse catch (error) {
      isLoading = false;
      notifyListeners();
      var errorMessage = error.message;
      print(errorMessage);
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

  Future<void> sendTheLink(String emailAddress) async {
    emailErrorText = null;
    try {
      isLoading = true;
      notifyListeners();
      String response = await User().forgotPassword(emailAddress);
      isLoading = false;
      notifyListeners();
    } on ErrorResponse catch (error) {
      isLoading = false;
      emailErrorText = error.message;
      notifyListeners();
      throw error;
    }
  }
}
