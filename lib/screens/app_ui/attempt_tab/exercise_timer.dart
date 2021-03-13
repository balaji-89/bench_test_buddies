import 'package:bench_test_buddies/model/attempt_official_model.dart';
import 'package:bench_test_buddies/provider/attempt_official_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExerciseTimer extends StatelessWidget {
  final int attemptId;

  ExerciseTimer({@required this.attemptId});


  DateTime getTimeFromString(String apiTime){
    int formattedHour;
    int formattedMinutes;
    int formattedSeconds;
    List<String> splitTime=apiTime.split(":");
    formattedHour=int.parse(splitTime[0]);
    formattedMinutes=int.parse(splitTime[1]);
    formattedSeconds=int.parse(splitTime[2]);
    DateTime dateTime=DateTime(2021,1,1, formattedHour,formattedMinutes,formattedSeconds,0,0);
   return dateTime;

  }

  @override
  Widget build(BuildContext context) {
    final Attempt attempt =
        Provider.of<AttemptOfficial>(context,listen:false).currentAttemptTimeStamps;
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
            color: Color(0xfff232323),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Exercise Timer',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff232323),
                fontSize: 18,
            )),
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
          color: Color(0xffffffff),
          padding: EdgeInsets.only(left: 14, top: 16, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${attemptKey[index]}:',
                style: TextStyle(
                  color: Color(0xFF232323),
                  wordSpacing: 0.4,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              if (index <= 2)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: index == 2
                              ? ''
                              : '${DateFormat.H().format(getTimeFromString(attemptValue[index]),
                                )}h  '),
                      TextSpan(
                          text: '${DateFormat.m().format(getTimeFromString(attemptValue[index]))}m'),
                    ],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              if (index > 2)
                Text(
                  '${DateFormat().add_jm().format(getTimeFromString(attemptValue[index]))}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
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
