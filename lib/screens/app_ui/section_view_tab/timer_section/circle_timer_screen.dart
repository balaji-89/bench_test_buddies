import 'dart:ui';

import 'package:bench_test_buddies/screens/app_ui/section_view_tab/timer_section/task_finished_time_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:intl/intl.dart';

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
  final startedTime = DateTime.now();
  DateTime finishedTime;
  DateTime extendedTime = DateTime(2021, 1, 1, 0, 20, 0);
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

  void changeEndsOnTime() {
    setState(() {
      endsOnTime = DateTime.now().add(initialTime);
    });
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

  void resumeFunction() {
    _timerController.start();
    setState(() {
      backgroundColor = Theme.of(context).primaryColor;
      pause = false;
    });
    changeEndsOnTime();
  }

  void pauseFunction() {
    _timerController.pause();
    setState(() {
      backgroundColor = Color.fromRGBO(214, 167, 47, 1);
      pause = true;
    });
  }

  void onTimeOver() {
    finishedTime = DateTime.now();
    totalTime = widget.timeSelected.add(Duration(
      hours: extendedTime.hour,
      minutes: extendedTime.minute,
      seconds: extendedTime.second,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Align(
          alignment: Alignment.bottomCenter,
          child: Text("Exercise Timer",
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
              )),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Settings()));
              },
              child: Text(
                'Settings',
                textAlign: TextAlign.end,
                style: TextStyle(
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
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
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
                        progressIndicatorColor: Colors.white.withOpacity(0.9),
                        progressIndicatorDirection:
                            TimerProgressIndicatorDirection.clockwise,
                        progressTextCountDirection:
                            TimerProgressTextCountDirection.count_down,
                        displayProgressIndicator: true,
                        progressTextStyle: TextStyle(
                          color: Colors.black,
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
                                _timerController.reset();
                                _timerController.start();
                              },
                              child: CircleAvatar(
                                radius: constraints.maxHeight * 0.065,
                                backgroundColor: Color.fromRGBO(189, 74, 74, 1),
                                child: Text("Reset",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                              ),
                            ),
                            GestureDetector(
                              onTap: pause == true
                                  ? resumeFunction
                                  : pauseFunction,
                              child: CircleAvatar(
                                  radius: constraints.maxHeight * 0.065,
                                  backgroundColor: pause == true
                                      ? Colors.green
                                      : Color.fromRGBO(214, 167, 47, 1),
                                  child: Text(
                                      pause == true ? "Resume" : "Pause",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15))),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap:(){
                            onTimeOver();
                            returnDialog();
                          } ,
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
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TaskFinishedTimerScreen(
                      exerciseName:widget.exerciseName,
                      initialTimeSet: widget.timeSelected,
                      totalTimeTaken: totalTime,
                      extendedBy: extendedTime,
                      startedTime:startedTime ,
                      endedTime: finishedTime,
                    )));
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
