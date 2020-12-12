import 'package:bench_test_buddies/model/exercise_model.dart';
import 'package:flutter/cupertino.dart';

class Exercises with ChangeNotifier {
  List<ExerciseModel> _exercises = [
    ExerciseModel(
        id: 1,
        name: "Class 1 Amalgam Cavity",
        description: 'Restoring Teeth is a basic skill that all dental students must master,not only to matriiculate operative dentistry labs but also to become good clicniclies'),
    ExerciseModel(
      id: 2,
      name: 'Sample Exercise 2',
      description: 'Restoring Teeth is a basic skill that all dental students must master,not only to matriiculate operative dentistry labs but also to become good clicniclies',
    ),
    ExerciseModel(
      id: 3,
      name: 'Class 1 Amalgam Cavity',
      description:
          'Restoring Teeth is a basic skill that all dental students must master,not only to matriiculate operative dentistry labs but also to become good clicniclies',
    ),
  ];

  List<ExerciseModel> get exercises {
    return [..._exercises];
  }

  ExerciseModel findExerciseById(int receivedId) {
    return _exercises.firstWhere((element) => element.id == receivedId);
  }
}
