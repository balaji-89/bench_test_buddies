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
  final scoreCardModel;

  ViewResultHome({@required this.scoreCardModel});

  @override
  _ViewResultHomeState createState() => _ViewResultHomeState();
}


class _ViewResultHomeState extends State<ViewResultHome> {


  @override
  Widget build(BuildContext context) {
    String userToken = Provider.of<UserLogData>(context, listen: false).token;
    final mediaQuery = MediaQuery.of(context).size;
    List<Widget> list = [
      SizedBox(
        height: mediaQuery.height*0.033,
        width:mediaQuery.width*0.4,
        child: Text(
          "Score Card",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18,color:Color(0xff232323)),
        ),
      ),
      SizedBox(
        height: mediaQuery.height*0.03,
        width:mediaQuery.width*0.45,
        child: Text(
          "View Solution",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff232323),
            fontSize: 18,
          ),
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
            fontWeight: FontWeight.w600,
            color: Color(0xff232323),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Provider.of<UserLevel>(context,listen:false).changeUserStage(Stages.View_the_results);
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff232323),
          ),
        ),
      ),
      body: FutureBuilder(
          future: Provider.of<ViewResultProvider>(context, listen: false)
              .initializeData(userToken),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
            if(snapshot.hasError){
               return AlertDialog(content: Text('Something went wrong'),actions: [TextButton(onPressed: (){
                 Navigator.of(context).pop();
                 Navigator.of(context).pop();
               }, child: Text('Ok'))],);
            }
            return DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxHeight: 250.0),
                    height: mediaQuery.height * 0.08,
                    child: Material(
                      color: Theme.of(context).accentColor,
                      child: TabBar(
                        indicatorColor: Theme.of(context).primaryColor,
                        tabs: list,
                        labelColor: Color(0xff232323),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ResultsScoreCard(userResults: widget.scoreCardModel,),
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
