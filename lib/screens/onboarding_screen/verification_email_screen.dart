import 'package:bench_test_buddies/on_boarding_setup/set_up.dart';
import 'package:bench_test_buddies/provider/signIn_up_provider.dart';
import 'package:bench_test_buddies/screens/onboarding_screen/get_started_screen.dart';
import 'package:bench_test_buddies/screens/onboarding_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

class EmailVerification extends StatefulWidget {
  final String email;
  final String errorMessage;

  EmailVerification(this.email, this.errorMessage);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  String receivedCode;
  bool resendClicked = false;

  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisibility =
        MediaQuery.of(context).viewInsets.bottom != 0.0 ? true : false;

    showSnackBar() {
      return _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("The verification code is sent",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'Verification',
          style: TextStyle(color: Color(0xFF1a1a4b), fontSize: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ))
          : LayoutBuilder(builder: (context, constraints) {
              return ListView(children: [
                Container(
                  margin: EdgeInsets.only(
                      top: constraints.maxHeight * 0.08,
                      bottom: constraints.maxHeight * 0.065),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundImage:
                          AssetImage("assets/on_boarding_images/setup2.png"),
                    ),
                    title: SizedBox(
                      width: constraints.maxWidth * 0.65,
                      child: Text(
                        'We have sent 4-Digit verification code to your email address',
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 16,
                          color: const Color(0xff232323),
                          fontWeight: FontWeight.w500,
                          height: 1.3333333333333333,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: isKeyboardVisibility
                        ? constraints.maxHeight * 0.17
                        : constraints.maxHeight * 0.1,
                    width: constraints.maxWidth * 0.8,
                    child: Center(
                      child: PinCodeTextField(
                        pinBoxHeight: constraints.maxWidth * 0.15,
                        pinBoxWidth: constraints.maxWidth * 0.15,
                        pinTextStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        pinBoxOuterPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        autofocus: false,
                        onDone: (String enteredCode) {
                          setState(() {
                            receivedCode = enteredCode;
                          });
                        },
                        highlightPinBoxColor: Theme.of(context).primaryColor,
                        defaultBorderColor: Colors.white,
                        highlightColor: Theme.of(context).primaryColor,
                        highlight: true,
                        pinBoxDecoration: (color, colors,
                            {borderWidth, radius}) {
                          return BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: color == Colors.black
                                  ? Theme.of(context).primaryColor
                                  : color,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                    height: isKeyboardVisibility
                        ? constraints.maxHeight * 0.1
                        : constraints.maxHeight * 0.07,
                    margin: EdgeInsets.only(top: constraints.maxHeight * 0.05),
                    padding: EdgeInsets.fromLTRB(constraints.maxWidth * 0.15, 0,
                        constraints.maxWidth * 0.15, 0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text('Verify and proceed'),
                      onPressed: () async {
                        if (receivedCode.length == 4) {
                          try {
                            setState(() {
                              isLoading = true;
                            });

                            await Provider.of<SignInUp>(context, listen: false)
                                .emailVerification(
                                    widget.email, int.parse(receivedCode))
                                .then((value) {
                              print('value $value');

                              if (value == "Email verified.")
                                showDialog(
                                    context: _scaffoldKey.currentContext,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text('Email Verified'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                if (widget.errorMessage ==
                                                    "Email already in Use.") {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SignInPage()));
                                                } else {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SetupScreen()));
                                                }
                                              },
                                              child: Text('Ok'))
                                        ],
                                      );
                                    });
                            });
                          } catch (errorMessage) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Text('$errorMessage'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Ok"))
                                      ],
                                    ));
                          }
                        }
                      },
                    )),
                SizedBox(
                  height: constraints.maxHeight * 0.33,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Didn\'t receive the verfication code ? ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 3,
                          ),
                          child: InkWell(
                            onTap: () async {
                              if (resendClicked == false) {
                                setState(() {
                                  resendClicked = true;
                                });

                                try {
                                  await Provider.of<SignInUp>(context,
                                          listen: false)
                                      .resendCodeForVerification(widget.email)
                                      .then((String value) {
                                        if(value.contains("sent")){
                                          showSnackBar();
                                        }
                                    setState(() {
                                      resendClicked = false;
                                    });
                                  });
                                } catch (error) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text('${error.toString()}'),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>GetStartedScreen()));
                                                  },
                                                  child: Text('OK'))
                                            ],
                                          ));
                                }
                              }
                            },
                            child: Text(
                              'RESEND',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: resendClicked == true
                                    ? Colors.black12
                                    : Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]);
            }),
    );
  }
}
