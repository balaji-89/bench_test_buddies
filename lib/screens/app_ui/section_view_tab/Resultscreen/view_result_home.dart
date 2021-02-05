import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:bench_test_buddies/provider/view_result_provider.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/Resultscreen/result_score_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_solution.dart';

class ViewResultHome extends StatefulWidget {
  @override
  _ViewResultHomeState createState() => _ViewResultHomeState();
}

class _ViewResultHomeState extends State<ViewResultHome> {


  @override
  Widget build(BuildContext context) {
    String userToken = Provider.of<UserLogData>(context, listen: false).token;
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
            Provider.of<UserLevel>(context,listen:false).changeUserStage(Stages.View_the_results);
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
          future: Provider.of<ViewResultProvider>(context, listen: true)
              .initializeData(userToken),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
            return DefaultTabController(
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
                        ResultsScoreCard(attemptId: 1),
                        ViewSolutions(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
