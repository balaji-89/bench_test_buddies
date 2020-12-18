import 'package:bench_test_buddies/model/attempt_model.dart';
import 'package:bench_test_buddies/provider/attempt_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExerciseTimer extends StatelessWidget {
  final int attemptId;

  ExerciseTimer({@required this.attemptId});

  @override
  Widget build(BuildContext context) {
    final UserAttempt attempt =
        Provider.of<AttemptedList>(context).findById(attemptId);
    final attemptTiming = {
      'Total time Taken': attempt.totalTimeTaken,
      'Initial time Taken': attempt.initialTimeSet,
      'Time Extended by': attempt.timeExtended,
      'Time started at': attempt.timeStarted,
      'Time Ends at': attempt.timeEndsAt,
    };
    final attemptKey = attemptTiming.keys.toList();
    final attemptValue = attemptTiming.values.toList();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
        title: Text('Exercise Timer',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
                letterSpacing: 0.7)),
        elevation: 1,
        centerTitle: true,
        titleSpacing: 0.3,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(0),
        itemCount: attemptTiming.length,
        itemBuilder: (context, index) => Container(
          height: MediaQuery.of(context).size.height * 0.13,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: EdgeInsets.only(left:14,top:16,bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${attemptKey[index]}:',
                style: TextStyle(
                  color: Colors.black,
                  wordSpacing: 0.4,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              if (index <= 2)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: index == 2
                              ? ''
                              : '${DateFormat.H().format(attemptValue[index])}h  '),
                      TextSpan(
                          text:
                              '${DateFormat.M().format(attemptValue[index])}m'),
                    ],
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                  ),
                ),
              if (index > 2)
                Text(
                  '${DateFormat().add_jm().format(attemptValue[index])}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
            ],
          ),
        ),
        separatorBuilder: (context, index) => Container(
          height: MediaQuery.of(context).size.height * 0.01,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
