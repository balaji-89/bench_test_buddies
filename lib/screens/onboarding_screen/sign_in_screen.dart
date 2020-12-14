import 'package:flutter/material.dart';

import '../onboarding_screen/forget_password.dart';
import '../onboarding_screen/sign_up_screen.dart';
import 'package:bench_test_buddies/on_boarding_setup/set_up.dart';

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
        child: ListView(
          children: [
            SizedBox(
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
                      height: mediaQueryHeight * 0.065,
                      width: MediaQuery.of(context).size.width - 30,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Color(0xFF4667EE),
                        child: Text('Sign in'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SetupScreen()));
                        },
                      )),
                       
        
                ],
              ),
            ),
          ),
          SizedBox(height:mediaQueryHeight*0.42),      
                 SizedBox(
              height: mediaQueryWidth * 0.06,
              width: mediaQueryWidth * 0.88,
              child: RichText(
                maxLines: 1,
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'By Signing up you are agree to our  ',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: 'terms and policy',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),],
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
