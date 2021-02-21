import 'package:bench_test_buddies/model/attempt_official_model.dart';
import 'package:bench_test_service/model/request/store_evaluation_request.dart';
import 'package:bench_test_service/model/response/store_evaluation_response.dart';
import 'package:bench_test_service/service/exercise.dart';
import 'package:flutter/material.dart';

class Question {
  int questionId;
  int exerciseId;
  String image;
  String video;
  String title;
  String question;
  int answerType;
  int points;
  int answerBoolean;
  double answerDouble; //var caz it may be double or int
  String explanation;
  String commonErrorCause;
  String prevent;

  Question(
      {@required this.questionId,
      @required this.exerciseId,
      this.image,
      this.video,
      this.title,
      this.question,
      this.answerType,
      this.points,
      this.answerBoolean,
      this.answerDouble,
      this.explanation,
      this.commonErrorCause,
      this.prevent});
}

class EvaluationsQuestionsProvider with ChangeNotifier {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  bool isLastQuestion = false;

  List<Question> userAnswers = [];

  List<Question> get getAllQuestion {
    return [...questions];
  }

  void incrementQuestionIndex() {
    currentQuestionIndex++;
    if (currentQuestionIndex + 1 == questions.length) {
      isLastQuestion = true;
      notifyListeners();
    }
  }

  Question getQuestion() {
    return questions.elementAt(currentQuestionIndex);
  }

  Future<List<Question>> getExerciseQuestion(int id, String token) async {
    if (questions.isEmpty || questions == null) {
      try {
        //TODO:must change the hard coded exercise ID to id
        var questionResponse = await Exercise().getExerciseEvaluation(2, token);
        questionResponse.data.map((singleData) {
          questions.add(Question(
              questionId: singleData.id,
              exerciseId: singleData.apiExerciseId,
              // answerBoolean: singleData.answerBoolean,
              // answerDouble:singleData.answerDouble,
              answerType: singleData.answerType,
              explanation: singleData.explanation,
              image: singleData.image,
              points: singleData.points,
              question: singleData.question,
              title: singleData.title,
              video: singleData.video,
              commonErrorCause: singleData.commonErrorCause,
              prevent: singleData.prevent));
        }).toList();
      } catch (error) {
        throw error;
      }
    }
    return questions;
  }

  void storeUsersAnswers(var answer) {
    Question currentQuestion = questions[currentQuestionIndex];
    int questionId = currentQuestion.questionId;
    int answerType = currentQuestion.answerType;
    if (answerType == 1) {
      //if the answer is boolean it will be stored in answerBoolean else answerDouble
      userAnswers.add(Question(
        questionId: questionId,
        answerType: answerType,
        answerBoolean: answer,
      ));
    } else {
      userAnswers.add(Question(
        questionId: questionId,
        answerType: answerType,
        answerDouble: answer, //as it is received as double as a parameter
      ));
    }

  }

  Future<ScoreCardModel> storeAndGetEvaluationData(
      {int attemptId, String token}) async {
    List<EvaluationData> data=[];
    ScoreCardModel responseResult;
    userAnswers.map((answers) {
      if (answers.answerType == 1) {
        data.add(EvaluationData(
            answers.questionId, answers.answerBoolean, answers.answerType));
      } else {
        data.add(EvaluationData(
            answers.questionId, answers.answerDouble, answers.answerType));
      }
    }).toList();
    try {
      StoreEvaluationResponse response = await Exercise()
          .storeEvaluation(StoreEvaluationRequest(data, attemptId), token);
      responseResult = ScoreCardModel(
        //TODO: change the hard code numbers as the response is null
        maxScore: int.parse('20'),//response.data.maxScore
        expectedScore: int.parse(response.data.expectedScore),
        actualScore: int.parse('10'),//response.data.actualScore
        buddyWords: response.data.buddyWord,
      );
    } catch (error) {
      throw error;
    }
    return responseResult;
  }


}
