import 'dart:ui';

import 'package:bench_test_buddies/model/exercise_model.dart';
import 'package:bench_test_buddies/model/user_status.dart';
import 'package:bench_test_buddies/provider/attempt_official_provider.dart';
import 'package:bench_test_buddies/provider/attempt_provider.dart';
import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:bench_test_buddies/screens/app_ui/attempt_tab/attempt.dart';
import 'package:bench_test_buddies/screens/app_ui/bookmark_tab/bookmarks.dart';
import 'package:bench_test_buddies/screens/app_ui/home_exercises_list.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/section_view2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_ui/section_view_tab/section_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ExerciseModel userSelected;
  bool isLoading = false;
  bool dataLoaded = false;
  String token;
  final appBarNames = ['Exercise Section', 'Attempts', 'Bookmarks'];
  final List<Tab> tabBar = [
    Tab(
      text: 'Section',
    ),
    Tab(
      text: 'Attempts',
    ),
    Tab(text: 'Bookmarks')
  ];
  var value = 0;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      setState(() {
        value = _tabController.index;
      });
    });
    super.initState();
  }

  Future initializeExerciseAndUserAttempts(BuildContext context) async {
    if (dataLoaded == false) {
      token = Provider.of<UserLogData>(context, listen: false).token;
      userSelected =
          Provider.of<Exercises>(context, listen: false).selectedExercise;
      await Provider.of<AttemptedList>(context, listen: false)
          .initializeUserAttempt(token, userSelected.id);
      dataLoaded = true;
    }
  }


  Future showCustomDialog(context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Attempt Saved',
                style:
                    TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,),
              ),
              content: Text(
                " Section progress has been in app successfully.You can retrieve it later",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserLevel>(context, listen: false).userData;
    final currentSection =
        (Provider.of<UserLevel>(context, listen: false).userData)
            .currentSection;
    final userFinishedExercise =
        Provider.of<ExerciseStages>(context, listen: false)
            .findByStages(userData.completedExercise);
    void attemptStoring()async{
      if (currentSection != Stages.Start_the_exercise) {
        setState(() {
          isLoading = true;
        });
        try {
          await Provider.of<AttemptOfficial>(context,listen:false)
              .addNewAttempt(token, userFinishedExercise.length);
            showCustomDialog(context).then((value) =>
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => HomeExerciseList())));
        } catch (error) {
          print(error);
                  }
        setState(() {
          isLoading = false;
        });
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeExerciseList()));
      }
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () async {
                  dataLoaded = false;
                  attemptStoring();
                }),
            title: Text(appBarNames[value],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                    letterSpacing: 0.8)),
            elevation: 1,
            centerTitle: true,
            titleSpacing: 0.3,
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
              child: Container(
                color: Theme.of(context).accentColor,
                height: MediaQuery.of(context).size.height * 0.075,
                child: TabBar(
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  labelColor: Colors.black87,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    fontSize: 17,
                    color: Colors.black87,
                  ),
                  indicatorColor: Theme.of(context).primaryColor,
                  tabs: tabBar,
                ),
              ),
            ),
          ),
          body: FutureBuilder(
                  future: initializeExerciseAndUserAttempts(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      );
                    } else
                      return TabBarView(
                        //controller: tabController,
                        children: [
                          currentSection == Stages.Start_the_exercise
                              ? SectionView()
                              : Stack(
                                children: [
                                  SectionViewTwo(),
                                  if(isLoading==true)
                                    Container(
                                      height:MediaQuery.of(context).size.height,
                                      width:MediaQuery.of(context).size.width,
                                      color: Colors.white.withOpacity(0.6),
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Theme.of(context).primaryColor,
                                      ),
                                    )
                                ],
                              ),
                          AttemptTab(),
                          BookMarks(),
                        ],
                      );
                  })),
    );
  }
}
