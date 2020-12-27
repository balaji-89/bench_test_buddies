import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'dialogscreen.dart';

class Dialogs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {},
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
        ),
        backgroundColor: Colors.white,
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: heights.height * 0.02,
            ),
            SizedBox(
              width: heights.width * 1,
            ),
            SizedBox(
                width: heights.width * 0.6,
                child: Text(
                  "   Class 1 Amalgam Cavity",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: heights.height * 0.1,
            ),
            Container(
              width: heights.width * 2,
              //height: heights.height*2,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 150),
                    child: Divider(
                      thickness: 2,
                      height: 3,
                    ),
                  ),
                  TimePickerSpinner(
                    is24HourMode: true,
                    spacing: 50,
                    itemHeight: 83,
                    isForce2Digits: true,
                    minutesInterval: 1,
                    isShowSeconds: true,
                    secondsInterval: 1,
                    //time: DateTime.june,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 80),
                    child: Divider(
                      thickness: 2,
                      height: 3,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: heights.height * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () => showAlertDialog(context),
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.deepOrangeAccent,
                          child: Text("Reset",
                              style: TextStyle(color: Colors.white)),
                        );
                      },
                    )),
                SizedBox(
                  width: heights.width * 0.3,
                ),
                GestureDetector(onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyHomePage()));
                }, child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.green,
                        child: Text("Start",
                            style: TextStyle(color: Colors.white)));
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text(
      "Don't allow",
      style: TextStyle(fontSize: 20),
    ),
    onPressed: () {},
  );
  Widget continueButton = FlatButton(
    child: Text("ok"),
    onPressed: () {},
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
