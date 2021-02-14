import 'package:bench_test_buddies/model/attempt_official_model.dart';
import 'package:bench_test_buddies/provider/evaluation_questions_provider.dart';
import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/Resultscreen/view_result_home.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class Success extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    Future navigateToNextPage() async {
      int exerciseId =
          Provider.of<Exercises>(context, listen: false).selectedExercise.id;
      String token = Provider.of(context, listen: false).userToken;
      Future.delayed(Duration(seconds: 1), () async {
        try {
          ScoreCardModel response =
              await Provider.of<EvaluationsQuestionsProvider>(context)
                  .storeAndGetEvaluationData(
                      exerciseId: exerciseId, evaluationId: 2, token: token);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ViewResultHome(
                    scoreCardModel: response,
                  )));
        } catch (error) {
          print(error);
        }
      });
    }

    navigateToNextPage();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Spacer(),
            PreferredSize(
              preferredSize: Size.fromHeight(mediaQuery.height * 0.2),
              child: Center(
                child: CircleAvatar(
                    backgroundColor: Colors.green,
                    maxRadius: mediaQuery.width * 0.10,
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: mediaQuery.height * 0.08,
                    )),
              ),
            ),
            Center(
              child: Text(
                "\nEvaluation Submitted \n         Successfully",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text("System calculating the score: ",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text("    15 seconds",
                  style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
