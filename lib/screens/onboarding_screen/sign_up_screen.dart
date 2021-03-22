import 'package:bench_test_buddies/provider/signIn_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../onboarding_screen/sign_in_screen.dart';
import 'verification_email_screen.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool disableButton = true;
  var formKey = GlobalKey<FormState>();

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

  String passwordValidation(String password) {
    password.trim();
    if (password == null || password.isEmpty)
      return 'The name field is required';
    else if (!password.contains(new RegExp(r'[A-Z]')))
      return 'The password must contain  or more uppercase characters';
    else if (!password.contains(new RegExp(r'[0-9]')))
      return 'The password must contain 1 or more digit characters';
    else if (!password.contains(new RegExp(r'[!@#%^&*()<>?":{}|]')))
      return 'The password must contain 1 or more special characters';
    else
      return null;
  }

  void clearData() {
    Provider.of<SignInUp>(context, listen: false).clearData();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery
        .of(context)
        .size
        .height;
    final mediaQueryWidth = MediaQuery
        .of(context)
        .size
        .width;

    bool isLoading = Provider
        .of<SignInUp>(context)
        .isLoading;

    Future logInFunction() async {
      FocusScope.of(context).unfocus();
      if (formKey.currentState.validate()) {
        try {
          await Provider.of<SignInUp>(context, listen: false)
              .signUp(userController.text, emailController.text,
              passwordController.text, passwordController.text, context)
              .then((value) {
            if (Provider
                .of<SignInUp>(context, listen: false)
                .emailVerified ==
                true) {
              clearData();
              return Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInPage()));
            }
            if (Provider
                .of<SignInUp>(context, listen: false)
                .emailVerified !=
                true) clearData();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    EmailVerification(emailController.text,
                        "" //empty String to verify know whether userNAme is already exists or not
                    )));
          });
        } catch (error) {
          if (error == "Email already in Use.") {
            Provider
                .of<SignInUp>(context, listen: false)
                .emailErrorText = null;
            clearData();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    EmailVerification(emailController.text, error)));
          }
        }
      }
    }

    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xFF1a1a4b),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              clearData();
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text(
            'Sign up',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF232323),
                fontSize: 20),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.blueAccent,
              onPressed: () {
                clearData();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignInPage()));
              },
              child: Text(
                "Sign in",
                style: TextStyle(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ]),
      body: Stack(
        children: [
          SizedBox(
            height: mediaQueryHeight,
            width: mediaQueryWidth,
            child: ListView(
              children: [
                SizedBox(
                  height: mediaQueryHeight * 0.5,
                  width: mediaQueryWidth * 0.90,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child:
                    Consumer<SignInUp>(builder: (context, instance, child) {
                      return Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'User Name',
                                errorText: instance.userErrorText,
                                errorStyle: TextStyle(color: Color(0xffE54839)),
                                labelStyle: TextStyle(color: Color(0xffB1B1B1)),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffE54839), width: 2.0),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffE54839), width: 2.0),
                                ),
                              ),
                              keyboardType: TextInputType.name,
                              controller: userController,
                              textInputAction: TextInputAction.next,
                              validator: (String enteredValue) {
                                if (enteredValue == null ||
                                    enteredValue == '') {
                                  return 'The name field is required';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                errorText: instance.emailErrorText,
                                errorStyle: TextStyle(color: Color(0xffE54839)),
                                labelStyle: TextStyle(color: Color(0xffB1B1B1)),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffE54839), width: 2.0),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffE54839), width: 2.0),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              validator: (String enteredEmailAdd) {
                                if (enteredEmailAdd.isEmpty ||
                                    enteredEmailAdd == null ||
                                    !enteredEmailAdd.contains('@'))
                                  return 'Enter valid Email Address';
                                return null;
                              },
                            ),
                            Consumer<SignInUp>(
                                builder: (context, classObject, child) {
                                  return TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        errorText: instance.passwordErrorText,
                                        errorStyle:
                                        TextStyle(color: Color(0xffE54839)),
                                        labelStyle:
                                        TextStyle(color: Color(0xffB1B1B1)),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffE54839),
                                              width: 2.0),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffE54839),
                                              width: 2.0),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: classObject.passwordInvisible
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility),
                                          onPressed: () {
                                            classObject
                                                .changePasswordVisibility();
                                          },
                                        )),
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: passwordController,
                                    textInputAction: TextInputAction.done,
                                    obscureText: classObject.passwordInvisible,
                                    validator: (String enteredPassword) {
                                      return passwordValidation(
                                          enteredPassword);
                                    },
                                  );
                                }),
                            Container(
                                height: mediaQueryHeight * 0.065,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 30,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: RaisedButton(
                                  textColor: disableButton
                                      ? Color(0xFF232323)
                                      : Color(0xFFFFFFFF),
                                  color: disableButton
                                      ? Theme
                                      .of(context)
                                      .accentColor
                                      : Theme
                                      .of(context)
                                      .primaryColor,
                                  child: Text('Sign up'),
                                  onPressed: disableButton
                                      ? null
                                      : () async {
                                    await logInFunction();
                                  },
                                )),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: mediaQueryHeight * 0.33),
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
                            color: Color(0xFF232323),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: 'terms and policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xFF232323),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
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
                      backgroundColor: Theme
                          .of(context)
                          .primaryColor,
                    )))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.removeListener(() {});
    userController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }
}
