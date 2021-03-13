import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/timer_section/circle_timer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_timer.dart';
import 'settings.dart';

class ExerciseTimerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserLevel>(context).userData;
    final userCurrentExercise = Provider.of<Exercises>(context)
        .findExerciseById(userData.userExerciseId);
    final mediaQuery = MediaQuery.of(context).size;
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
                fontWeight:FontWeight.w600,
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
                  fontWeight:FontWeight.w600,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ))
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: mediaQuery.height * 0.08,
              width: mediaQuery.width * 0.6,
              child: Padding(
                padding: EdgeInsets.only(top: 17),
                child: Text(
                  userCurrentExercise.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.2,
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey.withOpacity(0.5),
              indent: mediaQuery.width * 0.03,
              endIndent: mediaQuery.width * 0.03,
            ),
            SizedBox(
              height: mediaQuery.height * 0.1,
              width: mediaQuery.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "00",
                        style: TextStyle(color: Colors.black, fontSize: 40),
                      ),
                      TextSpan(
                          text: " hours  ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                      TextSpan(
                          text: ":  ",
                          style: TextStyle(color: Colors.black, fontSize: 25)),
                      TextSpan(
                          text: "45",
                          style: TextStyle(color: Colors.black, fontSize: 40)),
                      TextSpan(
                          text: " mins  ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                      TextSpan(
                          text: ":  ",
                          style: TextStyle(color: Colors.black, fontSize: 25)),
                      TextSpan(
                          text: "00",
                          style: TextStyle(color: Colors.black, fontSize: 40)),
                      TextSpan(
                          text: " sec",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                    ]),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.5,
              color: Colors.grey.withOpacity(0.5),
              indent: mediaQuery.width * 0.03,
              endIndent: mediaQuery.width * 0.03,
            ),
            SizedBox(
              height: mediaQuery.height * 0.37,
              width: mediaQuery.width * 0.78,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditTimer())),
                    child: CircleAvatar(
                      radius: mediaQuery.height * 0.055,
                      backgroundColor: Theme.of(context).primaryColor,
                      child:
                          Text("Edit", style: TextStyle(color: Color(0xffffffff))),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CircleTimerScreen(
                                exerciseName: userCurrentExercise.name,
                                timeSelected: DateTime(2021, 1, 1, 0, 45, 0),
                              )));
                    },
                    child: CircleAvatar(
                        radius: mediaQuery.height * 0.055,
                        backgroundColor: Color(0xff4caf50),
                        child: Text("Start",
                            style: TextStyle(color: Color(0xffffffff)))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// showAlertDialog(BuildContext context) {
//   // set up the buttons
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
//   // set up the AlertDialog
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
