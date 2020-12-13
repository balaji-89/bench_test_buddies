import 'package:flutter/material.dart';

class UserAttempt {
  int userExerciseId;
  int attempt;
  TimeOfDay totalTimeTaken;
  TimeOfDay initialTimeSet;
  bool result;
  int scoreCard;
  List imagesUploaded;

  UserAttempt(
      {
        @required this.userExerciseId,
        this.attempt = 0,
      this.totalTimeTaken = const TimeOfDay(hour: 0, minute: 0),
      this.initialTimeSet = const TimeOfDay(hour: 0, minute: 0),
      this.result = false,
      this.scoreCard = 0,
      this.imagesUploaded = const []});
}
