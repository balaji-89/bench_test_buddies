import 'package:bench_test_buddies/model/attempt_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AttemptedList with ChangeNotifier{
  List<UserAttempt> userAttempts=[
    UserAttempt(attemptId:1,userExerciseId: 1,attempt: 3,attemptedDate: DateTime(2010,11,30,),userScoreCard:{'userScore':15,'totalScore':30,},totalTimeTaken: DateTime(20, 6, 14,3, 30),initialTimeSet: DateTime(20, 6, 14,3,0),timeExtended: DateTime(20, 6, 14,0, 30),timeStarted:DateTime(20, 6, 14,1, 0),timeEndsAt: DateTime(20, 6, 14,4, 30),),
    UserAttempt(attemptId:2,userExerciseId: 1,attempt: 3,attemptedDate: DateTime(2020,5,27),userScoreCard:{'userScore':22,'totalScore':30}),
    UserAttempt(attemptId:3,userExerciseId: 2,attempt: 10,attemptedDate: DateTime(2020,12,30),userScoreCard:{'userScore':20,'totalScore':30}),

    UserAttempt(attemptId:4,userExerciseId: 2,attempt: 20,attemptedDate: DateTime(2020,12,4),userScoreCard:{'userScore':18,'totalScore':30}),
  ];


  List<UserAttempt> getUserAttempt(int exerciseId){
    return userAttempts.where((element) => element.userExerciseId==exerciseId).toList();
  }
  UserAttempt findById(int id){
    return userAttempts.firstWhere((element) => element.attemptId==id);
  }

}