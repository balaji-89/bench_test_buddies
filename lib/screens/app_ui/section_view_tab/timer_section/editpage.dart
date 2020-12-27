import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bar.dart';
import 'dialog.dart';

class Edit extends StatelessWidget {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: heights.height * 0.03,
          ),
          Text(
            Bar().texts,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: heights.height * 0.3,
          ),
          Divider(
            thickness: 2,
            height: 3,
          ),
          SizedBox(
            height: heights.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "00",
                    style: TextStyle(color: Colors.black, fontSize: 50),
                  ),
                  TextSpan(
                      text: "hours  ",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  TextSpan(
                      text: ":  ",
                      style: TextStyle(color: Colors.black, fontSize: 30)),
                  TextSpan(
                      text: "45",
                      style: TextStyle(color: Colors.black, fontSize: 50)),
                  TextSpan(
                      text: "minutes  ",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  TextSpan(
                      text: ":  ",
                      style: TextStyle(color: Colors.black, fontSize: 30)),
                  TextSpan(
                      text: "00",
                      style: TextStyle(color: Colors.black, fontSize: 50)),
                  TextSpan(
                      text: "seconds",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                ]),
              ),
            ],
          ),
          SizedBox(
            height: heights.height * 0.02,
          ),
          Divider(
            thickness: 2,
            height: 3,
          ),
          SizedBox(
            height: heights.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () => showAlertDialog(context),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Dialogs())),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blueAccent,
                          child: Text("Edit",
                              style: TextStyle(color: Colors.white)),
                        ),
                      );
                    },
                  )),
              SizedBox(
                width: heights.width * 0.3,
              ),
              GestureDetector(
                  onTap: () {},
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
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
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
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

  // set up the AlertDialog
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
