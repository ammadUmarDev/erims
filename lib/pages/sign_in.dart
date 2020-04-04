import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:erims/components/buttonErims.dart';
import 'package:erims/components/h1.dart';
import 'package:erims/components/h3.dart';
import 'package:erims/components/textFieldErims.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../components/interTextFieldSpacing.dart';

class SignIn extends StatefulWidget {
  static final String id = 'signIn';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  TextFieldErims emailTextField = TextFieldErims(
    textFieldText: 'Email (abc@nu.edu.pk)',
    textFieldIcon: Icon(Icons.email),
    keyboardType: TextInputType.emailAddress,
    isValidEntry: (entry) {
      if (entry.toString().endsWith('@nu.edu.pk')) return '';
      return 'Invalid Domain Name';
    },
  );
  TextFieldErims passwordTextField = TextFieldErims(
    textFieldText: 'Password',
    textFieldIcon: Icon(Icons.lock),
    obscure: true,
    keyboardType: TextInputType.visiblePassword,
    /*isValidEntry: (entry) {
      if (entry.toString().length <= 6) return false;
      return true;
    },*/ //TODO:signin k password k constraints lga lo
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFee8572),
                Color(0xFF35495e),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "E.R.I.M.S",
                              style: TextStyle(
                                fontFamily: "Cantarell",
                                fontSize: 50.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Event Registeration and Information Management System",
                              style: TextStyle(
                                fontFamily: "Cantarell",
                                fontSize: 14,
                                color: Color(0xFF35495e),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Image.asset('assets/logos/nucsw.png'),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Image.asset('assets/logos/sv.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: ListView(
                      children: <Widget>[
                        H1(textBody: "Sign In"),
                        InterTextFieldSpacing(),
                        emailTextField,
                        InterTextFieldSpacing(),
                        passwordTextField,
                        InterTextFieldSpacing(),
                        InterTextFieldSpacing(),
                        //signin button
                        ButtonErims(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              print('User Signing  In:');
                              print(emailTextField.getReturnValue());
                              print(passwordTextField.getReturnValue());
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                  email: emailTextField.getReturnValue(),
                                  password: passwordTextField.getReturnValue(),
                                );
                                if (user != null) {
                                  Navigator.pushNamed(context, "dashBoard");
                                } else {
                                  //TODO: if login not successful, then what
                                }
                              } catch (e) {
                                print(e);
                                if (e.runtimeType == PlatformException) {
                                  //invalidUsernameOrPassword=true;
                                  _showDialog();
                                }
                              }
                              stopLoading();
                            } else {
                              stopLoading();
                            }
                          },
                          labelText: "SIGN IN",
                        ),
                        InterTextFieldSpacing(),
                        //already have an account?
                        Center(
                          child: H3(textBody: "Don't have an account?"),
                        ),
                        //signup button
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "signUp");
                            },
                            child: H3(
                              textBody: "Sign Up",
                              color: Color(0xFFee8572),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Invalid Username or Password"), //TODO: make dialog pretty
      ),
    );
  }
}
