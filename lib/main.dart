import 'package:bench_test_buddies/provider/google_sign.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'onboarding_screen/get_started_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => Googlesign(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Colors.white,
            elevation: 0,
            actionsIconTheme: IconThemeData(
              color: Colors.blue,
            )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(child: GetStartedScreen()),
    );
  }
}
