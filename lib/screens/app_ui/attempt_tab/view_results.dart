import 'dart:ui';

import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:bench_test_buddies/provider/view_result_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewResults extends StatefulWidget {
  final int attemptId;

  ViewResults({@required this.attemptId});

  @override
  _ViewResultsState createState() => _ViewResultsState();
}

class _ViewResultsState extends State<ViewResults> {
  List<int> total;
  bool checkedValue = false;
  List<int> incorrect;
  List<int> correct;
  List<int> isTrueForAllType;
  final Map<String, bool> checkBoxItems = {
    'All': true,
    'Correct': false,
    'Incorrect': false,
  };
  List<String> checkBoxKeys;
  int checkedIndex = 0;
  int questionClicked = 0;
  int selectedAttemptId;
  int selectedQuestionItemToView;
  bool isEvaluationClicked = false;

  @override
  void initState() {
    total =
        Provider.of<ViewResultProvider>(context, listen: false).allAttemptId;
    correct = Provider.of<ViewResultProvider>(context, listen: false)
        .correctAttemptId;
    incorrect = Provider.of<ViewResultProvider>(context, listen: false)
        .inCorrectAttemptId;
    isTrueForAllType = Provider.of<ViewResultProvider>(context, listen: false)
        .isTrueForAllType;

    checkBoxKeys = checkBoxItems.keys.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

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

    Future onTapContainer() async {
      if (isEvaluationClicked == true) {
        String token = Provider.of<UserLogData>(context, listen: false).token;
        int exerciseId =
            Provider.of<Exercises>(context, listen: false).selectedExercise.id;
        await Provider.of<ViewResultProvider>(context, listen: false)
            .getSolutionsForAQuestion(exerciseId, token);
      }
    }

    Widget divider(mediaQuery) {
      return Container(
        height: mediaQuery.height * 0.01,
        width: mediaQuery.width,
        color: Theme.of(context).accentColor,
      );
    }

    Widget getCheckBox(index) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.015,
        width: MediaQuery.of(context).size.width * 0.3,
        child: Row(
          children: [
            Checkbox(
                checkColor: Color(0xfffffffff),
                activeColor: Theme.of(context).primaryColor,
                value: checkBoxItems[checkBoxKeys[index]],
                onChanged: (bool changed) {
                  isEvaluationClicked = false;
                  selectedAttemptId = null;
                  if (checkedIndex != index) {
                    checkedIndex = index;
                    changeCheckBoxState(checkBoxKeys[index], changed);
                  }
                }),
            Expanded(
              child: Text(
                checkBoxKeys[index],
                style: TextStyle(
                  color: Color(0xff232323),
                  fontSize: 14,
                ),
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
              color: Color(0xff232323),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('View Results',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff232323),
                fontSize: 17,
              )),
          elevation: 1,
          centerTitle: true,
          titleSpacing: 0.3,
        ),
        body: Column(
          children: [
            SizedBox(
              height: mediaQuery.height * 0.08,
              width: mediaQuery.width,
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
            divider(mediaQuery),
            Container(
              height: isEvaluationClicked == true
                  ? mediaQuery.height * 0.1
                  : mediaQuery.height * 0.68,
              width: mediaQuery.width,
              child: isEvaluationClicked == true
                  ? ListView.builder(
                      itemCount: checkedIndex == 0
                          ? total.length
                          : checkedIndex == 1
                              ? correct.length
                              : incorrect.length,
                      scrollDirection: Axis.horizontal,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 12.5),
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap: () async {
                            setState(() {
                              selectedAttemptId = checkedIndex == 0
                                  ? total[i]
                                  : checkedIndex == 1
                                      ? correct[i]
                                      : incorrect[i];
                              isEvaluationClicked = true;
                              selectedQuestionItemToView = selectedAttemptId;
                            });
                            await onTapContainer();
                          },
                          child: Container(
                            height: mediaQuery.height * 0.007,
                            width: mediaQuery.width * 0.1,
                            margin:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: selectedQuestionItemToView ==
                                      (checkedIndex == 0
                                          ? total[i]
                                          : checkedIndex == 1
                                              ? correct[i]
                                              : incorrect[i])
                                  ? (checkedIndex == 0
                                      ? (isTrueForAllType[i] == 1
                                          ? Color(0xff4caf50)
                                          : Color(0xffE55c4f))
                                      : checkedIndex == 1
                                          ? Color(0xff4caf50)
                                          : Color(0xffE55c4f))
                                  : Colors.transparent,
                              border: checkedIndex == 0
                                  ? Border.all(
                                      color: isTrueForAllType[i] == 1
                                          ? Color(0xff4caf50)
                                          : Color(0xffE55c4f),
                                      width: 1.5)
                                  : checkedIndex == 1
                                      ? Border.all(
                                          color: Color(0xff4caf50), width: 1)
                                      : Border.all(
                                          color: Color(0xffE55c4f), width: 1),
                            ),
                            child: Center(
                                child: Text(
                              checkedIndex == 0
                                  ? total[i].toString()
                                  : checkedIndex == 1
                                      ? correct[i].toString()
                                      : incorrect[i].toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: selectedQuestionItemToView ==
                                          (checkedIndex == 0
                                              ? total[i]
                                              : checkedIndex == 1
                                                  ? correct[i]
                                                  : incorrect[i])
                                      ? Color(0xffffffff)
                                      : Color(0xff232323)),
                            )),
                          ),
                        );
                      })
                  : GridView.builder(
                      itemCount: checkedIndex == 0
                          ? total.length
                          : checkedIndex == 1
                              ? correct.length
                              : incorrect.length,
                      padding: const EdgeInsets.all(17),
                      scrollDirection: isEvaluationClicked == true
                          ? Axis.horizontal
                          : Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 40),
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap: () async {
                            setState(() {
                              selectedAttemptId = checkedIndex == 0
                                  ? total[i]
                                  : checkedIndex == 1
                                      ? correct[i]
                                      : incorrect[i];
                              isEvaluationClicked = true;
                              selectedQuestionItemToView = selectedAttemptId;
                            });
                            await onTapContainer();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: checkedIndex == 0
                                  ? Border.all(
                                      color: isTrueForAllType[i] == 1
                                          ? Color(0xff4caf50)
                                          : Color(0xffE55c4f),
                                      width: 1.5)
                                  : checkedIndex == 1
                                      ? Border.all(
                                          color: Color(0xff4caf50), width: 1)
                                      : Border.all(
                                          color: Color(0xffE55c4f), width: 1),
                            ),
                            child: Center(
                                child: Text(
                              checkedIndex == 0
                                  ? total[i].toString()
                                  : checkedIndex == 1
                                      ? correct[i].toString()
                                      : incorrect[i].toString(),
                              style: TextStyle(
                                  color: Color(0xff232323),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )),
                          ),
                        );
                      },
                    ),
            ),
            if (isEvaluationClicked == true)
              Container(
                height: mediaQuery.height * 0.6,
                width: mediaQuery.width,
                child: FutureBuilder(
                    future: onTapContainer(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        );
                      }
                      return ListView(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.9,
                          width: MediaQuery.of(context).size.width,
                          child: LayoutBuilder(
                            builder: (context, constraints) => Column(
                              children: [
                                Container(
                                  height: constraints.maxHeight * 0.055,
                                  width: constraints.maxWidth,
                                  color: Theme.of(context).primaryColor,
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Question No:${selectedAttemptId.toString()}',
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15)),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.15,
                                  width: constraints.maxWidth,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Provider.of<ViewResultProvider>(
                                                  context,
                                                  listen: false)
                                              .individualQuestion
                                              .question,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        Text(
                                          'Your response: Yes',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15,
                                              color: Color(0xffE55c4f)),
                                        ),
                                        Text(
                                          'Correct answer: No',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15,
                                              color: Color(0xff4caf50)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                divider(mediaQuery),
                                SizedBox(
                                  height: constraints.maxHeight * 0.11,
                                  child: ListTile(
                                    leading: Container(
                                      height: constraints.maxHeight * 0.09,
                                      width: constraints.maxWidth * 0.13,
                                      margin: EdgeInsets.only(top: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(7),
                                          )),
                                    ),
                                    title: Text(
                                      Provider.of<ViewResultProvider>(context,
                                                      listen: false)
                                                  .individualQuestion
                                                  .video ==
                                              ""
                                          ? 'Click to view the full image'
                                          : 'Click to view the video',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      padding: EdgeInsets.all(0),
                                      alignment: Alignment.centerRight,
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: Color(0xff232323),
                                        size: 20,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                divider(mediaQuery),
                              ],
                            ),
                          ),
                        )
                      ]);
                    }),
              ),
          ],
        ));
  }
}
