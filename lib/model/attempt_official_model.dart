import 'package:flutter/material.dart';

class Attempt {
  int userExerciseId;
  int lastCompletedSection;
  String totalTimeTaken;
  String initialTimeSet;
  String timeExtended;
  String timeStarted;
  String timeEndsAt;

  Attempt({
    @required this.userExerciseId,
    this.lastCompletedSection = 0,
    this.totalTimeTaken,
    this.initialTimeSet,
    this.timeExtended,
    this.timeEndsAt,
    this.timeStarted,
  });
}
