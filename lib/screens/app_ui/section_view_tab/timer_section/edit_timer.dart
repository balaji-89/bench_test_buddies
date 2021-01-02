import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'circle_timer_screen.dart';
import 'settings.dart';

class EditTimer extends StatefulWidget {
  final String exerciseName;


  EditTimer({@required this.exerciseName});

  @override
  _EditTimerState createState() => _EditTimerState();
}

class _EditTimerState extends State<EditTimer> {

  DateTime changedTime = DateTime.utc(2021, 1, 1, 0, 0, 0);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;



    Widget richText(String indicator) {
      return RichText(
          text: TextSpan(
        children: [
          TextSpan(
              text: " $indicator  ",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
          if (indicator != 'sec  ')
            TextSpan(
                text: ": ",
                style: TextStyle(color: Colors.black, fontSize: 25)),
        ],
      ));
    }


    return SafeArea(
      child: Scaffold(
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
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
          height: mediaQuery.height,
          width: mediaQuery.width,
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return ListView(
              children: [
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
                  height: constraints.maxHeight * 0.12,
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.9,
                  height: constraints.maxHeight * 0.32,
                  child: Stack(
                    children: [
                      TimePickerSpinner(
                        itemHeight: constraints.maxHeight * 0.12,
                        itemWidth: constraints.maxWidth * 0.12,
                        highlightedTextStyle:
                            TextStyle(color: Colors.black87, fontSize: 35),
                        normalTextStyle:
                            TextStyle(color: Colors.grey, fontSize: 30),
                        is24HourMode: true,
                        spacing: constraints.maxWidth * 0.19,
                        isForce2Digits: true,
                        minutesInterval: 1,
                        isShowSeconds: true,
                        secondsInterval: 1,
                        time:changedTime,
                        onTimeChange: (resetValue) {
                          setState(() {
                            changedTime = resetValue;
                          });
                        },
                      ),
                      Positioned(
                        left: 42,
                        top: 50,
                        child: SizedBox(
                          height: constraints.maxHeight * 0.2,
                          width: constraints.maxWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              richText(" hours  "),
                              richText("mins  "),
                              richText("sec  "),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: constraints.maxHeight * 0.1),
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey.withOpacity(0.8),
                          indent: mediaQuery.width * 0.03,
                          endIndent: mediaQuery.width * 0.03,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: constraints.maxHeight * 0.23),
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey.withOpacity(0.8),
                          indent: mediaQuery.width * 0.03,
                          endIndent: mediaQuery.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.4,
                  width: constraints.maxWidth * 0.78,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){

                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context)=>EditTimer(exerciseName: widget.exerciseName,)
                              ));
                          },

                        child: CircleAvatar(
                          radius: constraints.maxHeight * 0.057,
                          backgroundColor:Color.fromRGBO(189, 74, 74, 1),
                          child: Text("Reset",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => CircleTimerScreen(exerciseName: widget.exerciseName,timeSelected:changedTime ,)));
                        },
                        child: CircleAvatar(
                            radius: constraints.maxHeight * 0.057,
                            backgroundColor: Colors.green,
                            child: Text("Start",
                                style: TextStyle(color: Colors.white))),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

// showAlertDialog(BuildContext context) {
//   Widget cancelButton = FlatButton(
//     child: Text(
//       "Don't allow",
//       style: TextStyle(fontSize: 20),
//     ),
//     onPressed: () {},
//   );
//   Widget continueButton = FlatButton(
//     child: Text("ok"),
//     onPressed: () {},
//   );
//
//   AlertDialog alert = AlertDialog(
//     buttonPadding: const EdgeInsets.only(right: 60),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20),
//     ),
//     contentPadding: EdgeInsets.all(10),
//     title: Center(child: Text("Reset the timer")),
//     content: Text(
//         "Bench Test Buddy would like to access your camera to capture and save exercise model photos"),
//     actions: [
//       cancelButton,
//       continueButton,
//     ],
//   );
//
//   showDialog(
//       context: context,
//       useSafeArea: true,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//             insetAnimationDuration: Duration(seconds: 2),
//             title: Center(
//               child: Text("Reset the timer"),
//             ),
//             content: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                   "Bench Test Buddy would like to access your camera to capture and save exercise model photos"),
//             ),
//             actions: <Widget>[
//               CupertinoDialogAction(
//                 isDefaultAction: true,
//                 child: Text(
//                   "Don't allow",
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//               CupertinoDialogAction(
//                 child: Text(
//                   "Ok",
//                   style: TextStyle(fontSize: 15),
//                 ),
//               )
//             ],
//           ));
// }
