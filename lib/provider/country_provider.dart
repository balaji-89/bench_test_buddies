import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:flutter/material.dart';
import 'package:bench_test_service/bench_test_service.dart';

class CountryProvider with ChangeNotifier {
  var userToken = UserLogData().token;
  List<Map<String, dynamic>> countryNames = [
    {"id": 101, "name": "India"}
  ];

  TextEditingController countryController = TextEditingController();

  bool buttonColor = true;

  int setUp2Check;
  int sentToBackend;
  Map<String, dynamic> selectedCountry = {};

  void initializeUserToken(String token){
    userToken=token;
  }

  void initialiseCountry() async {
    print(userToken);
    try {
      var response = await User().getCountries(userToken);
      response["data"].map((country) {
        countryNames.add(country);
        print(response);
      }).toList();
    } catch (error) {
      print(error);
    }
  }

  List get getCountryNames {
    List onlyNames = [];
    countryNames.map((e) {
      onlyNames.add(e["name"]);
    }).toList();

    return onlyNames;
  }

  void initializeSelectedCountry(String selectedCountryName) {
    selectedCountry = countryNames.firstWhere((element) {
      return element["name"] == selectedCountryName;
    });
    notifyListeners();
  }

  void passingUserCountry() async {
    try {
      await User().updateCountry(selectedCountry["id"], userToken);
      await getQuestionsSet();
    } catch (error) {
      print(error);
    }
  }

  Map<String, dynamic> setUp1={};
  Map<String, dynamic> setUp2={};

  Future<void> getQuestionsSet() async {
    try{
      var response = await User().getQuestions(userToken);
      var question=response['message'];
      print(question);
      setUp1 = question.firstWhere((element) => element["id"] == 1);
      setUp2 = question.firstWhere((element) => element["id"] == 2);
    }catch(error){
      print("my error $error");
    }

  }


  String getOnlyQuestion(int id) {
    return id == 1 ? setUp1["question"] : setUp2["question"];
  }
  List getOnlyAnswers(int setUpNumber){
    return setUpNumber == 1 ? setUp1["answers"] : setUp2["answers"];
  }

  void questionSetup2Changer(index) {
    setUp2Check = index;
    notifyListeners();
  }

  int setUp3Check;
  int sentToBackend2;

  void questionSetup3Changer(index) {
    setUp3Check = index;
    notifyListeners();
  }
}
