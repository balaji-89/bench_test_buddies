import 'package:bench_test_buddies/model/attempt_official_model.dart';
import 'package:bench_test_buddies/model/attempted_images.dart';
import 'package:bench_test_service/model/request/store_attempt_request.dart';
import 'package:bench_test_service/service/exercise.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AttemptOfficial with ChangeNotifier {
  List<Attempt> _userAttempts = [];

  ScoreCardModel attemptScoreCard;

  int currentExerciseId;
  String currentStartedTime;
  String currentEndedTime;
  String currentInitialTime;
  String currentTotalTimeTaken;
  String currentExtendedTime;
  Attempt currentAttemptTimeStamps;

  int newCreatedAttempt;


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

  Future createNewAttempt(int exerciseID, String token) async {
    try {
      Map response = await Exercise().createAttempt(exerciseID, token);
      newCreatedAttempt = response['id'];
    } catch (error) {
      print(error);
    }
  }

  Future addNewAttempt(String token, int lastCompletedSection) async {
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
      var response = await Exercise().storeAttempt(
          StoreAttemptRequest(
              currentExerciseId,
              lastCompletedSection,
              currentStartedTime,
              currentEndedTime,
              currentInitialTime,
              currentTotalTimeTaken,
              currentExtendedTime),
          token);
      print(response);
    } catch (error) {
      throw error;
    }
  }

  Future initializeUserAttempt(String token, int exerciseId) async {
    try {
      var response = await Exercise().getAttempts(exerciseId, token);
      response.data.map((e) {
        _userAttempts.add(Attempt(
          attemptId: e.id,
          userExerciseId: e.apiExerciseId,
        ));
      }).toList();
    } catch (error) {
      print(error.message);
    }
  }

  Attempt findById(int attemptId) {
    return _userAttempts
        .firstWhere((element) => element.attemptId == attemptId);
  }

  Future getScoreCard(int attemptId, String token) async {
    Map response;
    try {
       response =
          await Exercise().getEvaluationResultByAttempt(attemptId, token);
    } catch (error) {
      throw error;
    }
    return response;
  }

  Future getAttemptTimeSet(int attemptId, String token) async {
    var response;
    try {
      response = (await Exercise().getAttemptTimeSummary(attemptId, token))[0];

    } catch (error) {
      print(error);
    }

    currentAttemptTimeStamps = Attempt(
        attemptId: response['id'],
        userExerciseId: response['api_exercise_id'],
        timeStarted: response['start_time'],
        timeEndsAt: response['end_time'],
        initialTimeSet: response['initial_time_set'],
        totalTimeTaken: response['actual_time_taken'],
        timeExtended: response['extra_time_taken'],
        lastCompletedSection: response['last_completed_section']);
  }

 Future getAttemptedImages(String token)async{
   List<AttemptedImages> attemptedImages=[];
    try{
      //TODO:Have to change the hardCoded attemptId
      var response=await Exercise().getImages(7, token);
      response.map((element) => attemptedImages.add(AttemptedImages(
        imagePath: element["image"],
        apiExerciseId: element["api_exercise_id"],
        view: element["view"]
      ))).toList();
      return attemptedImages;

    }catch(error){
    throw error;}
}


}

