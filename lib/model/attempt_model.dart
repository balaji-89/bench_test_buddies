import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class UserAttempt {
  int userExerciseId;
  int attempt;
  int attemptId;
  DateTime attemptedDate;
  DateTime totalTimeTaken;
  DateTime initialTimeSet;
  DateTime timeExtended;
  DateTime timeStarted;
  DateTime timeEndsAt;
  bool result;
  Map<String,dynamic> bestScore;
  Map<String,dynamic> userScoreCard;

  List imagesUploaded;

  UserAttempt(
      {
        @required this.userExerciseId,
        @required this.attemptId,
        this.attempt = 0,
      this.attemptedDate,
      this.totalTimeTaken ,
      this.initialTimeSet ,
       this.timeExtended,
       this.timeEndsAt,
       this.timeStarted,
      this.result = false,
      this.userScoreCard =const{
         'userScore': 16,
         'totalScore':30,
      },
        this.bestScore =const{
          'bestScore': 28,
          'totalScore':30,
        },
      this.imagesUploaded = const []});
}
