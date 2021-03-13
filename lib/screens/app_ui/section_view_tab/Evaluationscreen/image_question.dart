import 'package:bench_test_buddies/provider/evaluation_questions_provider.dart';
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/Evaluationscreen/success.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'evaluation_home.dart';

class ImageQuestion extends StatefulWidget {
  @override
  _ImageQuestionState createState() => _ImageQuestionState();
}

class _ImageQuestionState extends State<ImageQuestion> {
  int userSelectedAnswer;
  bool yesButtonColor=false;
  bool noButtonColor=false;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserLevel>(context, listen: true).userData;
    final currentExerciseStages =
        Provider.of<ExerciseStages>(context, listen: false)
            .findByStage(userData.currentSection);
    bool isLastQuestion =
        Provider.of<EvaluationsQuestionsProvider>(context).isLastQuestion;

    Question currentQuestionSet =
        Provider.of<EvaluationsQuestionsProvider>(context, listen: false)
            .getQuestion();
    var evaluationQuestionPath =
        Provider.of<EvaluationsQuestionsProvider>(context, listen: false);
    final carouselImage = [
      Container(
        child: Text('${currentQuestionSet.image}'),
      ),
      Container(color: Colors.blue),
      Container(color: Colors.black)
    ];
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
                  fontWeight: FontWeight.w600,
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
                        : Colors.grey.withOpacity(0.7),
                  ),
                ))
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.1,
                width: constraints.maxWidth,
                child: Center(
                  child: Text('Criteria: ${currentQuestionSet.title}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff232323),
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      )),
                ),
              ),
              // currentQuestionSet.image.length<=1?SizedBox(
              //   height: constraints.maxHeight * 0.46,
              //   width: constraints.maxWidth,
              //     child: Text('${currentQuestionSet.image[0]}'),
              // ):
              SizedBox(
                height: constraints.maxHeight * 0.46,
                width: constraints.maxWidth,
                child: Carousel(
                  images: carouselImage,
                  dotColor: Theme.of(context).accentColor,
                  dotBgColor: Theme.of(context).backgroundColor,
                  dotIncreasedColor: Theme.of(context).primaryColor,
                  dotVerticalPadding: 0,
                  dotPosition: DotPosition.bottomCenter,
                  animationDuration: Duration(seconds: 1),
                  animationCurve: Curves.bounceOut,
                  showIndicator: true,
                  autoplay: false,
                  dotIncreaseSize: 1.1,
                  dotSpacing: 20,
                  dotHorizontalPadding: 15,
                ),
              ),
              Container(
                width: constraints.maxWidth * 1,
                height: constraints.maxHeight * 0.05,
                color: Theme.of(context).accentColor,
                margin: EdgeInsets.only(bottom: 20),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              "Q.${evaluationQuestionPath.currentQuestionIndex + 1} /",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff232323),
                          ),
                        ),
                        TextSpan(
                          text: "${evaluationQuestionPath.questions.length}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
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
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: constraints.maxHeight * 0.055,
                    width: constraints.maxWidth * 0.45,
                    color:yesButtonColor==true?Theme.of(context).primaryColor:Colors.white,
                    child: OutlineButton(
                      color: yesButtonColor==true?Theme.of(context).primaryColor:Colors.white,

                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          yesButtonColor=true;
                        });
                        Provider.of<EvaluationsQuestionsProvider>(context,listen: false).storeUsersAnswers(1);
                        if (!isLastQuestion) {
                          Provider.of<EvaluationsQuestionsProvider>(context,
                                  listen: false)
                              .incrementQuestionIndex();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => EvaluationHome()));
                        }
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          color: yesButtonColor==true?Color(0xffffffff):Color(0xff232323),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.055,
                    width: constraints.maxWidth * 0.45,
                    color:noButtonColor==true?Theme.of(context).primaryColor:Color(0xffffffff),
                    child: OutlineButton(
                      color: noButtonColor==true?Theme.of(context).primaryColor:Color(0xffffffff),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                      onPressed: () {
                        setState(() {
                          noButtonColor=true;
                        });
                        Provider.of<EvaluationsQuestionsProvider>(context,listen: false).storeUsersAnswers(0);
                        if (!isLastQuestion) {
                          Provider.of<EvaluationsQuestionsProvider>(context,
                                  listen: false)
                              .incrementQuestionIndex();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => EvaluationHome()));
                        }
                      },
                      child: Text(
                        "No",
                        style: TextStyle(
                          color: noButtonColor==true?Color(0xffffffff):Color(0xff232323),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
              SizedBox(
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
        ));
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
