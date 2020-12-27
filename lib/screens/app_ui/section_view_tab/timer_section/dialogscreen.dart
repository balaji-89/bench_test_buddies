import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bar.dart';
import 'package:simple_timer/simple_timer.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  final String title = "asdfgsadg";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TimerController _timerController;
  TimerStyle _timerStyle = TimerStyle.ring;
  TimerProgressIndicatorDirection _progressIndicatorDirection =
      TimerProgressIndicatorDirection.clockwise;
  TimerProgressTextCountDirection _progressTextCountDirection =
      TimerProgressTextCountDirection.count_down;

  @override
  void initState() {
    // initialize timercontroller
    _timerController = TimerController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("Exercise Timer",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Settings",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ), //Bar().appBars,
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: heights.width * 0.7,
                  height: heights.height * 0.5,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: SimpleTimer(
                    duration: const Duration(seconds: 09),
                    controller: _timerController,
                    displayProgressText: true,
                    timerStyle: _timerStyle,
                    onStart: handleTimerOnStart,
                    onEnd: handleTimerOnEnd,
                    valueListener: timerValueChangeListener,
                    backgroundColor: Colors.grey,
                    progressIndicatorColor: Bar().yello,
                    progressIndicatorDirection: _progressIndicatorDirection,
                    progressTextCountDirection: _progressTextCountDirection,
                    progressTextStyle: TextStyle(color: Colors.black),
                    strokeWidth: 10,
                  ),
                );
              },
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () => showAlertDialog(context),
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Bar().oran,
                                  child: Text("Reset",
                                      style: TextStyle(color: Colors.white)),
                                );
                              },
                            )),
                        SizedBox(
                          width: heights.width * 0.3,
                        ),
                        GestureDetector(
                            onTap: _timerController.pause,
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Bar().yello,
                                    child: Text("Pause",
                                        style: TextStyle(color: Colors.white)));
                              },
                            )),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: GestureDetector(
                      //onTap: exit,
                      child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return CircleAvatar(
                        radius: 40,
                        backgroundColor: Bar().purp,
                        child:
                            Text("Done", style: TextStyle(color: Colors.white)),
                      );
                    },
                  )),
                )
              ],
            ),
          ])),
    );
  }

  exit(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () => Navigator.pop(context),
    );

    AlertDialog alert = AlertDialog(
      buttonPadding: const EdgeInsets.only(right: 60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.all(10),
      title: Center(child: Text("Reset the timer")),
      content: Text(
          "Bench Test Buddy would like to access your camera to capture and save exercise model photos"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) => CupertinoAlertDialog(
              insetAnimationDuration: Duration(seconds: 2),
              title: Center(
                child: Text("Exit the current Section"),
              ),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Are you sure?"),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                CupertinoDialogAction(
                  child: Text(
                    "Ok",
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ));
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text(
        "Don't allow",
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("ok"),
      onPressed: _timerController.reset,
    );

    AlertDialog alert = AlertDialog(
      buttonPadding: const EdgeInsets.only(right: 60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.all(10),
      title: Center(child: Text("Reset the timer")),
      content: Text(
          "Bench Test Buddy would like to access your camera to capture and save exercise model photos"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
        context: context,
        useSafeArea: true,
        builder: (BuildContext context) => CupertinoAlertDialog(
              insetAnimationDuration: Duration(seconds: 2),
              title: Center(
                child: Text("Reset the timer"),
              ),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Bench Test Buddy would like to access your camera to capture and save exercise model photos"),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text(
                    "Don't allow",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                CupertinoDialogAction(
                  child: Text(
                    "Ok",
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ));
  }

  void _setCountDirection(TimerProgressTextCountDirection countDirection) {
    setState(() {
      _progressTextCountDirection = countDirection;
    });
  }

  void _setProgressIndicatorDirection(
      TimerProgressIndicatorDirection progressIndicatorDirection) {
    setState(() {
      _progressIndicatorDirection = progressIndicatorDirection;
    });
  }

  void _setStyle(TimerStyle timerStyle) {
    setState(() {
      _timerStyle = timerStyle;
    });
  }

  void timerValueChangeListener(Duration timeElapsed) {}

  void handleTimerOnStart() {
    print("timer has just started");
  }

  void handleTimerOnEnd() {
    print("timer has ended");
  }
}
