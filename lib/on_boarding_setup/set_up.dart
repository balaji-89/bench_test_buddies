import 'dart:ui';

import 'package:bench_test_buddies/screens/app_ui/home.dart';
import 'package:flutter/material.dart';
//import 'package:step_progress_indicator/step_progress_indicator.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int setupIndex = 4;
  List<String> question1list = [
    "Yes,I have taken bench test course",
    "No,I haven't taken bench test couse"
  ];
  List<String> question2list = [
    "I've been preparing for bench preparation",
    "I'm familiar with basics but yet to prepare",
    "I am new to bench prep[aration"
  ];

  _getChildren(int pos, mediaQuery) {
    switch (pos) {
      case 1:
        return _buildsetupQuestion1(mediaQuery);
      case 2:
        return _buildsetupQuestion2(mediaQuery);
      case 3:
        return _buildsetupsuccess(mediaQuery);
      case 4:
        return _buildLocation(mediaQuery);
      default:
        return _buildLocation(mediaQuery);
    }
  }

  Widget _buildLocation(Size mediaQuery) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(children: <Widget>[
        Container(
          height: constraints.maxHeight * 0.008,
          width: constraints.maxWidth * 0.9,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 18, bottom: 30),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) => Container(
                    height: mediaQuery.height * 0.03,
                    width: mediaQuery.width * 0.3,
                    margin: EdgeInsets.only(right: 5, left: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).accentColor,
                    ),
                  )),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.1,
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage:
                  AssetImage("assets/on_boarding_images/setup1.png"),
            ),
            title: Text(
              'Enter your Origin Country',
              style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontSize: 19,
                color: const Color(0xff232323),
                fontWeight: FontWeight.w500,
                height: 1.3333333333333333,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          height: constraints.maxHeight * 0.12,
          width: constraints.maxWidth * 0.9,
          margin: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: TextField(),
        ),
        new Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF4667EE),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  setState(() {
                    setupIndex = 1;
                  });
                },
              )),
        ),
      ]),
    );
  }

  Widget _buildsetupQuestion1(Size mediaQuery) {
    return LayoutBuilder(
        builder: (context, constraints) => ListView(children: <Widget>[
              Container(
                height: constraints.maxHeight * 0.008,
                width: constraints.maxWidth * 0.9,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: 18, bottom: constraints.maxHeight * 0.07),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) => Container(
                          height: mediaQuery.height * 0.03,
                          width: mediaQuery.width * 0.3,
                          margin: EdgeInsets.only(right: 5, left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: index == 0
                                ? Colors.green
                                : Theme.of(context).accentColor,
                          ),
                        )),
              ),
              Container(
                margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.05),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundImage:
                        AssetImage("assets/on_boarding_images/setup2.png"),
                  ),
                  title: SizedBox(
                    width: constraints.maxWidth * 0.65,
                    child: Text(
                      'Have you attended a professional bench test course?',
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 17,
                        color: const Color(0xff232323),
                        fontWeight: FontWeight.w500,
                        height: 1.3333333333333333,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
              Container(
                  height: constraints.maxHeight * 0.21,
                  child: new ListView.builder(
                      itemCount: question1list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new ListTile(
                          trailing: SizedBox(
                            height: constraints.maxHeight*0.03,
                            width: 20,
                            child: Image.asset(
                                "assets/on_boarding_images/2.0x/completionSuccess.png"),
                          ),
                          title: Text(question1list[index],
                              style: TextStyle(
                                fontFamily: 'SF Pro Text',
                                fontSize: 14,
                                color: const Color(0xff232323),
                                fontWeight: FontWeight.normal,
                                height: 1.3333333333333333,
                              )),
                        );
                      })),
              Container(
                  height: constraints.maxHeight * 0.08,
                  margin: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.07,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Color(0xFF4667EE),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        setupIndex = 2;
                      });
                    },
                  )),
            ]));
  }

  Widget _buildsetupQuestion2(Size mediaQuery) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(children: <Widget>[
        Container(
          height: constraints.maxHeight * 0.008,
          width: constraints.maxWidth * 0.9,
          alignment: Alignment.center,
          margin:
              EdgeInsets.only(top: 18, bottom: constraints.maxHeight * 0.07),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) => Container(
                    height: mediaQuery.height * 0.03,
                    width: mediaQuery.width * 0.3,
                    margin: EdgeInsets.only(right: 5, left: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: index == 0 || index==1
                          ? Colors.green
                          : Theme.of(context).accentColor,
                    ),
                  )),
        ),
        Container(
          margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.05),
          child: ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundImage:
                  AssetImage("assets/on_boarding_images/setup3.png"),
            ),
            title: Text(
              'Enter your experience level in bench preparation',
              style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontSize: 17,
                color: const Color(0xff232323),
                fontWeight: FontWeight.w500,
                height: 1.3333333333333333,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
            height: constraints.maxHeight*0.26,
            child: new ListView.builder(
                itemCount: question2list.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return  Container(
                    height: constraints.maxHeight*0.07,
                    child: ListTile(
                      trailing: SizedBox(
                        height: constraints.maxHeight*0.03,
                        width: 20,
                        child: Image.asset(
                            "assets/on_boarding_images/2.0x/completionSuccess.png"),
                      ),
                      title: Text(question2list[index],
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 14,
                            color: const Color(0xff232323),
                            fontWeight: FontWeight.normal,
                            height: 1.3333333333333333,
                          )),
                    ),
                  );
                })),
        Container(
            height: constraints.maxHeight*0.08,
            margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.05, ),
            child: RaisedButton(
              textColor: Colors.white,
              color: Color(0xFF4667EE),
              child: Text('Next',style:TextStyle(
                fontSize: 17,
              )),
              onPressed: () {
                setState(() {
                  setupIndex = 3;
                });
              },
            )),
      ]),
    );
  }

  Widget _buildsetupsuccess(Size mediaQuery) {
    return LayoutBuilder(
        builder: (context, constraints) => ListView(children: <Widget>[
      Container(
        height: constraints.maxHeight * 0.008,
        width: constraints.maxWidth * 0.9,
        alignment: Alignment.center,
        margin:
        EdgeInsets.only(top: 18, bottom: constraints.maxHeight * 0.07),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) => Container(
              height: mediaQuery.height * 0.03,
              width: mediaQuery.width * 0.3,
              margin: EdgeInsets.only(right: 5, left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: index == 0 || index==1 ||index==2
                    ? Colors.green
                    : Theme.of(context).accentColor,
              ),
            )),
      ),
      SizedBox(
        height: constraints.maxHeight*0.16,
        child: ListTile(
          leading:  CircleAvatar(
          radius: 26,
          backgroundImage:AssetImage("assets/on_boarding_images/3.0x/completionSuccess.png"),
          ),
          title: Text(
            'Hey! You are done with the intial setup.Start practicing.Best wishes.',
            style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontSize: 17,
              color: const Color(0xff232323),
              fontWeight: FontWeight.w500,
              height: 1.3333333333333333,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      Container(
          height: constraints.maxHeight*0.07,
          margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.04),
          child: RaisedButton(
            textColor: Colors.white,
            color: Color(0xFF4667EE),
            child: Text('Continue to Home Screen',style: TextStyle(fontSize: 14),),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
            },
          )),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF1a1a4b),
        ),
        centerTitle: true,
        elevation: 1,
        title: Text(
          'Set Up',
          style: TextStyle(color: Color(0xFF1a1a4b)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(children: <Widget>[
        Container(
          color: Colors.white.withOpacity(0.7),
          child: _getChildren(setupIndex, mediaQuery),
        )
      ]),
    );
  }
}
