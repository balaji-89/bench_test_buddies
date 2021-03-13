import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'country_provider.dart';

class UserLogData with ChangeNotifier {
  String userName;
  String userMail;
  String token;
  int userId;

  Future assigningData(jsonData, BuildContext context,String req) async {
    print('reached assigning Data');
    userId = jsonData.user.id;
    userName = jsonData.user.name;
    userMail = jsonData.user.email;
    token = jsonData.token;
    if(req=="signUp"){
    await Provider.of<CountryProvider>(context, listen: false)
        .initialiseCountry(token);
    await Provider.of<CountryProvider>(context, listen: false)
        .getQuestionsSet();}
  }

}
