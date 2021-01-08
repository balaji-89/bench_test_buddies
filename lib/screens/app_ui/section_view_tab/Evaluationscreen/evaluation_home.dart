import 'package:bench_test_buddies/screens/app_ui/section_view_tab/Evaluationscreen/valuescreen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/painting.dart';

class EvaluationHome extends StatefulWidget {
  final String question;

  EvaluationHome({this.question});

  @override
  _EvaluationHomeState createState() => _EvaluationHomeState();
}

class _EvaluationHomeState extends State<EvaluationHome> {
  Color cool = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size;
    final carouselImage = [
      Container(
        color: Colors.green,
      ),
      Container(color: Colors.blue),
      Container(color: Colors.black)
    ];
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
        title: Text('Evaluation',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
                letterSpacing: 0.2)),
        elevation: 1,
        centerTitle: true,
        titleSpacing: 0.3,
        actions: [
          FlatButton(
              onPressed: () {},
              child: Text(
                'Submit',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                ),
              ))
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.1,
              width: constraints.maxWidth,
              child: Center(
                child: Text('Criteria: Outline from shape',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    )),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.46,
              width: constraints.maxWidth,
              child: Carousel(
                images: carouselImage,
                dotColor: Theme.of(context).accentColor,
                dotBgColor: Theme.of(context).backgroundColor,
                dotIncreasedColor: Theme.of(context).primaryColor,
                dotVerticalPadding: 0,
                dotPosition: DotPosition.bottomCenter,
                animationDuration: Duration(seconds: 1),
                animationCurve: Curves.bounceOut,
                showIndicator: true,
                autoplay: false,
                dotIncreaseSize: 1.1,
                dotSpacing: 20,
                dotHorizontalPadding: 15,
              ),
            ),
            Container(
              width: constraints.maxWidth * 1,
              height: constraints.maxHeight * 0.05,
              color: Colors.grey.withOpacity(0.3),
              margin: EdgeInsets.only(bottom: 20),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Q.1 /",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "09",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.question == null
                    ? 'Does your outline form follow this example ?'
                    : widget.question,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: constraints.maxHeight * 0.055,
                  width: constraints.maxWidth * 0.45,
                  child: OutlineButton(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => widget.question != null
                              ? ValueScreen()
                              : EvaluationHome(
                                  question:
                                      'Adjacent tooth damage soft tissue damage burn marks on the tooth?')));
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.055,
                  width: constraints.maxWidth * 0.45,
                  child: OutlineButton(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),
                    onPressed: () {},
                    child: Text(
                      "No",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: constraints.maxHeight * 0.095,
                bottom: constraints.maxHeight * 0.03,
              ),
              child: Divider(
                thickness: 2,
                color: Colors.grey[300],
                height: 1,
              ),
            ),
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.05,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: constraints.maxWidth * 0.088,
                      height: constraints.maxHeight * 0.04,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: questions[index]['bool'] == false ||
                                  questions[index]['bool'] == 'in_progress'
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(3),
                          border: questions[index]['bool'] == 'in_progress'
                              ? Border.all(
                                  color: Theme.of(context).primaryColor,
                                )
                              : null),
                      child: Text(
                        "${questions[index]['question']}",
                        style: TextStyle(
                            fontSize: 18,
                            color: questions[index]['bool'] == false ||
                                    questions[index]['bool'] == 'in_progress'
                                ? Colors.white
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> questions = [
    {
      'question': 1,
      'bool': false,
    },
    {
      'question': 2,
      'bool': false,
    },
    {
      'question': 3,
      'bool': true,
    },
    {
      'question': 4,
      'bool': false,
    },
    {
      'question': 5,
      'bool': 'in_progress',
    },
    {
      'question': 6,
      'bool': false,
    },
    {
      'question': 7,
      'bool': true,
    },
  ];
}
