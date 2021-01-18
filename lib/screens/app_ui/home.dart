import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:bench_test_buddies/screens/app_ui/attempt_tab/attempt.dart';
import 'package:bench_test_buddies/screens/app_ui/bookmark_tab/bookmarks.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/section_view2.dart';
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

  @override
  Widget build(BuildContext context) {
    final userToken = Provider.of<UserLogData>(context, listen: false).token;
    final userData = Provider.of<Users>(
      context,
    ).userData;
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
            onPressed: () {},
          ),
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
        body: TabBarView(
          //controller: tabController,
          children: [
            userData.currentSection == Stages.Start_the_exercise
                ? SectionView()
                : SectionViewTwo(),
            AttemptTab(),
            BookMarks(),
          ],
        ),
      ),
    );
  }
}
