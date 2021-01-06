import 'package:flutter/material.dart';


class Bar {
  AppBar appBars= AppBar(
    backgroundColor: Colors.white,
    leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
      Navigator.pop(context);
    },
    ),
    centerTitle: true,
    title: Text("Exercise Timer",style:TextStyle(color: Colors.black,
      fontSize: 20,
    )),
    actions: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text("Settings",style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 20,
        ),
        ),
      ),
    ],
  );


  AppBar appbars= AppBar(
    backgroundColor: Colors.white,
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back,color: Colors.black,),
    ),
    centerTitle: true,
    title: Text("Evaluation ",style: TextStyle(
      color: Colors.black,
    ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text("Submit",style: TextStyle(
          color: Colors.grey,
          fontSize: 20,
        ),
        ),
      ),
    ],
  );
  String out = "Does your outline form follow this example?";
  String adj ="Adjacent tooth damage Soft tissue damage \nBurn marks on the tooth?";


  String texts = "   Class 1 Amalgam Cavity";
  Color gree= Color(0xff4CAF50);
  Color purp =  Color(0xff4667EE);
  Color back = Color(0xffF1F1F1);
  Color oran= Color(0xffE55C4F);
  Color yello = Color(0xffF79703);
  Color greys= Color(0xffEFEFEF);
  List<String> settings  = ["Do Not Disturb","Stop Alarm Tone","Vibration","Active Timer Screen",];

  static BuildContext get context => null;

  AppBar result= AppBar(
    title: Text("View Result"),
    centerTitle: true,
    leading: IconButton(
      onPressed: (){},
      icon: Icon(Icons.backspace,color: Colors.black,),
    ),
  );


  //get => appbars = _appBar;
}

