import 'package:flutter/material.dart';

class ForgetPasswordscreen extends StatefulWidget {
  @override
  _ForgetPasswordscreenState createState() => _ForgetPasswordscreenState();
}

class _ForgetPasswordscreenState extends State<ForgetPasswordscreen> {
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
            height: mediaQueryHeight * 0.3,
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
                  Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 30,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Color(0xFF4667EE),
                        child: Text('Send the reset link'),
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
    emailController.dispose();
  }
}
