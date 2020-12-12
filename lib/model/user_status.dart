import 'package:bench_test_buddies/model/attempt_model.dart';
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:flutter/cupertino.dart';

class UserDetailsAndLevel {
  final String userName;
  final int userId;
  int userExerciseId;
  List<Map> participatedExercise;
  Stages currentSection;
  List completedExercise;
  List upcomingSection;
  List<UserAttempt> userAttempt = [UserAttempt()];

  UserDetailsAndLevel({
    @required this.userId,
    @required this.userName,
    this.userExerciseId = 1,
    this.currentSection = Stages.Start_the_excerise,
    this.participatedExercise = const [
      {
        'Exercise_id': 1,
        'stage_finished': Stages.Start_the_excerise,
      }
    ],

    this.upcomingSection = const [
      Stages.Uploaded_images,
      Stages.View_the_results,
    ],
    this.completedExercise=const[
      Stages.Start_the_excerise,
      Stages.Uploaded_images,
    ],
  });
}