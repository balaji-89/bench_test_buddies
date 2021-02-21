import 'package:bench_test_buddies/provider/attempt_official_provider.dart';
import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../upload_image_screen/uploaded_images.dart';

class TaskFinishedTimerScreen extends StatefulWidget {
  final String exerciseName;
  final DateTime totalTimeTaken;
  final DateTime initialTimeSet;
  final DateTime extendedBy;
  final DateTime startedTime;
  final DateTime endedTime;

  TaskFinishedTimerScreen(
      {@required this.exerciseName,
      @required this.totalTimeTaken,
      @required this.initialTimeSet,
      @required this.extendedBy,
      @required this.startedTime,
      @required this.endedTime});

  @override
  _TaskFinishedTimerScreenState createState() =>
      _TaskFinishedTimerScreenState();
}

class _TaskFinishedTimerScreenState extends State<TaskFinishedTimerScreen> {


  void timeInitializer(context) {
    Provider.of<AttemptOfficial>(context, listen: false).currentDataInitialize(
      exerciseId:
          Provider.of<Exercises>(context, listen: false).selectedExercise.id,
      startTime: DateFormat('HH:mm:ss').format(widget.startedTime),
      endTime: DateFormat('HH:mm:ss').format(widget.endedTime),
      extraTimeTaken: DateFormat('HH:mm:ss').format(widget.extendedBy),
      actualTimeTaken: DateFormat('HH:mm:ss').format(widget.totalTimeTaken),
      initialTimeSet: DateFormat('HH:mm:ss').format(widget.initialTimeSet),
    );
  }
   void createAttempt(context,int exerciseId,String token){
     Provider.of<AttemptOfficial>(context,listen: false)
         .createNewAttempt(exerciseId, token);
   }
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserLevel>(context, listen: true).userData;
    final int currentExercise = Provider.of<Exercises>(context,listen:false).selectedExercise.id;
    final String token = Provider.of<UserLogData>(context,listen:false).token;
    createAttempt(context,currentExercise,token);
    final currentExerciseStages =
        Provider.of<ExerciseStages>(context, listen: false)
            .findByStage(userData.currentSection);
    timeInitializer(context);
    final attemptTiming = {
      'Total time Taken': widget.totalTimeTaken,
      'Initial time Taken': widget.initialTimeSet,
      'Time Extended by': widget.extendedBy,
      'Time started at': widget.startedTime,
      'Time Ends at': widget.endedTime,
    };
    final attemptKey = attemptTiming.keys.toList();
    final attemptValue = attemptTiming.values.toList();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: SizedBox(),
        title: Text('Timer Summary',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
                letterSpacing: 0.7)),
        elevation: 1,
        centerTitle: true,
        titleSpacing: 0.3,
      ),
      body:  Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).accentColor,
                  alignment: Alignment.center,
                  child: Text(
                    '${widget.exerciseName}',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    itemCount: attemptTiming.length,
                    itemBuilder: (context, index) => Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 14, top: 12, bottom: 12),
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
                                          '${DateFormat.m().format(attemptValue[index])}m'),
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
                      height: MediaQuery.of(context).size.height * 0.018,
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.065,
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.only(bottom: 12),
                    child: RaisedButton(
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        child: Text('Continue to upload the images'),
                        onPressed: () {
                          Provider.of<UserLevel>(context, listen: false)
                              .changeUserStage(currentExerciseStages['step']);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PractisedImages()));
                        })),
              ],
            ),
    );
  }
}
