import 'package:bench_test_buddies/provider/attempt_provider.dart';
import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import'package:bench_test_buddies/widgets/attempt_card.dart';
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

    final exerciseAttempt=Provider.of<AttemptedList>(context).getUserAttempt(userData.userExerciseId);

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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:EdgeInsets.only(top: 10),
                    child: Text(userCurrentExercise.name,

                        style: TextStyle(height: 1,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        )),
                  ),
                   RichText(
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Total Attempts',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: exerciseAttempt.length.toString(),
                          style: TextStyle(
                            color:Theme.of(context).primaryColor,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Container(
            height: mediaQueryHeight*85,
            width: mediaQueryWidth,
            color: Colors.white,
            child: ListView.builder(itemCount:exerciseAttempt.length,itemBuilder:(context,index)=>AttemptCard(
               attemptNumber: index+1,
               attemptedDate: exerciseAttempt[index].attemptedDate,
              scoreCard: exerciseAttempt[index].scoreCard,
            ) ),

          ),
        ],
      ),
    );
  }
}
