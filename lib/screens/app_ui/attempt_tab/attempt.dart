import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttemptTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double mediaQueryHeight = MediaQuery.of(context).size.height;
    final double mediaQueryWidth = MediaQuery.of(context).size.width;

    final userData = Provider.of<Users>(context, listen: false).userData;

    final userCurrentExercise = Provider.of<Exercises>(context, listen: false)
        .findExerciseById(userData.userExerciseId);

    return SizedBox(
      height: mediaQueryHeight,
      width: mediaQueryWidth,
      child: ListView(
        children: [
          Container(
              height: mediaQueryHeight * 0.10,
              width: mediaQueryWidth,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(userCurrentExercise.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      )),
                   Text(userCurrentExercise.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      )),

                ],
              )),
        ],
      ),
    );
  }
}
