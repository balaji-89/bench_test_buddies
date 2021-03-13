import 'package:bench_test_buddies/model/attempt_official_model.dart';
import 'package:bench_test_buddies/provider/attempt_official_provider.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:provider/provider.dart';

class ScoreCard extends StatelessWidget {
  final int attemptId;

  ScoreCard({@required this.attemptId});

  @override
  Widget build(BuildContext context) {
    final token=Provider.of<UserLogData>(context).token;
    int  userScore;
    int  bestScore;
    int  totalScore;
    String buddyWords;
    List<List<CircularStackEntry>> pieData;


    void initializeScores( data){
      final scoreCard=data;
       userScore = int.parse(scoreCard["actual_score"]);
       bestScore = int.parse(scoreCard["expected_score"]);
       //TODO:change the hard coded total score as ScoreCard["ma_score"]
       totalScore=int.parse('20');
       buddyWords=scoreCard["buddy_word"];
      pieData = [
        <CircularStackEntry>[
          CircularStackEntry(
            <CircularSegmentEntry>[
              CircularSegmentEntry(
                  userScore.toDouble(), Color(0xff4caf50),
                  rankKey: 'S1'),
              CircularSegmentEntry(
                (totalScore- userScore).toDouble(),
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
                (totalScore - bestScore).toDouble(),
                Color(0xffe55c4f),
                rankKey: 'S2',
              ),
            ],
          ),
        ]
      ];
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
        title: Text('Score Card',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff232323),
                fontSize: 18,
            )),
        elevation: 1,
        centerTitle: true,
        titleSpacing: 0.3,
      ),
      body: FutureBuilder(
        future: Provider.of<AttemptOfficial>(context).getScoreCard(attemptId,token),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),);
          if(snapshot.connectionState==ConnectionState.done)
              initializeScores(snapshot.data);
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: LayoutBuilder(builder: (context, constraints) {
              final chartSize = Size(
                constraints.maxWidth * 0.5,
                constraints.maxHeight * 0.28,
              );
              return Column(
                children: [
                  SizedBox(
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
                          width: constraints.maxWidth * 0.21,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 4,
                                backgroundColor: Color(0xff4caf50),
                              ),
                              Text('${userScore.toString()} Correct',style: TextStyle(
                              ),)
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
                                backgroundColor: Color(0xffe55c4f),
                              ),
                              Text(
                                  '${(totalScore- userScore).toString()} Wrong')
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
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
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
                    height: constraints.maxHeight * 0.22,
                    width: constraints.maxWidth * 0.8,
                    child: Text(
              buddyWords,

                      style: TextStyle(
                          color: Color(0xff232323),
                          wordSpacing: 1.5,
                          fontWeight:FontWeight.w400,
                          height: 1.5,
                          fontSize: 12),
                    ),
                  ),
                ],
              );
            }),
          );
        }
      ),
    );
  }
}
