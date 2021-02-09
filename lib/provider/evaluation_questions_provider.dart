import 'package:flutter/material.dart';
import 'package:bench_test_service/service/exercise.dart';

class Question {
  int evaluationId;
  int exerciseId;
  String image;
  String video;
  String title;
  String question;
  int answerType;
  int points;
  int answerBoolean;
  int answerDouble;
  String explanation;
  String commonErrorCause;
  String prevent;

  Question(
      {@required this.evaluationId,
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
  int currentQuestionIndex=0;
  bool isLastQuestion=false;

   List<Question> get getAllQuestion{
     return [...questions];
  }

  void incrementQuestionIndex(){
     currentQuestionIndex++;
     if(currentQuestionIndex+1==questions.length){
        isLastQuestion=true;
        notifyListeners();
     }

     print(currentQuestionIndex);
     print(questions.length);

  }

  Question getQuestion(){
     return questions.elementAt(currentQuestionIndex);
  }

  Future<List<Question>> getExerciseQuestion(int id, String token) async {
     if(questions.isEmpty||questions==null){
    try {
      var questionResponse = await Exercise().getExerciseEvaluation(2, token);
      questionResponse.data.map((singleData) {
            questions.add(Question(
            evaluationId: singleData.id,
            exerciseId: singleData.apiExerciseId,
            answerBoolean: singleData.answerBoolean,
            answerDouble: singleData.answerDouble,
            answerType: singleData.answerType,
            explanation: singleData.explanation,
            image: singleData.image,
            points: singleData.points,
            question: singleData.question,
            title: singleData.title,
            video: singleData.video,
            commonErrorCause: singleData.commonErrorCause,
            prevent: singleData.prevent
         ));
      }).toList();
    } catch (error) {
      throw error;
    }}

    return questions;
  }
}
