import 'dart:convert';

import 'package:bench_test_buddies/model/exercise_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Exercises with ChangeNotifier {
  String baseUrl = "https://innercircle.caapidsimplified.com";
  List<ExerciseModel> _exercises = [];

  void listToExerciseModel(List exercises) {
    exercises.map((exe) {
      _exercises.add(ExerciseModel(
          id: exe["id"], name: exe["name"], description: exe["description"]));
    }).toList();
  }

  Future getAllExercise(String token) async {
    try {
      http.Response response = await http.get('$baseUrl/api/exercise/all',
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });
      var dartList = jsonDecode(response.body);
      listToExerciseModel(dartList["data"]);
    } catch (error) {
      print("error in get exercise ${error.message}");
    }
  }

  List<ExerciseModel> get exercises {
    return [..._exercises];
  }

  ExerciseModel findExerciseById(int receivedId) {
    return _exercises.firstWhere((element) => element.id == receivedId);
  }

  ExerciseModel findExerciseByName(String name) {
    return _exercises.firstWhere((element) => element.name == name);
  }
}
