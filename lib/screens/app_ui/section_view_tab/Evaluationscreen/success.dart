
import 'package:bench_test_buddies/provider/attempt_official_provider.dart';
import 'package:bench_test_buddies/provider/evaluation_questions_provider.dart';

import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/Resultscreen/view_result_home.dart';

import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class Success extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    String token = Provider.of<UserLogData>(context, listen: false).token;
    int attemptId=Provider.of<AttemptOfficial>(context,listen: false).newCreatedAttempt;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: Provider.of<EvaluationsQuestionsProvider>(context,listen:false)
              .storeAndGetEvaluationData(attemptId: attemptId,token: token),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return  AlertDialog(
                actions: [TextButton(onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }, child: Text('Something went wrong'))],
              );
            }
            if(snapshot.connectionState==ConnectionState.done)
              {
                return  ViewResultHome(
                      scoreCardModel: snapshot.data,
                    );
              }
            else
            return Column(
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
            );
          }
        ),
      ),
    );
  }
}
