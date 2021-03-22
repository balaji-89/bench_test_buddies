import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'country_provider.dart';

class UserLogData with ChangeNotifier {
  String userName;
  String userMail;
  String token;
  int userId;

  Future assigningData(jsonData, BuildContext context,String req) async {
    userId = jsonData.user.id;
    userName = jsonData.user.name;
    userMail = jsonData.user.email;
    token = jsonData.token;
    if(req=="initializeSetUpQuestion"){
      await Provider.of<CountryProvider>(context, listen: false)
        .initialiseCountry(token);
      var response=await Provider.of<CountryProvider>(context, listen: false)
          .getQuestionsSet();
      if(response.isEmpty){
        return [];
      }
      else{
        return [1];//to check the response contains set up questions
      }
    }
  }

}
