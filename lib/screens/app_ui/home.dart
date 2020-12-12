import 'package:bench_test_buddies/screens/app_ui/section_view2.dart';
import 'package:bench_test_buddies/screens/onboarding_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../app_ui/section_view.dart';

class HomePage extends StatelessWidget {
  final List<Tab> tabBar = [
    Tab(
      text: 'Section',
    ),
    Tab(
      text: 'Attempts',
    ),
    Tab(text: 'Bookmarks')
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: Text('Exercise Section',
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
          children: [
            SectionView(),
            SectionViewTwo(),
            SignInPage(),
          ],
        ),
      ),
    );
  }
}
