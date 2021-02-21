import 'package:bench_test_service/model/response/solution_response.dart';
import 'package:bench_test_service/service/exercise.dart';
import 'package:flutter/material.dart';

class Solution {
  int attemptId;
  int evaluationId;
  var image;
  var video;
  String explanation;
  String commonErrorCause;
  String prevent;
  int bookmarkStatus;

  Solution(
      {this.attemptId,
      this.evaluationId,
      this.image,
      this.video,
      this.explanation,
      this.commonErrorCause,
      this.prevent,
      this.bookmarkStatus});
}

class ViewResultProvider with ChangeNotifier {
  List<Data> allResponse;
  List<Data> correctResponse;
  List<Data> inCorrectResponse;

  List<int> allAttemptId = [];
  List<int> correctAttemptId = [];
  List<int> inCorrectAttemptId = [];
  List<int> bookMarksAttemptId = [];
  List<int> isTrueForAllType = [];

  Solution individualQuestion;
  bool isInitialized = false;


  Future<void> initializeData(String token) async {
    if (isInitialized == false)
      try {
        allResponse = (await Exercise().getSolution("all", token)).data;
        correctResponse = (await Exercise().getSolution("correct", token)).data;
        inCorrectResponse =
            (await Exercise().getSolution("incorrect", token)).data;

        allResponse.map((e) {
          allAttemptId.add(e.apiAttemptId);
          isTrueForAllType.add(e.isTrue);
        }).toList();
        correctResponse.map((e) {
          correctAttemptId.add(e.apiAttemptId);
        }).toList();
        inCorrectResponse.map((e) {
          inCorrectAttemptId.add(e.apiAttemptId);
        }).toList();
        isInitialized = true;
        //TODO:change 1
      } catch (error) {
        print('error here');
        print(error);
      }
  }


  Future<dynamic> getSolutionsForAQuestion(int evaluationID,String token) async {
        try {
      Map response =
          (await Exercise().getSolutionForAQuestion(token, evaluationID))[0];
      var data = response["Solution"][0];
      individualQuestion = Solution(
          image: data["image"]==null?"":data["image"],
          video: data["video"]==null?"":data["video"],
          explanation: data["explanation"],
          commonErrorCause: data["common_error_cause"],
          prevent: data["prevent"],
          bookmarkStatus:response["bookmark_status"]);
    } catch (error) {
      throw error;
    }
  }

  Future storeBookMarks(int evaluationId,String token)async{
    try{
      await Exercise().saveBookmark(evaluationId, token);
    }catch(error){
      throw error;
    }



  }
}
