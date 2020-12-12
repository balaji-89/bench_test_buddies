import 'package:flutter/material.dart';

class UserAttempt {
  int attempt;
  TimeOfDay totalTimetaken;
  TimeOfDay initialTimeSet;
  bool result;
  int scoreCard;
  List imagesUploaded;

  UserAttempt(
      {this.attempt = 0,
      this.totalTimetaken = const TimeOfDay(hour: 0, minute: 0),
      this.initialTimeSet = const TimeOfDay(hour: 0, minute: 0),
      this.result = false,
      this.scoreCard = 0,
      this.imagesUploaded = const []});
}
