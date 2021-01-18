
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:flutter/cupertino.dart';

class UserDetailsAndLevel {
  int userExerciseId;
  List<Map> participatedExercise;
  Stages currentSection;
  List completedExercise;
  List upcomingSection;
  List inProgressSection;


  UserDetailsAndLevel({
    this.userExerciseId = 1,
    this.currentSection = Stages.Start_the_exercise,
    this.participatedExercise = const [
      {
        'Exercise_id': 1,
        'stage_finished': Stages.Start_the_exercise,
        'attempts':0,
      }
    ],
    this.inProgressSection=const[
      Stages.Uploaded_images,
      Stages.Evaluate_the_result,
      Stages.View_the_results,
    ],
    this.completedExercise,
    this.upcomingSection = const [
      Stages.Uploaded_images,
      Stages.Evaluate_the_result,
      Stages.View_the_results,
    ],

  });
}
