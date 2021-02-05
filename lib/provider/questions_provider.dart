import'package:flutter/material.dart';

class QuestionModel{
  String title;
  String question;
  int id;
  int questionType;
  int isAnswered;

  QuestionModel({
      @required this.title, @required this.question,@required  this.id, @required this.questionType, @required this.isAnswered});
}
class QuestionsProvider with ChangeNotifier{
  List<QuestionModel> questions=[

  ];

  void getAllQuestions(){


  }

}