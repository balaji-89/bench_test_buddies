import 'package:bench_test_buddies/provider/signIn_up_provider.dart';
import 'package:bench_test_service/model/response/response_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../onboarding_screen/forget_password.dart';
import '../onboarding_screen/sign_up_screen.dart';
import 'package:bench_test_buddies/on_boarding_setup/set_up.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool disableButton = true;

  @override
  void initState() {
    passwordController.addListener(() {
      if (passwordController.text.isEmpty) {
        setState(() {
          disableButton = true;
        });
      } else {
        setState(() {
          disableButton = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    bool isLoading = Provider.of<SignIn>(context).isLoading;

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
      body: Consumer<SignIn>(builder: (context, instance, child) {
        return Stack(
          children: [
            SizedBox(
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
                              errorText: instance.emailErrorText,
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFFF0000), width: 2.0),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFFF0000), width: 2.0),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.always,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.grey),
                                errorText: instance.passwordErrorText,
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFFF0000), width: 2.0),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFFF0000), width: 2.0),
                                ),
                                suffixIcon: IconButton(
                                  icon: instance.passwordInvisible
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onPressed: () {
                                    instance.changePasswordVisibility();
                                  },
                                )),
                            obscureText: instance.passwordInvisible,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordscreen()));
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
                                textColor:
                                    disableButton ? Colors.black : Colors.white,
                                color: disableButton
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).primaryColor,
                                child: Text('Sign in'),
                                onPressed: disableButton
                                    ? null
                                    : () async {
                                        FocusScope.of(context).unfocus();

                                        try {
                                          await Provider.of<SignIn>(context,
                                                  listen: false)
                                              .signIn(emailController.text,
                                                  passwordController.text)
                                              .then((value) => Navigator.of(
                                                      context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SetupScreen())));
                                        } on ErrorResponse catch (error) {} catch (error) {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text('Error'),
                                                    content: Text(
                                                        'Check your internet connection'),
                                                    actions: [
                                                      FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('OK'))
                                                    ],
                                                  ));
                                        }
                                      },
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: mediaQueryHeight * 0.42),
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
                  ),
                ],
              ),
            ),
            if (isLoading)
              Container(
                  height: mediaQueryHeight,
                  width: mediaQueryWidth,
                  child: Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 5,
                    backgroundColor: Theme.of(context).primaryColor,
                  )))
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.removeListener(() {});
    passwordController.dispose();
    emailController.dispose();
  }
}
