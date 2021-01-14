import 'package:flutter/material.dart';

import 'country_provider.dart';

class UserLogData with ChangeNotifier{


  String userName;
  String userMail;
  String token;
  int userId;

  void assigningData(Map<dynamic, dynamic> jsonData){
     userId=jsonData["user"]["id"];
      userName=jsonData["user"]["name"];
      userMail=jsonData["user"]["email"];
      token=jsonData["token"];
      CountryProvider().initializeUserToken(token);
      CountryProvider().initialiseCountry();
      CountryProvider().getQuestionsSet();
      print("success");

  }

}