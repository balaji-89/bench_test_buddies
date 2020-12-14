import 'package:bench_test_buddies/model/attempt_model.dart';
import 'package:bench_test_buddies/model/user_status.dart';
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  UserDetailsAndLevel _user = UserDetailsAndLevel(
    userId: 01,
    userName: 'Balaji J',
    userExerciseId: 1,
  );

  UserDetailsAndLevel get userData {
    return _user;
  }

  void changeUserStage(Stages stage) {
    _user.currentSection = stage;
    var index = stage.index;
    var updatedList = [];
    for (var i = index + 1; i < Stages.values.length; i++) {
      updatedList.add(
        Stages.values[i],
      );
    }
    _user.upcomingSection = updatedList;
    notifyListeners();
  }


}
