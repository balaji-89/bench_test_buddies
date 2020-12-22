import 'package:bench_test_buddies/provider/signIn_up_provider.dart';
import 'package:bench_test_service/bench_test_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../onboarding_screen/succeeded_forget_password.dart';

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
      body: Consumer<SignIn>(
        builder: (context, classInstance,child) {
          return Stack(
            children: [
              SizedBox(
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
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: TextStyle(color: Colors.grey),
                              errorText: classInstance.emailErrorText,
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
                              height: mediaQueryHeight * 0.065,
                              width: MediaQuery.of(context).size.width - 30,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: Color(0xFF4667EE),
                                child: Text('Send the reset link'),
                                onPressed: () async{
                                  FocusScope.of(context).unfocus();
                                  try {
                                    await classInstance.sendTheLink(
                                        emailController.text).then((value) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SucceededPasswordScreen(emailController.text)));
                                    });
                                  }on ErrorResponse catch(error){

                                  }catch(error){
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Error'),
                                          content: Text(
                                              'Something went wrong!!'),
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
                ),
              ),
              if (classInstance.isLoading)
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
        }
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }
}
