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
  String texts = "   Class 1 Amalgam Cavity";
  Color purp =  Color(0xff4667EE) ;
  Color oran= Color(0xffE55C4F);
  Color yello = Color(0xffF79703);

  static BuildContext get context => null;

  //get => appbars = _appBar;
}

