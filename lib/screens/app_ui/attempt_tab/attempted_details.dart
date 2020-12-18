import 'dart:ui';

import 'package:bench_test_buddies/screens/app_ui/attempt_tab/exercise_timer.dart';
import 'package:bench_test_buddies/screens/app_ui/attempt_tab/score_card.dart';
import 'package:bench_test_buddies/screens/app_ui/attempt_tab/view_results.dart';
import 'package:flutter/material.dart';

class AttemptedDetails extends StatelessWidget {
  final int attemptNumber;
  final int attemptId;

  AttemptedDetails({@required this.attemptNumber, @required this.attemptId });

  @override
  Widget build(BuildContext context) {
    final List<Map> attemptCharacteristics = [
      {
        'name': 'Score Card',
        'image': 'assets/Home_page_images/Questions.png',
      },
      {
        'name': 'Exercise Time',
        'image': 'assets/Home_page_images/spaceship.png',
      },
      {
        'name': 'View Results',
        'image': 'assets/Home_page_images/ezgif.com-gif-maker.png',
      },
      {
        'name': 'Uploaded Images',
        'image': 'assets/Home_page_images/upload.png',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Attempt ${attemptNumber.toString()}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
                letterSpacing: 0.8)),
        elevation: 1,
        centerTitle: true,
        titleSpacing: 0.3,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: attemptCharacteristics.length,
          itemBuilder: (context, index) =>  Container(height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.93,
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 13,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              offset: Offset(1, 1),
              blurRadius: 2.0,
              spreadRadius: 0.5,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-0, -0),
              blurRadius: 1.0,
              spreadRadius: 1,
            ),
          ],
        ),child:ListTile(
            leading: SizedBox(
              height: MediaQuery.of(context) .size.height* 0.45,
              width: MediaQuery.of(context) .size.width*0.1,
              child: Image.asset('${attemptCharacteristics[index]['image']}'),
            ),
            title: Text('${attemptCharacteristics[index]['name']}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                )),
            trailing: IconButton(
              icon:
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
              onPressed: () {
                switch(attemptCharacteristics[index]['name']){
                  case 'Score Card':Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScoreCard(attemptId: attemptId,)));
                  break;
                  case 'Exercise Time':Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExerciseTimer(attemptId: attemptId,)));
                  break;
                  case 'View Results':Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewResults(attemptId: attemptId,)));
                }
              },
            ),),
          ),
        ),
      ),
    );
  }
}
