import 'package:bench_test_buddies/model/attempt_official_model.dart';
import 'package:bench_test_service/model/request/store_attempt_request.dart';
import 'package:bench_test_service/service/exercise.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AttemptOfficial with ChangeNotifier {
  List<Attempt> _userAttempts = [
    Attempt(
      userExerciseId: 1,
      lastCompletedSection: 2,
      initialTimeSet: "00.45.00",
      totalTimeTaken: "00.50.00",
      timeStarted: "02.00.00",
      timeEndsAt: "02.50.00",
      timeExtended: "00.05.00",
    )
  ];

  List<Attempt> getUserAttempt(int exerciseId) {
    return _userAttempts
        .where((element) => element.userExerciseId == exerciseId)
        .toList();
  }

  Attempt getAttemptByExerciseId(int id) {
    return _userAttempts.firstWhere((element) => element.userExerciseId == id);
  }

  void addNewAttempt(token,
      {@required int exerciseId,
      int completedSection,
      String startTime,
      String endTime,
      String initialTimeSet,
      String actualTimeTaken,
      String extraTimeTaken}) async {
    _userAttempts.add(Attempt(
      userExerciseId: exerciseId,
      lastCompletedSection: completedSection,
      initialTimeSet: initialTimeSet,
      totalTimeTaken: actualTimeTaken,
      timeStarted: startTime,
      timeEndsAt: endTime,
      timeExtended: extraTimeTaken,
    ));
    try {
      var response = await Exercise().storeAttempt(
          StoreAttemptRequest(exerciseId, completedSection, startTime, endTime,
              initialTimeSet, actualTimeTaken, extraTimeTaken),
          token);
      print(response);
    } catch (error) {
      print(error.message);
    }
  }

  void updateStoredAttempt(token,
      {@required int exerciseId,
      int lastCompletedSection,
      String startTime,
      String endTime,
      String initialTimeSet,
      String actualTimeTaken,
      String extraTimeTaken}) async {
    Attempt existedAttempt = getAttemptByExerciseId(exerciseId);
    Attempt updatedAttempt = Attempt(
      userExerciseId: exerciseId,
      lastCompletedSection: lastCompletedSection == null
          ? existedAttempt.lastCompletedSection
          : lastCompletedSection,
      initialTimeSet: initialTimeSet == null
          ? existedAttempt.initialTimeSet
          : initialTimeSet,
      totalTimeTaken: actualTimeTaken == null
          ? existedAttempt.totalTimeTaken
          : actualTimeTaken,
      timeStarted: startTime == null ? existedAttempt.timeStarted : startTime,
      timeEndsAt: endTime == null ? existedAttempt.timeEndsAt : endTime,
      timeExtended:
          extraTimeTaken == null ? existedAttempt.timeExtended : extraTimeTaken,
    );
    _userAttempts.add(updatedAttempt);
    try {
      var response = await Exercise().storeAttempt(
          StoreAttemptRequest(exerciseId, lastCompletedSection, startTime,
              endTime, initialTimeSet, actualTimeTaken, extraTimeTaken),
          token);
      print(response);
    } catch (error) {
      print(error.message);
    }
  }
}
