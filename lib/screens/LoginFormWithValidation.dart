import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../screens/templates_overview_screen.dart';

class LoginFormValidation extends StatefulWidget {
  static const routeName = '/LoginFormValidation-screen';
  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<LoginFormValidation> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
                                  Image.asset('assets/images/loginlogo.png')),
                        ),
                      ),
                      SizedBox(
                        height: orientation == Orientation.portrait
                            ? deviceSize.height / 15
                            : deviceSize.width / 15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              hintText:
                                  'Enter valid email id as abc@gmail.com'),
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: "* Required"),
                              EmailValidator(errorText: "Enter valid email id"),
                            ],
                          ),
                          onChanged: (value) {
                            _authData['email'] = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              hintText: 'Enter secure password'),
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: "* Required"),
                              MinLengthValidator(6,
                                  errorText:
                                      "Password should be atleast 6 characters"),
                              MaxLengthValidator(15,
                                  errorText:
                                      "Password should not be greater than 15 characters")
                            ],
                          ),
                          //validatePassword,        //Function to check validation

                          onChanged: (value) {
                            _authData['password'] = value;
                          },
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          //TODO FORGOT PASSWORD SCREEN GOES HERE
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline5.color,
                            fontSize:
                                Theme.of(context).textTheme.headline5.fontSize,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .headline5
                                .fontFamily,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .headline5
                                .fontWeight,
                          ),
                        ),
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
                                var errorMessage = 'Authentication failed: \n';
                                errorMessage = errorMessage + error.toString();

                                _showErrorDialog(errorMessage);
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } else {
                              print("Not Validated");
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
                      SizedBox(
                        height: orientation == Orientation.portrait
                            ? deviceSize.height / 10
                            : 0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'New User?',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline5.color,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .fontSize,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .fontFamily,
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .fontWeight,
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              //SignIn
                            },
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline5.color,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .fontSize,
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .fontFamily,
                                fontWeight: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .fontWeight,
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
    );
  }
}
