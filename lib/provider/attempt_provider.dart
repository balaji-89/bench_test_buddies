import 'package:bench_test_buddies/model/attempt_model.dart';
import 'package:bench_test_service/service/exercise.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AttemptedList with ChangeNotifier {
  List<UserAttempt> userAttempts = [
    UserAttempt(
      attemptId: 1,
      userExerciseId: 1,
      attempt: 3,
      attemptedDate: DateTime(
        2010,
        11,
        30,
      ),
      userScoreCard: {
        'userScore': 15,
        'totalScore': 30,
      },
      totalTimeTaken: DateTime(20, 6, 14, 3, 30),
      initialTimeSet: DateTime(20, 6, 14, 3, 0),
      timeExtended: DateTime(20, 6, 14, 0, 30),
      timeStarted: DateTime(20, 6, 14, 1, 0),
      timeEndsAt: DateTime(20, 6, 14, 4, 30),
    ),
  ];

  Future initializeUserAttempt(String token, int exerciseId) async {
    try {
      var response = await Exercise().getAttempts(exerciseId, token);
      List list = [];
      response.data.map((e) {
        userAttempts.add(UserAttempt(
          attemptId: e.id,
          userExerciseId: e.apiExerciseId,
        ));
      }).toList();
    } catch (error) {
      print(error.message);
    }
  }

  List<UserAttempt> getUserAttempt(int exerciseId) {
    return userAttempts
        .where((element) => element.userExerciseId == exerciseId)
        .toList();
  }

  UserAttempt findById(int id) {
    return userAttempts.firstWhere((element) => element.attemptId == id);
  }

  void addNewUserAttempt(exerciseId, attemptedDate) {
    userAttempts.add(UserAttempt(
        userExerciseId: exerciseId,
        attemptId: userAttempts.length + 1,
        attemptedDate: attemptedDate));
  }
}
