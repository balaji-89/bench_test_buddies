import 'package:bench_test_buddies/model/user_status.dart';
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  UserDetailsAndLevel _user = UserDetailsAndLevel(
    userExerciseId: 1,
  );
  List<Stages> completedList=[];

  UserDetailsAndLevel get userData {
    return _user;
  }

  void changeUserStage(Stages stage) {
    completedList.add(stage);
   _user.completedExercise=completedList;
    int index = stage.index;
    _user.currentSection = Stages.values[index + 1];
    List<Stages> updatedList = [];
    for (var i = index + 1; i < Stages.values.length; i++) {
      updatedList.add(
        Stages.values[i],
      );
    }
    _user.inProgressSection = updatedList;
  }

  void addToCompletedList(Stages stage) {
    _user.completedExercise.add(stage);
  }
}
