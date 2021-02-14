import 'package:bench_test_buddies/provider/evaluation_questions_provider.dart';
import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';

import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import 'image_question.dart';
import 'video_question.dart';

class EvaluationHome extends StatefulWidget {
  @override
  _EvaluationHomeState createState() => _EvaluationHomeState();
}

class _EvaluationHomeState extends State<EvaluationHome> {
   String userToken;
   int currentExerciseId;
   List<Question> questions=[];
   int questionSelectingIndex;
   
   bool questionOver=false;
    Future<void> initialize(BuildContext context)async{
      try{
        questions=await Provider.of<EvaluationsQuestionsProvider>(context,listen: false).getExerciseQuestion(currentExerciseId,userToken);
      }catch(error){
        print(error);
      }


           }


   Widget getQuestionScreen(){
        if (questions[questionSelectingIndex].image != null) {
          return ImageQuestion();
        }
        else
          return VideoQuestion();

   }


   @override
  Widget build(BuildContext context) {
    questionSelectingIndex=Provider.of<EvaluationsQuestionsProvider>(context).currentQuestionIndex;
    userToken = Provider.of<UserLogData>(context,listen:false).token;
    currentExerciseId = Provider.of<Exercises>(context,listen:false).selectedExercise.id;


    return Scaffold(
      body: FutureBuilder(
          future: questions.isEmpty||questions==null?initialize(context):Future.delayed(Duration.zero),
          builder: (context, snapShot) {
            if(snapShot.connectionState==ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            return getQuestionScreen();


          }),
    );
  }
}
