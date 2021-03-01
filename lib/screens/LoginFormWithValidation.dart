import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../screens/templates_overview_screen.dart';
//import 'package:form_field_validator/form_field_validator.dart';

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
        title: Text(
          'An Error Occurred!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: Theme.of(context).textTheme.headline3.fontFamily,
            fontWeight: Theme.of(context).textTheme.headline3.fontWeight,
          ),
        ),
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
              image: AssetImage('assets/images/loginlogo.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                          padding: EdgeInsets.symmetric(
                            horizontal: orientation == Orientation.portrait
                                ? _deviceSize.width / 15
                                : _deviceSize.height / 4,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  //labelText: 'Email',
                                  hintText: 'Enter valid email'),
                              // validator: MultiValidator(
                              //   [
                              //     RequiredValidator(errorText: "* Required"),
                              //     EmailValidator(
                              //         errorText: "Enter valid email id"),
                              //   ],
                              // ),
                              onChanged: (value) {
                                _authData['email'] = value;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: orientation == Orientation.portrait
                              ? EdgeInsets.only(
                                  left: _deviceSize.width / 15,
                                  right: _deviceSize.width / 15,
                                  top: _deviceSize.width / 15,
                                  bottom: 0)
                              : EdgeInsets.only(
                                  left: _deviceSize.height / 4,
                                  right: _deviceSize.height / 4,
                                  top: _deviceSize.height / 30,
                                  bottom: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  //   labelText: 'Password',
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
                              // validatePassword,        //Function to check validation

                              onChanged: (value) {
                                _authData['password'] = value;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? _deviceSize.height / 25
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
                                fontSize: 22,
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
                            FlatButton(
                              onPressed: () async {
                                if (loginformkey.currentState.validate()) {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  print(_authData);
                                  try {
                                    final newUser = await _auth
                                        .createUserWithEmailAndPassword(
                                            email: _authData['email'],
                                            password: _authData['password']);
                                    if (newUser != null) {
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
                            FlatButton(
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
