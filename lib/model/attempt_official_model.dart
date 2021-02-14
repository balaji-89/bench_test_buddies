import 'package:flutter/material.dart';

class Attempt {
  int userExerciseId;
  int attemptId;
  String attemptedOn;
  int lastCompletedSection;
  String totalTimeTaken;
  String initialTimeSet;
  String timeExtended;
  String timeStarted;
  String timeEndsAt;

  Attempt({
    @required this.userExerciseId,
    this.attemptedOn,
    this.attemptId,
    this.lastCompletedSection = 0,
    this.totalTimeTaken,
    this.initialTimeSet,
    this.timeExtended,
    this.timeEndsAt,
    this.timeStarted,
  });
}

class ScoreCardModel{
  int attemptId;
  int maxScore;
  int actualScore;
  int expectedScore;
  String buddyWords;

  ScoreCardModel({
      @required this.attemptId, this.maxScore, this.actualScore, this.expectedScore,this.buddyWords});

}

