import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../screens/LoginFormWithValidation.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  Map<String, String> _authData = {
    'specialkey': '',
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

  bool _codeValidation(String value) {
    if (value == 'Ananinami') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
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
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Center(
                          child: Container(
                              width: orientation == Orientation.portrait
                                  ? deviceSize.width / 2
                                  : 0,
                              height: orientation == Orientation.portrait
                                  ? deviceSize.height / 4
                                  : 0,
                              child:
                                  Image.asset('assets/images/welcomelogo.png')),
                        ),
                      ),
                      SizedBox(
                        height: orientation == Orientation.portrait
                            ? deviceSize.height / 10
                            : deviceSize.width / 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter secure code'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your code';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (_codeValidation(value)) {
                              _authData['specialkey'] = value;
                            } else {
                              _authData['specialkey'] = null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: orientation == Orientation.portrait
                            ? deviceSize.height / 10
                            : deviceSize.width / 15,
                      ),
                      Container(
                        height: orientation == Orientation.portrait
                            ? deviceSize.height / 14
                            : deviceSize.width / 14,
                        width: orientation == Orientation.portrait
                            ? deviceSize.width / 2
                            : deviceSize.height / 2,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: FlatButton(
                          onPressed: () async {
                            if (formkey.currentState.validate()) {
                              setState(() {
                                showSpinner = true;
                              });

                              try {
                                // final user =
                                //     await _auth.signInWithEmailAndPassword(
                                //         email: _authData['email'],
                                //         password: _authData['password']);
                                // if (user != null) {
                                //   Navigator.of(context).pushNamed(
                                //       TemplatesOverviewScreen.routeName);
                                // }
                                if (_authData['specialkey'] != null) {
                                  Navigator.of(context)
                                      .pushNamed(LoginFormValidation.routeName);
                                }

                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (error) {
                                var errorMessage = 'Authentication failed: \n';
                                errorMessage = errorMessage + error.toString();

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
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
