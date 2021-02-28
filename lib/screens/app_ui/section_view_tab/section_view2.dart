import 'dart:ui';

import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/timer_section/exercise_timer_home.dart';
import 'package:bench_test_buddies/widgets/heading_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Evaluationscreen/evaluation_home.dart';
import 'Resultscreen/view_result_home.dart';
import 'upload_image_screen/image_section_home.dart';

class SectionViewTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    final userData = Provider.of<UserLevel>(
      context,
    ).userData;
    var isLoading = false;

    final userUpcomingStage = Provider.of<ExerciseStages>(context)
        .findByStages(userData.upcomingSection);
    final userFinishedExercise = Provider.of<ExerciseStages>(context)
        .findByStages(userData.completedExercise);
    final stages = Provider.of<ExerciseStages>(context, listen: false).stages;
    final currentExerciseStage = Provider.of<ExerciseStages>(context)
        .findByStage(userData.currentSection);
    final userCurrentExercise = Provider.of<Exercises>(context)
        .findExerciseById(userData.userExerciseId);

    final numbers =
        Provider.of<ExerciseStages>(context).getPositionsOfExerciseStages;
    List<int> addingFinishedExerciseForDotIndicator = [];

    bool whetherNumberIsFinished(int number) {
      if (number <= userFinishedExercise.length) {
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : SizedBox(
              child: ListView(
              children: [
                Container(
                    height: mediaQueryHeight * 0.10,
                    width: mediaQueryWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(userCurrentExercise.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ))),
                Container(
                  height: MediaQuery.of(context).size.height * 0.19,
                  width: mediaQueryWidth,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 7),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 11),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            height: constraints.maxHeight * 0.2,
                            width: constraints.maxWidth * 0.6,
                            child: Text(
                              'Status of the latest attempt',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 12,
                              ),
                            )),
                        SizedBox(
                            height: constraints.maxHeight * 0.5,
                            width: constraints.maxWidth * 0.8,
                            child: ListView.separated(
                              itemCount: numbers.length,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Container(
                                height: constraints.maxHeight * 0.39,
                                width: constraints.maxWidth * 0.1,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      whetherNumberIsFinished(numbers[index]) ==
                                              true
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  numbers[index].toString(),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: whetherNumberIsFinished(
                                                numbers[index]) ==
                                            true
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              separatorBuilder: (context, index) {
                                if (whetherNumberIsFinished(numbers[index]) ==
                                    true) {
                                  return Padding(
                                    padding:EdgeInsets.only(left:constraints.maxWidth*0.0035,right: constraints.maxWidth*0.0035),
                                    child: SizedBox(
                                      width: constraints.maxWidth * 0.122,
                                      child: Divider(
                                        color: Theme.of(context).primaryColor,
                                        thickness: 1.2,
                                        indent: 2,
                                        endIndent: 2,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding:EdgeInsets.only(right: constraints.maxWidth*0.01),
                                    child: SizedBox(
                                      width: constraints.maxWidth * 0.122,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) =>
                                              SizedBox(
                                                width: constraints.maxWidth*0.035,
                                                child: Divider(
                                                  thickness: 1,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  indent: 3,
                                                  endIndent: 3,
                                                ),
                                              )),
                                    ),
                                  );
                                }
                              },
                            )),

                        SizedBox(
                            height: constraints.maxHeight * 0.3,
                            width: constraints.maxWidth * 0.9,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: stages.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        right: constraints.maxWidth * 0.029),
                                    width: constraints.maxWidth * 0.2,
                                    child: Text('${stages[index]['stage']}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                            fontSize: 11)),
                                  );
                                }))
                      ],
                    );
                  }),
                ),
                Container(
                  height: ((() {
                    if (currentExerciseStage['step'] ==
                        Stages.Completed_stage) {
                      return MediaQuery.of(context).size.height * 0.05;
                    }
                    if (userUpcomingStage.isEmpty) {
                      return MediaQuery.of(context).size.height * 0.22;
                    }
                    switch (userUpcomingStage.length) {
                      case 1:
                        return MediaQuery.of(context).size.height * 0.38;
                        break;
                      case 2:
                        return MediaQuery.of(context).size.height * 0.50;
                        break;
                    }
                  }())),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (currentExerciseStage['step'] !=
                          Stages.Completed_stage)
                        Padding(
                          padding: EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            'Inprogress section',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      if (currentExerciseStage['step'] !=
                          Stages.Completed_stage)
                        InkWell(
                          onTap: () {
                            switch (currentExerciseStage['step']) {
                              case Stages.Start_the_exercise:
                                {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ExerciseTimerHome()));
                                }
                                break;
                              case Stages.Uploaded_images:
                                {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PractisedImages()));
                                }
                                break;
                              case Stages.Evaluate_the_result:
                                {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EvaluationHome()));
                                }

                                break;
                              case Stages.View_the_results:
                                {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ViewResultHome()));
                                  break;
                                }
                            }
                          },
                          child: HeadingCard(
                            iconPath: currentExerciseStage['icon'],
                            arrow: true,
                            stageName: currentExerciseStage['stage'],
                          ),
                        ),
                      if (userUpcomingStage.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            'Upcoming section',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      if (userUpcomingStage.isNotEmpty)
                        SizedBox(
                          height: ((() {
                            switch (userUpcomingStage.length) {
                              case 1:
                                return MediaQuery.of(context).size.height *
                                    0.12;
                                break;
                              case 2:
                                return MediaQuery.of(context).size.height *
                                    0.23;
                                break;
                              case 3:
                                return MediaQuery.of(context).size.height *
                                    0.35;
                            }
                          }())),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: userUpcomingStage.length,
                            itemBuilder: (context, index) => SizedBox(
                              width: double.infinity,
                              child: HeadingCard(
                                iconPath: userUpcomingStage[index]['icon'],
                                arrow: false,
                                stageName: userUpcomingStage[index]['stage'],
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15),
                        child: Text(
                          'Completed Section',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: ((() {
                    switch (userFinishedExercise.length) {
                      case 1:
                        return MediaQuery.of(context).size.height * 0.12;
                        break;
                      case 2:
                        return MediaQuery.of(context).size.height * 0.23;
                        break;
                      case 3:
                        return MediaQuery.of(context).size.height * 0.35;
                        break;
                      case 4:
                        return MediaQuery.of(context).size.height * 0.46;
                        break;
                    }
                  }())),
                  color: Theme.of(context).backgroundColor,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: userFinishedExercise.length,
                    itemBuilder: (context, index) => HeadingCard(
                      iconPath: userFinishedExercise[index]['icon'],
                      stageName: userFinishedExercise[index]['stage'],
                    ),
                  ),
                ),
              ],
            )),
    );
  }
}
