import 'dart:ui';

import 'package:bench_test_buddies/model/attempt_official_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class ResultsScoreCard extends StatelessWidget {
  final ScoreCardModel userResults;



  ResultsScoreCard({this.userResults});

  @override
  Widget build(BuildContext context) {
    final userScore = userResults.actualScore;
    final bestScore = userResults.expectedScore;
    final totalScore=userResults.maxScore;

    final pieLabel = [userScore, bestScore];
    final List<List<CircularStackEntry>> pieData = [
      <CircularStackEntry>[
        CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(
                userScore.toDouble(), Color(0xff4caf50),
                rankKey: 'S1'),
            CircularSegmentEntry(
              (totalScore - userScore).toDouble(),
              Color(0xfff16c28),
              rankKey: 'S1',
            ),
          ],
        ),
      ],
      <CircularStackEntry>[
        CircularStackEntry(
          <CircularSegmentEntry>[
            CircularSegmentEntry(bestScore.toDouble(), Colors.blue,
                rankKey: 'S2'),
            CircularSegmentEntry(
              (totalScore- bestScore).toDouble(),
              Color(0xffE55c4f),
              rankKey: 'S2',
            ),
          ],
        ),
      ]
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(builder: (context, constraints) {
          final chartSize = Size(
            constraints.maxWidth * 0.5,
            constraints.maxHeight * 0.28,
          );
          return Column(
            children: [
              Padding(
                padding:EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: constraints.maxHeight * 0.31,
                  width: constraints.maxWidth * 0.83,
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: pieData.length,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      alignment: Alignment.center,
                      height: constraints.maxHeight * 0.4,
                      width: constraints.maxWidth * 0.43,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedCircularChart(
                              holeLabel: index == 0
                                  ? '$userScore/$totalScore'
                                  : '$bestScore/$totalScore',
                              holeRadius: 45.0,
                              size: chartSize,
                              initialChartData: pieData[index],
                              labelStyle: TextStyle(
                                color: Color(0xff232323),
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                              ),
                            ),
                            Text(index == 0 ? 'Your Score' : 'Ideal Score',
                                style: TextStyle(
                                  color: Color(0xff232323),
                                  fontSize: 13,
                                )),
                          ]),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: constraints.maxHeight * 0.06,
                  width: constraints.maxWidth * 0.85,
                  child: Divider(
                    thickness: 2,
                  )),
              SizedBox(
                height: constraints.maxHeight * 0.04,
                width: constraints.maxWidth * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.23,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 4,
                            backgroundColor: Color(0xff4caf50),
                          ),
                          Text('${userScore.toString()} Correct',style: TextStyle(color:Color(0xff232323),fontWeight: FontWeight.w500,fontSize: 13),)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.21,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 4,
                            backgroundColor: Color(0xffE55c4f),
                          ),
                          Text(
                              '${(totalScore - userScore).toString()} Wrong',style: TextStyle(color:Color(0xff232323),fontWeight: FontWeight.w500,fontSize: 13),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: constraints.maxHeight * 0.01,
                width: constraints.maxWidth,
                margin: EdgeInsets.symmetric(vertical: 15),
                color: Theme.of(context).accentColor,
              ),
              Text(
                'Buddy Words',
                style: TextStyle(
                    color: Color(0xff232323),
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    letterSpacing: 0.3,
                    wordSpacing: 2),
                textAlign: TextAlign.center,
              ),
              Center(
                child: SizedBox(
                  height: constraints.maxHeight * 0.26,
                  width: constraints.maxWidth * 0.5,
                  child: Image.asset('assets/attempt_images/Group 284.png'),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.2,
                width: constraints.maxWidth * 0.8,
                child: Text(
                  'Hey Balaji, dont worry about this.Apparently try this exercise again with a vit of extra revision and you will score high.!. we are confident about this',
                  style: TextStyle(
                      color: Color(0xff232323),
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.2,
                      wordSpacing: 1.4,
                      height: 1.5,
                      fontSize: 12),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
