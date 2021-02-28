import 'package:bench_test_buddies/model/solution_model.dart';
import 'package:bench_test_service/model/response/solution_response.dart';
import 'package:bench_test_service/service/exercise.dart';
import 'package:flutter/material.dart';

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

  Future<dynamic> getSolutionsForAQuestion(
      int evaluationID, String token) async {
    try {
      Map response =
          (await Exercise().getSolutionForAQuestion(token, evaluationID));
      var data = response["Solution"][0];
      individualQuestion = Solution(
          question: data["question"],
          image: data["image"] == null ? "" : data["image"],
          video: data["video"] == null ? "" : data["video"],
          explanation: data["explanation"],
          commonErrorCause: data["common_error_cause"],
          prevent: data["prevent"],
          bookmarkStatus: response["boommark_status"]);
    } catch (error) {
      throw error;
    }
  }

  Future storeBookMarks(int evaluationId, String token) async {
    try {
      await Exercise().saveBookmark(evaluationId, token);
    } catch (error) {
      throw error;
    }
  }

  Future removeBookMarks() async {
    try {} catch (error) {}
  }
}


class BookmarksProvider with ChangeNotifier {
  List<int> bookmarks = [];
  Solution selectedBookmarkSolution;

  Future getAllBookmarks(String token) async {
    if(bookmarks.isEmpty){
    try {
      List response = await Exercise().getAllBookmarks(token);
      response.map((element) {
        bookmarks.add(element["id"]);
      }).toList();
      return bookmarks;
    } on Exception catch (error) {
      throw error;
    }}
  }

  Future getBookmarkedItem(int bookmarkedItem,token)async{
     try {
       //TODO:Have to cj=have the hardCoded bookItem
       var response= await (Exercise().getBookmarkedData(7, token));
       var bookmarkedInfo=response["bookmarked_question"];
       var userResponse=response["user_answer"];
       selectedBookmarkSolution=Solution(
         question: bookmarkedInfo["question"],
         image: bookmarkedInfo["image"] == null ? "" : bookmarkedInfo["image"],
         video: bookmarkedInfo["video"] == null ? "" : bookmarkedInfo["video"],
         explanation: bookmarkedInfo["explanation"],
         commonErrorCause: bookmarkedInfo["common_error_cause"],
         prevent: bookmarkedInfo["prevent"],
         userAnswer: userResponse["answer"],
         correctAnswer: userResponse["points"],
       );
       return selectedBookmarkSolution;
     } on Exception catch (e) {
       throw e;
     }
  }
}
