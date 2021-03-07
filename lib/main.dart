import 'dart:ui';

import 'package:bench_test_buddies/provider/attempt_official_provider.dart';
import 'package:bench_test_buddies/provider/attempt_provider.dart';
import 'package:bench_test_buddies/provider/country_provider.dart';
import 'package:bench_test_buddies/provider/evaluation_questions_provider.dart';
import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/signIn_up_provider.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:bench_test_buddies/provider/view_result_provider.dart';
import 'package:bench_test_service/service/exercise.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/google_sign.dart';
import 'on_boarding_setup/set_up.dart';
import 'provider/user_data_token.dart';
import 'screens/onboarding_screen/get_started_screen.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserLogData(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserLevel(),
    ),
    ChangeNotifierProvider(
      create: (context) => AttemptOfficial(),
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
    ChangeNotifierProvider(
      create: (context) => EvaluationsQuestionsProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ViewResultProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => BookmarksProvider(),
    ),
  ],

      child: MyApp()));
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
        accentColor: Color(0xFFEFEFEF),
        fontFamily: 'SFPro',
        primaryTextTheme: TextTheme(button: TextStyle(color:Color(0xff232323))),
        appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Colors.white,
            iconTheme: IconThemeData(color: Color(0xffEFEFEF)),
            elevation: 0,
            actionsIconTheme: IconThemeData(
              color: Color(0xFF4667EE),
            )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
        child: GetStartedScreen(),
      ),
    );
  }
}
