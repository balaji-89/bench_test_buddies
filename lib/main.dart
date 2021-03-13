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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/google_sign.dart';
import 'provider/user_data_token.dart';
import 'screens/onboarding_screen/get_started_screen.dart';

void main() async {
  //var token="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODc0MDFhNDM2OTJlY2Y1YzRkZjIwNDRjM2JjZjkwNmUyYzQ0YTFmMGJmMTRlYjAyM2MyZjQwZDNjZWJiYzFhOWY5NjM5MDg5YjViYjMwOGUiLCJpYXQiOjE2MTUxMDI0NTUsIm5iZiI6MTYxNTEwMjQ1NSwiZXhwIjoxNjQ2NjM4NDU1LCJzdWIiOiI2NDAiLCJzY29wZXMiOltdfQ.B433LDvmj3mGJfP73GRIwpUnSwzmgWsY-2xuA20M3vSnxvaEAc69xQMjUePZz_oxaNyfYO5lgygaL5dA4JUmTBRpPCkZ4_jSpnM5DDXpw2PwJK2W7wKDHb3Y1w-abzuO0sRMk0mgui_xGMj1JXl1PmxArlQdib3oUV4UZX0oS92Ba8C5aRXek_Za5DPBbzwjLqEfLwrodayqGbm8blRFANS8dDnh0eB4-uIJ7mG-cdeKtfYdYnWWkMoaVEWmvfMOH65FOrlViO4foA9FyOrmzCfxdKoaCZtAoilD8xAwok5Z2S9o6fGoLCMH0J-I8QnndssBnSEI-hiKyRBPES2En0nj0ESUW3qhtBMcjAXYWzIQvCnqVxvJDmUQorHOzpyXwjtL1KOtEFea-E8oG0YNRAfgHkPWnvlTjCzE3P45wDclvPzHYN5wDZDcvHsl-iaHcupwFiHd8JKr9_NWF59DdHaAyg7D3FavjgE5k3Ov-5ksw0SJg3aiQPgeGjrj_mengnIgMG8dJphO99rrk0642dMbXHIKTAPYmiHbDH6mOO206Ov_bVDHBsg7JVOfun9eA9xdK0VJ_yr8Grym7p2s9cPA0ICOIiI2MRtt06SO5QpxOzlpiJ1Rr-RrHyZs4IJwh8_I52jcLU-fZByWQkbP0FD4ohEin7bOMXjsHqUvS7g";
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
        accentColor: Color(0xFFEFEFEF),
        fontFamily: 'SFPro',
        primaryTextTheme:
            TextTheme(button: TextStyle(color: Color(0xff232323))),
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
