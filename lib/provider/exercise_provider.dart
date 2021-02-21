import 'package:bench_test_buddies/model/exercise_model.dart';
import 'package:bench_test_service/service/exercise.dart';
import 'package:flutter/cupertino.dart';

class Exercises with ChangeNotifier {
  String baseUrl = "https://innercircle.caapidsimplified.com";
  List<ExerciseModel> _exercises = [];

  ExerciseModel selectedExercise;

  void initializeSelectedExercise(int id,String name,String description){
     selectedExercise=ExerciseModel(id: id, name: name, description: description);
  }

  void listToExerciseModel(List exercises) {
    exercises.map((exe) {
      _exercises.add(ExerciseModel(
          id: exe.id, name: exe.name, description: exe.description));
    }).toList();
  }
  Future getAllExercise(String token) async {
    if(_exercises.isEmpty)
    try {
      var dartList=await Exercise().getAllExercise(token);
      listToExerciseModel(dartList);
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
