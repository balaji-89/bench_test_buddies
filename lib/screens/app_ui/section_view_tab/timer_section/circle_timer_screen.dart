import 'dart:ui';

import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/timer_section/exercise_timer_home.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/timer_section/task_finished_time_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_timer/simple_timer.dart';

import 'settings.dart';

class CircleTimerScreen extends StatefulWidget {
  final String exerciseName;
  final DateTime timeSelected;

  CircleTimerScreen({@required this.exerciseName, @required this.timeSelected});

  @override
  _CircleTimerScreenState createState() => _CircleTimerScreenState();
}

class _CircleTimerScreenState extends State<CircleTimerScreen>
    with SingleTickerProviderStateMixin {
  final DateTime startedTime = DateTime.now();
  DateTime finishedTime;
  DateTime extendedTime;

  DateTime totalTime;

  Duration initialTime;

  TimerController _timerController;

  var formattedDate;

  DateTime endsOnTime;

  Future<void> start() async {
    Future.delayed(Duration.zero, () {
      _timerController.start(startFrom: initialTime, useDelay: true);
    });
  }

  String dateTimeToString(DateTime time) {
    String changedFormat = DateFormat('HH:mm:ss').format(time);
    return changedFormat;
  }

  void changeEndsOnTime() {
    setState(() {
      endsOnTime = DateTime.now().add(initialTime);
    });
  }
  void doneFunction(){
    _timerController.pause();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Completed'),
          content: Text('Are you sure you want to mark it completed?'),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _timerController.start();
                },
                child: Text('No')),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onTimeOver();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              TaskFinishedTimerScreen(
                                exerciseName: widget
                                    .exerciseName,
                                initialTimeSet: widget
                                    .timeSelected,
                                totalTimeTaken:
                                totalTime,
                                extendedBy:
                                extendedTime,
                                startedTime:
                                startedTime,
                                endedTime:
                                finishedTime,
                              )));
                },
                child: Text('Yes')),
          ],
        ));
  }

  @override
  void initState() {
    _timerController = TimerController(this);
    initialTime = Duration(
      hours: widget.timeSelected.hour,
      minutes: widget.timeSelected.minute,
      seconds: widget.timeSelected.second,
    );
    start();
    endsOnTime = DateTime.now().add(initialTime);
    formattedDate = DateFormat().add_jm().format(endsOnTime);
    super.initState();
  }

  Color backgroundColor = Color(0xFF4667EE);
  bool pause = false;

  void resetFunction(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Reset'),
              content: Text(
                'Are you sure you want to reset the timer?',
                style: TextStyle(color: Color(0xff232323)),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _timerController.start();
                    },
                    child: Text('No')),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExerciseTimerHome()));
                    },
                    child: Text('Yes'))
              ],
            ));
  }

  void resumeFunction() {
    _timerController.start();
    changeEndsOnTime();
    setState(() {
      backgroundColor = Theme.of(context).primaryColor;
      pause = false;
    });
    changeEndsOnTime();
  }

  void pauseFunction() {
    _timerController.pause();
    setState(() {
      backgroundColor = Color(0xfff79703);
      pause = true;
    });
  }

  void onTimeOver() {
    _timerController.stop();
    finishedTime = DateTime.now();
    totalTime = finishedTime.subtract(Duration(
      hours: startedTime.hour,
      minutes: startedTime.minute,
      seconds: startedTime.second,
    ));
    int compare = Duration(
            hours: totalTime.hour,
            minutes: totalTime.minute,
            seconds: totalTime.second)
        .compareTo(Duration(
      hours: widget.timeSelected.hour,
      minutes: widget.timeSelected.minute,
      seconds: widget.timeSelected.second,
    ));
    if (compare == 1) {
      extendedTime = totalTime.subtract(Duration(
          hours: widget.timeSelected.hour,
          minutes: widget.timeSelected.minute,
          seconds: widget.timeSelected.second));
    } else {
      extendedTime = DateTime(
        2021,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String userToken =
        Provider.of<UserLogData>(context, listen: false).token;
    final exercise = Provider.of<Exercises>(context, listen: false)
        .findExerciseByName(widget.exerciseName);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff232323),
          ),
          onPressed: () {
            returnDialog();
          },
        ),
        centerTitle: true,
        title: Align(
          alignment: Alignment.bottomCenter,
          child: Text("Exercise Timer",
              style: TextStyle(
                fontWeight:FontWeight.w600,
                color: Color(0xff232323),
                fontSize: 19,
              )),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              },
              child: Text(
                'Settings',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ))
        ],
      ), //Bar().appBars,
      body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: constraints.maxHeight * 0.08,
                  width: constraints.maxWidth * 0.6,
                  child: Padding(
                    padding: EdgeInsets.only(top: constraints.maxHeight * 0.03),
                    child: Text(
                      widget.exerciseName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xff232323),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.7,
                  height: constraints.maxHeight * 0.5,
                  child: Stack(
                    children: [
                      SimpleTimer(
                        duration: initialTime,
                        controller: _timerController,
                        displayProgressText: true,
                        timerStyle: TimerStyle.ring,
                        backgroundColor: backgroundColor,
                        onEnd: onTimeOver,
                        progressIndicatorColor: Color(0xffffffff).withOpacity(0.9),
                        progressIndicatorDirection:
                            TimerProgressIndicatorDirection.clockwise,
                        progressTextCountDirection:
                            TimerProgressTextCountDirection.count_down,
                        displayProgressIndicator: true,
                        progressTextStyle: TextStyle(
                          color: Color(0xff232323),
                          fontSize: 45,
                        ),
                        strokeWidth: 15,
                      ),
                      Positioned(
                        top: constraints.maxHeight * 0.3,
                        right: constraints.maxWidth * 0.22,
                        child: Text(
                          'Ends on $formattedDate',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.3,
                  width: constraints.maxWidth * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: constraints.maxHeight * 0.15,
                        width: constraints.maxWidth * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                resetFunction(context);
                              },
                              child: CircleAvatar(
                                radius: constraints.maxHeight * 0.065,
                                backgroundColor: Color(0xffE55c4f),
                                child: Text("Reset",
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 16)),
                              ),
                            ),
                            GestureDetector(
                              onTap: pause == true
                                  ? resumeFunction
                                  : pauseFunction,
                              child: CircleAvatar(
                                  radius: constraints.maxHeight * 0.065,
                                  backgroundColor: pause == true
                                      ? Color(0xff4caf50)
                                      : Color(0xfff79703),
                                  child: Text(
                                      pause == true ? "Resume" : "Pause",
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 15))),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap:doneFunction,
                          child: CircleAvatar(
                            radius: constraints.maxHeight * 0.065,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text("Done",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        );
      }),
    );
  }

  void returnDialog() {
    _timerController.stop();
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              titlePadding: EdgeInsets.only(left: 15, top: 20, bottom: 15),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              title: Text(
                "Exit the current Section",
              ),
              content: Text("Are you sure?",
                  style: TextStyle(color: Colors.black87, fontSize: 15)),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    changeEndsOnTime();
                    _timerController.start();
                  },
                  child: Text('Cancel',
                      style: TextStyle(color: Colors.black, fontSize: 13)),
                ),
                FlatButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes',
                      style: TextStyle(color: Colors.green, fontSize: 13)),
                ),
              ],
            ));
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }
}
