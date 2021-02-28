import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:bench_test_buddies/provider/view_result_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ViewSolutions extends StatefulWidget {
  @override
  _ViewSolutionsState createState() => _ViewSolutionsState();
}

class _ViewSolutionsState extends State<ViewSolutions> {
  List<int> total;
  bool checkedValue = false;
  List<int> incorrect;
  List<int> correct;
  List<int> isTrueForAllType;
  final Map<String, bool> checkBoxItems = {
    'All': true,
    'Correct': false,
    'Incorrect': false,
    'Book': false,
  };
  List<String> checkBoxKeys;
  int checkedIndex = 0;
  int questionClicked = 0;
  bool isEvaluationClicked = false;
  int selectedAttemptId;
  int selectedQuestionItemToView;
  bool isBookMarked;

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

  Widget bookMarkButton(constraints) {
    isBookMarked = Provider.of<ViewResultProvider>(context, listen: false)
                .individualQuestion
                .bookmarkStatus ==
            0
        ? false
        : true;
    return InkWell(
      onTap: () {
        if (isBookMarked == true) {
          //TODO:un bookmark function
        } else {
          Provider.of<ViewResultProvider>(context, listen: false)
              .storeBookMarks(
                  Provider.of<Exercises>(context, listen: false)
                      .selectedExercise
                      .id,
                  Provider.of<UserLogData>(context, listen: false).token);
          setState(() {
            isBookMarked = true;
          });
        }
      },
      child: Container(
        height: constraints.maxHeight * 0.056,
        width: constraints.maxWidth * 0.4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isBookMarked == true
              ? Colors.grey.withOpacity(0.6)
              : Colors.orangeAccent,
          borderRadius: BorderRadiusDirectional.circular(3),
        ),
        child: Text(
          isBookMarked == true ? 'UnBookmark' : 'Bookmark',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isBookMarked == true ? Colors.black : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
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
      width: MediaQuery.of(context).size.width * 0.26,
      child: Row(
        children: [
          Checkbox(
              checkColor: Colors.white,
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
            child: checkBoxKeys[index] == 'Incorrect'
                ? Text(
                    checkBoxKeys[index],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  )
                : Text(
                    checkBoxKeys[index],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Column(
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
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12.5),
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
                        margin: EdgeInsets.only(right: 15, top: 5, bottom: 5),
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
                                      ? Colors.green
                                      : Colors.red)
                                  : checkedIndex == 1
                                      ? Colors.green
                                      : Colors.red)
                              : Colors.transparent,
                          border: checkedIndex == 0
                              ? Border.all(
                                  color: isTrueForAllType[i] == 1
                                      ? Colors.green
                                      : Colors.red,
                                  width: 1.5)
                              : checkedIndex == 1
                                  ? Border.all(color: Colors.green, width: 1)
                                  : Border.all(color: Colors.red, width: 1),
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
                                  ? Colors.white
                                  : Colors.black),
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
                                      ? Colors.green
                                      : Colors.red,
                                  width: 1.5)
                              : checkedIndex == 1
                                  ? Border.all(color: Colors.green, width: 1)
                                  : Border.all(color: Colors.red, width: 1),
                        ),
                        child: Center(
                            child: Text(
                          checkedIndex == 0
                              ? total[i].toString()
                              : checkedIndex == 1
                                  ? correct[i].toString()
                                  : incorrect[i].toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Provider.of<ViewResultProvider>(context,
                                              listen: false)
                                          .individualQuestion
                                          .question,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(
                                      'Your response: Yes',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.red),
                                    ),
                                    Text(
                                      'Correct answer: No',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.green),
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
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
                            divider(mediaQuery),
                            Container(
                                height: constraints.maxHeight * 0.19,
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Explanation :',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                        Provider.of<ViewResultProvider>(context,
                                                listen: false)
                                            .individualQuestion
                                            .explanation,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black,
                                        )),
                                  ],
                                )),
                            divider(mediaQuery),
                            Container(
                                height: constraints.maxHeight * 0.15,
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 7),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Common cause for the error :',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                        Provider.of<ViewResultProvider>(context,
                                                listen: false)
                                            .individualQuestion
                                            .commonErrorCause,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black,
                                        )),
                                  ],
                                )),
                            divider(mediaQuery),
                            Container(
                                height: constraints.maxHeight * 0.12,
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 7),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'How to prevent the error :',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                        Provider.of<ViewResultProvider>(context,
                                                listen: false)
                                            .individualQuestion
                                            .prevent,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black,
                                        )),
                                  ],
                                )),
                            Spacer(),
                            Padding(
                                padding: EdgeInsets.only(
                                    bottom: constraints.maxHeight * 0.05),
                                child:
                                    Center(child: bookMarkButton(constraints))),
                          ],
                        ),
                      ),
                    )
                  ]);
                }),
          ),
      ],
    );
  }
}
