import 'package:bench_test_buddies/screens/app_ui/section_view_tab/Resultscreen/result_score_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bar.dart';
import 'view_solution.dart';

class ViewResultHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size;
    List<Widget> list = [
      Text(
        "Score Card",
        style: TextStyle(fontSize: 18),
      ),
      Text(
        "View Solution",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'View Results',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            //Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 250.0),
              height: heights.height * 0.08,
              child: Material(
                color: Theme.of(context).accentColor,
                child: TabBar(
                  tabs: list,
                  labelColor: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ResultsScoreCard(attemptId:1),
                  ViewSolutions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

