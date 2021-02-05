import 'package:bench_test_buddies/on_boarding_setup/set_up.dart';
import 'package:bench_test_buddies/provider/google_sign.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '../onboarding_screen/sign_in_screen.dart';
import '../onboarding_screen/sign_up_screen.dart';

//import 'package:bench_test_buddies/provider/google_sign.dart';

class GetStartedScreen extends StatefulWidget {
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  void initState() {
      Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final String faceBookImage = 'assets/on_boarding_images/Facebook_Icon.png';
    final String googleImage = 'assets/on_boarding_images/Google_Icon.png';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: mediaQueryHeight,
        width: mediaQueryWidth,
        child: Column(
          children: [
            SizedBox(
              height: mediaQueryHeight * 0.47,
              width: mediaQueryWidth,
            ),
            Expanded(child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.13,
                    width: constraints.maxWidth,
                    child: Text(
                      'Get Started',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.16,
                    width: constraints.maxWidth * 0.88,
                    child: buildSocialLogInButon(googleImage, 'Google'),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.16,
                    width: constraints.maxWidth * 0.88,
                    child: buildSocialLogInButon(faceBookImage, 'Facebook'),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.13,
                    width: constraints.maxWidth * 0.88,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 3,
                            child: Divider(
                              color: Colors.grey,
                            )),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'OR',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(flex: 3, child: Divider(color: Colors.grey)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.11,
                    width: constraints.maxWidth * 0.87,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 3,
                            child: buildSignButton('Sign up', constraints)),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                            flex: 3,
                            child: buildSignButton('Sign in', constraints)),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: constraints.maxHeight * 0.08,
                    width: constraints.maxWidth * 0.8,
                    child: termsPolicyText(),
                  )
                ],
              );
            }))
          ],
        ),
      ),
    );
  }

  Widget buildSocialLogInButon(
    String image,
    String buttonName,
  ) {
    return LayoutBuilder(
      builder: (context, buttonConstraints) => Padding(
          padding: EdgeInsets.only(bottom: buttonConstraints.maxHeight * 0.2),
          child: new FlatButton.icon(
            padding: EdgeInsets.all(10.0),
            icon: new Image.asset(image), //`Icon` to display
            label: Text('Proceed with $buttonName'), //`Text` to display
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: const Color(0xffD2D2D2),
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(5)),
            onPressed: () {
              if (buttonName == 'Google')
                Provider.of<GoogleSign>(context, listen: false)
                    .googleSignIn()
                    .whenComplete(() => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SetupScreen())));
              else
                print('facebook');
            },
          )),
    );
  }

  Widget buildSignButton(String label, BoxConstraints constraints) {
    const String mailLogoPath = 'assets/on_boarding_images/Email_Icon.png';
    return LayoutBuilder(
      builder: (context, buttonConstraints) => SizedBox(
        height: buttonConstraints.maxHeight,
        width: buttonConstraints.maxWidth * 0.35,
        child: new FlatButton.icon(
            padding: EdgeInsets.all(10.0),
            icon: new Image.asset(mailLogoPath),
            label: Text(label),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: const Color(0xffD2D2D2),
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(5)),
            onPressed: () {
              if (label == 'Sign up')
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              else
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignInPage()));
            }),
      ),
    );
  }

  Widget termsPolicyText() {
    return RichText(
      maxLines: 1,
      textAlign: TextAlign.end,
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
    );
  }
}
