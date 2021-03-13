import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:bench_test_buddies/provider/evaluation_questions_provider.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/Evaluationscreen/degree.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/Evaluationscreen/success.dart';
import 'package:better_player/better_player.dart';
import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class VideoQuestion extends StatefulWidget {
  @override
  _VideoQuestionState createState() => _VideoQuestionState();
}

class _VideoQuestionState extends State<VideoQuestion> {

  BetterPlayerController _betterPlayerController;

  void initializeVideo(String videoUrl) {
    BetterPlayerDataSource betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, videoUrl);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestionSet=Provider.of<EvaluationsQuestionsProvider>(context,listen:false).getQuestion();
    var evaluationQuestionPath=Provider.of<EvaluationsQuestionsProvider>(context,listen: false);
    //initializeVideo(currentQuestionSet.video);
    final userData = Provider.of<UserLevel>(context, listen: true).userData;
    final currentExerciseStages =
    Provider.of<ExerciseStages>(context, listen: false)
        .findByStage(userData.currentSection);
    bool isLastQuestion =
        Provider.of<EvaluationsQuestionsProvider>(context).isLastQuestion;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff232323),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Evaluation',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff232323),
                fontSize: 18,
            )),
        elevation: 1,
        centerTitle: true,
        titleSpacing: 0.3,
        actions: [
          FlatButton(
              onPressed: () {
                if (isLastQuestion) {
                  Provider.of<UserLevel>(context, listen: false)
                      .changeUserStage(currentExerciseStages['step']);
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Success()));
                }
              },
              child: Text(
                'Submit',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 15,
                  color: isLastQuestion
                      ? Theme.of(context).primaryColor
                      :Colors.grey,
                ),
              ))
        ],
      ),
      body:
      LayoutBuilder(
        builder: (context, constraints) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.1,
              width: constraints.maxWidth,
              child: Center(
                child: Text('Criteria:${currentQuestionSet.title}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff232323),
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    )),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.4,
              width: constraints.maxWidth,
              child: BetterPlayer.network(
                currentQuestionSet.video,
                betterPlayerConfiguration: BetterPlayerConfiguration(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  allowedScreenSleep: false,
                  autoDispose: true,
                  fullScreenByDefault: false,
                ),
              ),
            ),
            Container(
              width: constraints.maxWidth * 1,
              height: constraints.maxHeight * 0.05,
              color: Colors.grey.withOpacity(0.3),
              margin: EdgeInsets.only(bottom: 20),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Q.${evaluationQuestionPath.currentQuestionIndex+1} /",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff232323),
                        ),
                      ),
                      TextSpan(
                        text:  "${evaluationQuestionPath.questions.length}",
                        style: TextStyle(
                          fontWeight:FontWeight.w400,
                          color: Color(0xff232323),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${currentQuestionSet.question}',
                textAlign: TextAlign.left,
                style: TextStyle(
                   color:Color(0xff232323),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                  top: constraints.maxHeight * 0.03,
                ),
                height: constraints.maxHeight * 0.065,
                width: constraints.maxWidth - 30,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Color(0xffffffff),
                  color: Theme.of(context).primaryColor,
                  child: Text('Enter the value'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Degree(),
                      ),
                    );
                  },
                )),
            Spacer(),
            Container(
              margin: EdgeInsets.only(
                top: constraints.maxHeight * 0.095,
                bottom: constraints.maxHeight * 0.03,
              ),
              child: Divider(
                thickness: 2,
                color: Colors.grey[300],
                height: 1,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.03),
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.05,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: constraints.maxWidth * 0.088,
                      height: constraints.maxHeight * 0.04,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: questions[index]['bool'] == false ||
                                  questions[index]['bool'] == 'in_progress'
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(3),
                          border: questions[index]['bool'] == 'in_progress'
                              ? Border.all(
                                  color: Theme.of(context).primaryColor,
                                )
                              : null),
                      child: Text(
                        "${questions[index]['question']}",
                        style: TextStyle(
                            fontSize: 18,
                            color: questions[index]['bool'] == false ||
                                    questions[index]['bool'] == 'in_progress'
                                ? Colors.white
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
       ),
    );
  }

  List<Map<String, dynamic>> questions = [
    {
      'question': 1,
      'bool': false,
    },
    {
      'question': 2,
      'bool': false,
    },
    {
      'question': 3,
      'bool': true,
    },
    {
      'question': 4,
      'bool': false,
    },
    {
      'question': 5,
      'bool': 'in_progress',
    },
    {
      'question': 6,
      'bool': false,
    },
    {
      'question': 7,
      'bool': true,
    },
  ];
}

