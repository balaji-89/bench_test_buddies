import 'package:bench_test_buddies/provider/signIn_up_provider.dart';
import 'package:bench_test_buddies/screens/onboarding_screen/succeeded_forget_password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();

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

  @override
  void dispose() {
    super.dispose();
    passwordController.removeListener(() {});
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    bool isLoading = Provider.of<SignInUp>(context).isLoading;

    Future changePassword() async {
      FocusScope.of(context).unfocus();
      if (formKey.currentState.validate()) {
        setState(() {
          isLoading=true;
        });
        try {
           await Provider.of<SignIn>(context,listen:false).changeUserPassword(passwordController.text,context)
               .then((value) {
                 setState(() {
                   isLoading=false;
                 });
                 if(value!=null){
                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SucceededPasswordScreen(
                       Provider.of<SignIn>(context,listen: false).forgetEmailId
                   )));
                 }
           });

        } catch (error) {
          showDialog(context: context,builder: (context)=>AlertDialog(
            title: Text('${error["message"]}'),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('Ok'))
            ],
          ));
        }
      }
    }

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
      body: Stack(
        children: [
          SizedBox(
            height: mediaQueryHeight,
            width: mediaQueryWidth,
            child: ListView(
              children: [
                SizedBox(
                  height: mediaQueryHeight * 0.3,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<SignInUp>(
                                builder: (context, classObject, child) {
                              return TextFormField(
                                decoration: InputDecoration(
                                    labelText: ' New Password',
                                    labelStyle: TextStyle(color: Colors.grey),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFFF0000), width: 2.0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFFFF0000), width: 2.0),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: classObject.passwordInvisible
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                      onPressed: () {
                                        classObject.changePasswordVisibility();
                                      },
                                    )),
                                keyboardType: TextInputType.visiblePassword,
                                controller: passwordController,
                                textInputAction: TextInputAction.next,
                                obscureText: classObject.passwordInvisible,
                                validator: (String enteredPassword) {
                                  return passwordValidation(enteredPassword);
                                },
                              );
                            }),
                            Container(
                                height: mediaQueryHeight * 0.065,
                                width: MediaQuery.of(context).size.width - 30,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: RaisedButton(
                                  textColor: disableButton
                                      ? Colors.black
                                      : Colors.white,
                                  color: disableButton
                                      ? Theme.of(context).accentColor
                                      : Theme.of(context).primaryColor,
                                  child: Text('Change password'),
                                  onPressed: disableButton
                                      ? null
                                      : () async {
                                          await changePassword();
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
      ),
    );
  }
}
