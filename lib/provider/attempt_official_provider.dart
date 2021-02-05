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
  int currentExerciseId;
  String currentStartedTime;
  String currentEndedTime;
  String currentInitialTime;
  String currentTotalTimeTaken;
  String currentExtendedTime;
  List<Attempt> getUserAttempt(int exerciseId) {
    return _userAttempts
        .where((element) => element.userExerciseId == exerciseId)
        .toList();
  }

  Attempt getAttemptByExerciseId(int id) {
    return _userAttempts.firstWhere((element) => element.userExerciseId == id);
  }

  void currentDataInitialize(
      {@required int exerciseId,
      String startTime,
      String endTime,
      String initialTimeSet,
      String actualTimeTaken,
      String extraTimeTaken,
      String token}) {
    currentExerciseId = exerciseId;
    currentStartedTime = startTime;
    currentEndedTime = endTime;
    currentInitialTime = initialTimeSet;
    currentTotalTimeTaken = actualTimeTaken;
    currentExtendedTime = extraTimeTaken;

  }

  Future addNewAttempt(String token,int lastCompletedSection) async {
    _userAttempts.add(Attempt(
      userExerciseId: currentExerciseId,
      lastCompletedSection: lastCompletedSection,
      initialTimeSet: currentInitialTime,
      totalTimeTaken: currentTotalTimeTaken,
      timeStarted: currentStartedTime,
      timeEndsAt: currentEndedTime,
      timeExtended: currentExtendedTime,
    ));
    try {
      var response=await Exercise().storeAttempt(
          StoreAttemptRequest(currentExerciseId, lastCompletedSection, currentStartedTime, currentEndedTime,
              currentInitialTime, currentTotalTimeTaken, currentExtendedTime),
          token);
      print(response);
    } catch (error) {
      throw error;
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
    print(_userAttempts.length);
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
    print(_userAttempts.length);
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
