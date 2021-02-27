import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../screens/templates_overview_screen.dart';

class LoginFormValidation extends StatefulWidget {
  static const routeName = '/LoginFormValidation-screen';
  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<LoginFormValidation> {
  GlobalKey<FormState> loginformkey = GlobalKey<FormState>();
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/welcomelogo.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: OrientationBuilder(
              builder: (context, orientation) {
                return SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode
                        .always, //check for validation while typing
                    key: loginformkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? _deviceSize.height / 2
                              : _deviceSize.width / 5,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            color: Colors.white,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                  hintText:
                                      'Enter valid email id as abc@gmail.com'),
                              // validator: MultiValidator(
                              //   [
                              //     RequiredValidator(errorText: "* Required"),
                              //     EmailValidator(
                              //         errorText: "Enter valid email id"),
                              //   ],
                              //),
                              onChanged: (value) {
                                _authData['email'] = value;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 15, bottom: 0),
                          child: Container(
                            color: Colors.white,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  hintText: 'Enter secure password'),
                              // validator: MultiValidator(
                              //   [
                              //     RequiredValidator(errorText: "* Required"),
                              //     MinLengthValidator(6,
                              //         errorText:
                              //             "Password should be atleast 6 characters"),
                              //     MaxLengthValidator(15,
                              //         errorText:
                              //             "Password should not be greater than 15 characters")
                              //   ],
                              // ),
                              //validatePassword,        //Function to check validation

                              onChanged: (value) {
                                _authData['password'] = value;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? _deviceSize.height / 10
                              : _deviceSize.width / 25,
                        ),
                        Container(
                          height: orientation == Orientation.portrait
                              ? _deviceSize.height / 14
                              : _deviceSize.width / 14,
                          width: orientation == Orientation.portrait
                              ? _deviceSize.width / 2
                              : _deviceSize.height / 2,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: FlatButton(
                            onPressed: () async {
                              if (loginformkey.currentState.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });
                                print(_authData);
                                try {
                                  final user =
                                      await _auth.signInWithEmailAndPassword(
                                          email: _authData['email'],
                                          password: _authData['password']);
                                  if (user != null) {
                                    Navigator.of(context).pushNamed(
                                        TemplatesOverviewScreen.routeName);
                                  }

                                  setState(() {
                                    showSpinner = false;
                                  });
                                } catch (error) {
                                  var errorMessage =
                                      'Authentication failed: \n';
                                  errorMessage =
                                      errorMessage + error.toString();

                                  _showErrorDialog(errorMessage);
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                              } else {
                                _showErrorDialog("Not Validated");
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .fontFamily,
                                fontWeight: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .fontWeight,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .backgroundColor
                                      .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20)),
                              child: FlatButton(
                                onPressed: () {
                                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .color,
                                    fontSize: 15,
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .fontFamily,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .backgroundColor
                                      .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20)),
                              child: FlatButton(
                                onPressed: () {
                                  //SignIn
                                },
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .color,
                                    fontSize: 15,
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .fontFamily,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
