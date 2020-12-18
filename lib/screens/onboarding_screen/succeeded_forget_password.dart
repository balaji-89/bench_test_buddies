import 'package:bench_test_buddies/on_boarding_setup/set_up.dart';
import 'package:flutter/material.dart';

class SucceededPasswordScreen extends StatelessWidget {
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
          'Forgot Password',
          style: TextStyle(color: Color(0xFF1a1a4b), fontSize: 20),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SizedBox(
        height: mediaQueryHeight,
        width: mediaQueryWidth,
        child: SingleChildScrollView(
          child: SizedBox(
            height: mediaQueryHeight * 0.28,
            width: mediaQueryWidth * 0.90,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30.0,
                      child: new Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            image: AssetImage(
                                "assets/on_boarding_images/3.0x/completionSuccess.png"),
                          ),
                        ),
                      ),
                    ),
                    title: new Text(
                      "Password Reset Link sucessfully sent to ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: new Row(
                      children: [
                        new Text("K******2@gmail.com"),
                      ],
                    ),
                  ),
                  Container(
                      height: mediaQueryHeight * 0.065,
                      width: MediaQuery.of(context).size.width - 30,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Color(0xFF4667EE),
                        child: Text('Open Email App'),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SetupScreen()));
                        },
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
