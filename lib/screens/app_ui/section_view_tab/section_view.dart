import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import '../home_tabs.dart';
import 'package:flutter/material.dart';
import 'package:bench_test_buddies/widgets/heading_card.dart';
import 'package:provider/provider.dart';

import 'timer_section/exercise_timer_home.dart';

class SectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final userData = Provider.of<UserLevel>(context, listen: true).userData;

    final userUpcomingStage =
        Provider.of<ExerciseStages>(context, listen: false)
            .findByStages(userData.upcomingSection);
    final currentExerciseStages =
        Provider.of<ExerciseStages>(context, listen: false)
            .findByStage(userData.currentSection);

    final userCurrentExercise = Provider.of<Exercises>(context, listen: false)
        .findExerciseById(userData.userExerciseId);

    return SizedBox(
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
          width: mediaQueryWidth,
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 7),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 14),
          child: Text(
            userCurrentExercise.description == null
                ? "description"
                : userCurrentExercise.description,
            style: TextStyle(
              height: 1.3,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.7),
              wordSpacing: 1.2,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          height: mediaQueryHeight * 0.22,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15, left: 15),
                child: Text(
                  'Current Section',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w700),
                ),
              ),
              InkWell(
                onTap: () {
                  if (currentExerciseStages['step'] !=
                      Stages.Start_the_exercise) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ExerciseTimerHome()));
                },
                child: SizedBox(
                  width: double.infinity,
                  child: HeadingCard(
                    iconPath: currentExerciseStages['icon'],
                    arrow: true,
                    stageName: currentExerciseStages['stage'],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 15),
                child: Text(
                  'Upcoming Section',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.36,
          color: Theme.of(context).backgroundColor,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: userUpcomingStage.length,
            itemBuilder: (context, index) => HeadingCard(
              iconPath: userUpcomingStage[index]['icon'],
              stageName: userUpcomingStage[index]['stage'],
            ),
          ),
        ),
      ],
    ));
  }
}
