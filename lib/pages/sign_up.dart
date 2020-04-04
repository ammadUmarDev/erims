import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erims/components/buttonErims.dart';
import 'package:erims/components/dropDown.dart';
import 'package:erims/components/h1.dart';
import 'package:erims/components/h3.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/textFieldErims.dart';
import '../components/interTextFieldSpacing.dart';

class SignUp extends StatefulWidget {
  static final String id = 'signUp';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final usersRef = Firestore.instance.collection('users');
  final DateTime timestamp = DateTime.now();

  List<Item> users = <Item>[
    const Item(
        'Student',
        Icon(
          Icons.accessibility,
          color: const Color(0xff274960),
        )),
    const Item(
        'Society',
        Icon(
          Icons.flag,
          color: const Color(0xff274960),
        )),
    const Item(
        'Mentor',
        Icon(
          Icons.card_membership,
          color: const Color(0xff274960),
        )),
    const Item(
        'Head of Department',
        Icon(
          Icons.store,
          color: const Color(0xff274960),
        )),
    const Item(
        'Director',
        Icon(
          Icons.person,
          color: const Color(0xff274960),
        )),
  ];

  TextFieldErims fullNameTextField = TextFieldErims(
    textFieldText: 'Full Name',
    textFieldIcon: Icon(Icons.person),
  );
  TextFieldErims emailTextField = TextFieldErims(
    textFieldText: 'Email (abc@nu.edu.pk)',
    textFieldIcon: Icon(Icons.email),
    keyboardType: TextInputType.emailAddress,
    isValidEntry: (entry) {
      if (entry.toString().endsWith('@nu.edu.pk')) return '';
      return 'Invalid Domain Name';
    },
  );
  Item designationItem;
  String designation;
  TextFieldErims passwordTextField = TextFieldErims(
    textFieldText: 'Password',
    textFieldIcon: Icon(Icons.lock),
    obscure: true,
    keyboardType: TextInputType.visiblePassword,
    isValidEntry: (entry) {
      if (entry.toString().length <= 6) return 'Password Length Too Short';
      return '';
    },
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Color(0xff274960),
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
                flex: 2,
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
                        H1(textBody: "Sign Up"),
                        InterTextFieldSpacing(),
                        fullNameTextField,
                        InterTextFieldSpacing(),
                        //designation
                        Container(
                          height: 55.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey[500],
                              )),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Icon(
                                    Icons.work,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: DropdownButton<Item>(
                                  isExpanded: true,
                                  isDense: false,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'SFUIDisplay',
                                    fontSize: 15,
                                  ),
                                  hint: Text("Designation"),
                                  value: designationItem,
                                  onChanged: (Item value) {
                                    setState(() {
                                      designation = value.name;
                                      designationItem = value;
                                    });
                                  },
                                  items: users.map((Item user) {
                                    return DropdownMenuItem<Item>(
                                      value: user,
                                      child: Row(
                                        children: <Widget>[
                                          user.icon,
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            user.name,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InterTextFieldSpacing(),
                        emailTextField,
                        InterTextFieldSpacing(),
                        passwordTextField,
                        InterTextFieldSpacing(),
                        InterTextFieldSpacing(),
                        //signup button
                        //already have an account?
                        ButtonErims(
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              print('User Signing Up:');
                              print(fullNameTextField.getReturnValue());
                              print(designation);
                              print(emailTextField.getReturnValue());
                              print(passwordTextField.getReturnValue());
                              try {
                                final newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: emailTextField.getReturnValue(),
                                        password:
                                            passwordTextField.getReturnValue());
                                if (newUser != null) {
                                  final FirebaseUser user =
                                      await _auth.currentUser();
                                  final userId = user.uid;
                                  usersRef.document(userId).setData({
                                    "dateOfCreation": timestamp,
                                    "designation": designation,
                                    "email": emailTextField.getReturnValue(),
                                    "fullName":
                                        fullNameTextField.getReturnValue(),
                                    "isAdmin": false,
                                    "password":
                                        passwordTextField.getReturnValue(),
                                  });
                                  Navigator.pushNamed(context, "dashBoard");
                                }
                              } catch (e) {
                                print(e);
                              }
                              stopLoading();
                            } else {
                              stopLoading();
                            }
                          },
                          labelText: "SIGN UP",
                        ),
                        InterTextFieldSpacing(),
                        Center(
                          child: H3(textBody: "Already have an account?"),
                        ),
                        //signup button
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "signIn");
                            },
                            child: H3(
                              textBody: "Sign In",
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
}
