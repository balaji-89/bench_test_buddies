import 'dart:ui';

import 'package:bench_test_buddies/provider/country_provider.dart';
import 'package:bench_test_buddies/screens/app_ui/home.dart';
import 'package:bench_test_buddies/screens/onboarding_screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int setupIndex = 4;
  List<Map<String,dynamic>> question1list =[...CountryProvider().getOnlyAnswers(1)];

  List<Map<String,dynamic>> question2list = [...CountryProvider().getOnlyAnswers(2)];
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
          height: constraints.maxHeight * 0.13,
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
                fontSize: 18,
                color: const Color(0xff232323),
                fontWeight: FontWeight.w500,
                height: 1.3333333333333333,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Consumer<CountryProvider>(builder: (context, countryInstance, child) {
          return Container(
            height: constraints.maxHeight * 0.08,
            width: constraints.maxWidth * 0.9,
            margin: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Colors.grey,
              )),
            ),
            child: Row(

              children: [
                SizedBox(
                  width: constraints.maxWidth*0.06,
                ),
                if (countryInstance.selectedCountry.isNotEmpty)
                  Text(countryInstance.selectedCountry["name"],style:TextStyle(
                    fontWeight:FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15


                  )),
                Spacer(),
                if (countryInstance.selectedCountry.isNotEmpty)
                  SizedBox(
                    height: constraints.maxHeight * 0.03,
                    width: 20,
                    child: Image.asset(
                        "assets/on_boarding_images/2.0x/completionSuccess.png"),
                  )
              ],
            ),
          );
        }),
        Consumer<CountryProvider>(builder: (context, countryInstance, child) {
          return new Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  textColor:
                      countryInstance.selectedCountry.isNotEmpty ? Colors.white : Colors.black,
                  color: countryInstance.selectedCountry.isNotEmpty
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor,
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    if (countryInstance.selectedCountry.isNotEmpty)

                    setState(() {
                      setupIndex = 1;
                    });
                  },
                )),
          );
        }),
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
                      Provider.of<CountryProvider>(context,listen: false).getOnlyQuestion(1),
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
                  margin: EdgeInsets.only(
                    bottom: 13,
                  ),
                  child: new ListView.separated(
                    itemCount: question1list.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Consumer<CountryProvider>(
                          builder: (context, instance, child) {
                        return new ListTile(
                          leading: InkWell(
                            onTap: () {
                              instance.questionSetup2Changer(index);
                            },
                            child: Container(
                              height: constraints.maxHeight * 0.04,
                              width: constraints.maxWidth * 0.065,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                color: Colors.white,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.3,
                                    style: BorderStyle.solid),
                              ),
                              child: instance.setUp2Check == index
                                  ? Container(
                                      height: constraints.maxHeight * 0.018,
                                      width: constraints.maxWidth * 0.03,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : null,
                            ),
                          ),
                          trailing: instance.sentToBackend == index
                              ? SizedBox(
                                  height: constraints.maxHeight * 0.03,
                                  width: 20,
                                  child: Image.asset(
                                      "assets/on_boarding_images/2.0x/completionSuccess.png"),
                                )
                              : null,
                          title: Text(question1list[index]["answer"],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'SF Pro Text',
                                fontSize: 14,
                                color: const Color(0xff232323),
                                fontWeight: FontWeight.normal,
                                height: 1.3333333333333333,
                              )),
                        );
                      });
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.7,
                      ),
                    ),
                  )),
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
                      color: index == 0 || index == 1
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
              Provider.of<CountryProvider>(context,listen: false).getOnlyQuestion(2),
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
        Consumer<CountryProvider>(builder: (context, instance, child) {
          return Container(
              height: constraints.maxHeight * 0.3,
              child: new ListView.separated(
                itemCount: question2list.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: constraints.maxHeight * 0.07,
                    child: ListTile(
                      leading: InkWell(
                        onTap: () {
                          instance.questionSetup3Changer(index);
                        },
                        child: Container(
                          height: constraints.maxHeight * 0.04,
                          width: constraints.maxWidth * 0.065,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: Colors.white,
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1.3,
                                style: BorderStyle.solid),
                          ),
                          child: instance.setUp3Check == index
                              ? Container(
                                  height: constraints.maxHeight * 0.018,
                                  width: constraints.maxWidth * 0.03,
                                  color: Theme.of(context).primaryColor,
                                )
                              : null,
                        ),
                      ),
                      trailing: instance.sentToBackend2 == index
                          ? SizedBox(
                              height: constraints.maxHeight * 0.03,
                              width: 20,
                              child: Image.asset(
                                  "assets/on_boarding_images/2.0x/completionSuccess.png"),
                            )
                          : null,
                      title: Text(question2list[index]["answer"],
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 14,
                            color: const Color(0xff232323),
                            fontWeight: FontWeight.normal,
                            height: 1.3333333333333333,
                          )),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.7,
                  ),
                ),
              ));
        }),
        Container(
            height: constraints.maxHeight * 0.08,
            margin: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.05,
            ),
            child: RaisedButton(
              textColor: Colors.white,
              color: Color(0xFF4667EE),
              child: Text('Next',
                  style: TextStyle(
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
                            color: index == 0 || index == 1 || index == 2
                                ? Colors.green
                                : Theme.of(context).accentColor,
                          ),
                        )),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.16,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage(
                        "assets/on_boarding_images/3.0x/completionSuccess.png"),
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
                  height: constraints.maxHeight * 0.07,
                  margin: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.04),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Color(0xFF4667EE),
                    child: Text(
                      'Continue to Home Screen',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
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
            'Setup',
            style: TextStyle(fontSize: 20, color: Color(0xFF1a1a4b)),
          ),
          backgroundColor: Colors.white,
          actions: [
            if (setupIndex == 4)
              Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  child: Text('Search',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                      )),
                  onPressed: () {
                    showSearch(context: context, delegate: SearchScreen());
                  },
                ),
              )
          ]),
      body: Stack(children: <Widget>[
        Container(
          color: Colors.white.withOpacity(0.7),
          child: _getChildren(setupIndex, mediaQuery),
        )
      ]),
    );
  }
}
