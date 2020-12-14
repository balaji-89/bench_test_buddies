import 'package:bench_test_buddies/model/attempt_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AttemptedList with ChangeNotifier{
  List<UserAttempt> userAttempts=[
    UserAttempt(userExerciseId: 1,attempt: 3,attemptedDate: DateTime(2010,11,30,),scoreCard: 20),
    UserAttempt(userExerciseId: 1,attempt: 3,attemptedDate: DateTime(2020,5,27),scoreCard: 20),
    UserAttempt(userExerciseId: 2,attempt: 10,attemptedDate: DateTime(2020,12,30),scoreCard: 25),

    UserAttempt(userExerciseId: 2,attempt: 20,attemptedDate: DateTime(2020,12,4),scoreCard: 10),
  ];


  List<UserAttempt> getUserAttempt(int exerciseId){
    return userAttempts.where((element) => element.userExerciseId==exerciseId).toList();
  }

}