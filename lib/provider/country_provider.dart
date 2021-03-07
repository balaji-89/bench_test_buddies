import 'package:flutter/material.dart';
import 'package:bench_test_service/bench_test_service.dart';

class CountryProvider with ChangeNotifier {
  String userToken;

  var countryNames = [];
  TextEditingController countryController = TextEditingController();

  bool buttonColor = true;

  int setUp2Check;

  var selectedCountry;

  void initializeUserToken(String token) {
    userToken = token;
  }

  Future initialiseCountry() async {
    try {
      var response = await User().getCountries(userToken);
      (response.data).map((country) {
        countryNames.add(country);
      }).toList();
    } catch (error) {
      print(error.message);
    }
  }

  List<String> get getCountryNames {
    List<String> onlyNames = [];
    countryNames.map((e) {
      onlyNames.add(e.name);
    }).toList();
    return onlyNames;
  }

  void initializeSelectedCountry(String selectedCountryName) {
    selectedCountry = countryNames.firstWhere((element) {
      return element.name == selectedCountryName;
    });
    notifyListeners();
  }

  Future passingUserCountry() async {
    try {
      await User().updateCountry(selectedCountry.id, userToken);
      // await getQuestionsSet();
    } catch (error) {
      print(error.message);
    }
  }

  //For set up  questions used the same provider

  var setUp1;

  var setUp2;

  List<int> selectedAnswers = [];
  bool isLoading = false;

  Future<void> getQuestionsSet() async {
    try {
      var response = await User().getQuestions(userToken);
      setUp1 = response.message.firstWhere((element) {
        return element.id == 1;
      });
      setUp2 = response.message.firstWhere((element) => element.id == 2);
    } catch (error) {
      print(" error here ${error.message}");
    }
  }

  String getOnlyQuestion(int id) {
    return id == 1 ? setUp1.question : setUp2.question;
  }

  List getOnlyAnswers(int setUpNumber) {
    return setUpNumber == 1 ? setUp1.answers : setUp2.answers;
  }

  void addingAnswersToUpload(int index, int selectedAnswersIndex) {
    selectedAnswers.add(selectedAnswersIndex);
  }

  Future updateSetupQuestion() async {
    var message=await User().postAnswers(selectedAnswers.reversed.toList(), userToken);
    print(message);
    notifyListeners();
  }

  int setUp3Check;
  int sentToBackend2;

  void questionSetup3Changer(int index, int selectedAnswersIndex) {
    setUp3Check = index;
    selectedAnswers.add(selectedAnswersIndex);
  }
}
