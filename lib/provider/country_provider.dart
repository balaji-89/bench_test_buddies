import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier {
  List<String> countryNames = [
    'Albania',
    'South Africa',
    'Australia',
    'Afghanistan',
    'India',
    'Bangladesh',
    'England',
    'Australia',
    'Ireland',
    'Zimbabwe',
    'West Indies',
    'Sri Lanka',
    'Pakistan'

  ];

  TextEditingController countryController=TextEditingController();

  bool buttonColor=true;


  int setUp2Check;
  int sentToBackend;

  void questionSetup2Changer(index){
      setUp2Check=index;
      notifyListeners();
  }

  int setUp3Check;
  int sentToBackend2;

  void questionSetup3Changer(index){
    setUp3Check=index;
    notifyListeners();
  }
}