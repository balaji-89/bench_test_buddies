import 'dart:ui';

import 'package:bench_test_buddies/onboarding_screen/forget_password.dart';
import 'package:bench_test_buddies/onboarding_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xFF1a1a4b),
          ),
          centerTitle: true,
          title: Text(
            'Sign in',
            style: TextStyle(color: Color(0xFF1a1a4b), fontSize: 20),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.blueAccent,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Text(
                "Sign up",
                style: TextStyle(fontSize: 16),
              ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ]),
      body: SizedBox(
        height: mediaQueryHeight,
        width: mediaQueryWidth,
        child: SingleChildScrollView(
          child: SizedBox(
            height: mediaQueryHeight * 0.4,
            width: mediaQueryWidth * 0.90,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: TextStyle(color: Colors.grey),
                      errorBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFFF0000), width: 2.0),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFFF0000), width: 2.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey),
                        errorBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFFF0000), width: 2.0),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFFF0000), width: 2.0),
                        ),
                        suffixIcon: Icon(Icons.visibility)),
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgetPasswordscreen()));
                      },
                      child: Text(
                        'Forgot Password?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 30,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Color(0xFF4667EE),
                        child: Text('Sign in'),
                        onPressed: () {},
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }
}
