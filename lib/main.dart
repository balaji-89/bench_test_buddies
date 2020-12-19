
import 'package:bench_test_buddies/provider/attempt_provider.dart';
import 'package:bench_test_buddies/provider/country_provider.dart';
import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/signIn_up_provider.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/google_sign.dart';
import './screens/onboarding_screen/get_started_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => Users(),
    ),
    ChangeNotifierProvider(
      create: (context) => GoogleSign(),
    ),
    ChangeNotifierProvider(
      create: (context) => CountryProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => SignInUp(),
    ),
    ChangeNotifierProvider(
      create: (context) => SignIn(),
    ),
    ChangeNotifierProvider(
      create: (context) => AttemptedList(),
    ),
    ChangeNotifierProvider(
      create: (context) => ExerciseStages(),
    ),
    ChangeNotifierProvider(
      create: (context) => Exercises(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF4667EE),
        backgroundColor: Colors.white,
        accentColor: Color.fromRGBO(240, 238, 235, 1),
        appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
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


