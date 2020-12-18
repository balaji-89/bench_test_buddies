import 'dart:ui';

import 'package:flutter/material.dart';

class ViewResults extends StatefulWidget {
  final int attemptId;

  ViewResults({@required this.attemptId});

  @override
  _ViewResultsState createState() => _ViewResultsState();
}

class _ViewResultsState extends State<ViewResults> {
  @override
  Widget build(BuildContext context) {
    final List numbers = [
      2,
      8,
      11,
      12,
      14,
      16,
    ];
    final Map<String, bool> checkBoxItems = {
      'All': false,
      'Correct': false,
      'Incorrect': false
    };
    final checkBoxKeys = checkBoxItems.keys.toList();

    void changeCheckBoxState(String char, bool changedValue) {
      checkBoxItems.forEach((key, value) {
        setState(() {
          if (key == char) {
            checkBoxItems.update(key, (value) => changedValue);
          } else {
            checkBoxItems.update(key, (value) => !changedValue);
          }
        });
      });
    }

    Widget divider(constraints) {
      return Container(
        height: constraints.maxHeight * 0.01,
        width: constraints.maxWidth,
        color: Theme.of(context).accentColor,
      );
    }

    Widget getCheckBox(index) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.015,
        width: MediaQuery.of(context).size.width * 0.27,
        child: Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: checkBoxItems[checkBoxKeys[index]],
                onChanged: (bool changed) {
                  changeCheckBoxState(checkBoxKeys[index], changed);
                }),
            Text(
              checkBoxKeys[index],
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('View Results',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                  letterSpacing: 0.7)),
          elevation: 1,
          centerTitle: true,
          titleSpacing: 0.3,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                  width: constraints.maxWidth,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(0),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: checkBoxItems.length,
                    itemBuilder: (context, index) {
                      return getCheckBox(index);
                    },
                  ),
                ),
                divider(constraints),
                SizedBox(
                  height: constraints.maxHeight * 0.13,
                  width: constraints.maxWidth,
                  child: ListView.builder(
                      padding: EdgeInsets.only(left: 10),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: numbers.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Center(
                              child: Container(
                            height: constraints.maxHeight * 0.05,
                            width: constraints.maxWidth * 0.09,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 1.3),
                              color: Colors.white,
                            ),
                            child: Text(
                              numbers[index].toString(),
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ))),
                ),
                divider(constraints),
                SizedBox(
                  height: constraints.maxHeight * 0.17,
                  width: constraints.maxWidth,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 8, bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question?',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          'wrong Answer',
                          style: TextStyle(fontSize: 15, color: Colors.red),
                        ),
                        Text(
                          'Correct answer',
                          style: TextStyle(fontSize: 15, color: Colors.green),
                        )
                      ],
                    ),
                  ),
                ),
                divider(constraints),
                SizedBox(
                  height: constraints.maxHeight * 0.13,
                  child: ListTile(
                    leading: Container(
                      height: constraints.maxHeight * 0.07,
                      width: constraints.maxWidth * 0.13,
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          )),
                    ),
                    title: Text(
                      'Click to view the full image',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 13,
                      ),
                    ),
                    trailing: IconButton(
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.centerRight,
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 18,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                divider(constraints),
              ],
            ),
          ),
        ));
  }
}
