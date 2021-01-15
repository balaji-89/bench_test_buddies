import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'country_provider.dart';

class UserLogData with ChangeNotifier {
  String userName;
  String userMail;
  String token;
  int userId;

  Future assigningData(
      Map<dynamic, dynamic> jsonData, BuildContext context) async {
    userId = jsonData["user"]["id"];
    userName = jsonData["user"]["name"];
    userMail = jsonData["user"]["email"];
    token = jsonData["token"];

    Provider.of<CountryProvider>(context, listen: false)
        .initializeUserToken(token);
    await Provider.of<CountryProvider>(context, listen: false)
        .initialiseCountry();
    await Provider.of<CountryProvider>(context,listen:false).getQuestionsSet();
  }
}
