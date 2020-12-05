import 'dart:ui';

import 'package:bench_test_buddies/onboarding_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController userController = TextEditingController();
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
            'Sign up',
            style: TextStyle(color: Color(0xFF1a1a4b), fontSize: 20),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.blueAccent,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignInPage()));
              },
              child: Text(
                "Sign in",
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
            height: mediaQueryHeight * 0.5,
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
                      labelText: 'User Name',
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
                    keyboardType: TextInputType.name,
                    controller: userController,
                    textInputAction: TextInputAction.next,
                  ),
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
                  Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 30,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Color(0xFF4667EE),
                        child: Text('Sign up'),
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
    userController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }
}
