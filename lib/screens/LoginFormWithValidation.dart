import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:unWrapp/screens/navigation_home_screen.dart';
import 'package:unWrapp/helpers/app_theme.dart';

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

  // Future<bool> getData() async {
  //   await Future<dynamic>.delayed(const Duration(milliseconds: 0));
  //   return true;
  // }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              Navigator.of(context).pop();
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/logo.png'), fit: BoxFit.contain),
        ),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode
                      .always, //check for validation while typing
                  key: loginformkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: _deviceSize.height / 2,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: _deviceSize.width / 15,
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
                                labelText: 'Email',
                                hintText: 'Enter valid email'),
                            validator: MultiValidator(
                              [
                                RequiredValidator(errorText: "* Required"),
                                EmailValidator(
                                    errorText: "Enter valid email id"),
                              ],
                            ),
                            onChanged: (value) {
                              _authData['email'] = value;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: _deviceSize.width / 15,
                            right: _deviceSize.width / 15,
                            top: _deviceSize.width / 15,
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
                            // validatePassword,        //Function to check validation

                            onChanged: (value) {
                              _authData['password'] = value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _deviceSize.height / 25,
                      ),
                      Container(
                        height: _deviceSize.height / 14,
                        width: _deviceSize.width / 2,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              color: Colors.black87,
                              offset: Offset(0, 1),
                            )
                          ],
                        ),
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
                                      NavigationHomeScreen.routeName);
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
                              fontSize: 22,
                              fontFamily: AppTheme.title.fontFamily,
                              fontWeight: AppTheme.title.fontWeight,
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
                                        NavigationHomeScreen.routeName);
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
                              style:
                                  // TextStyle(
                                  //   color:
                                  //       Theme.of(context).textTheme.headline5.color,
                                  //   fontSize: 15,
                                  //   fontFamily: Theme.of(context)
                                  //       .textTheme
                                  //       .headline5
                                  //       .fontFamily,
                                  //   fontWeight: FontWeight.normal,
                                  // ),
                                  TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15,
                                fontFamily: AppTheme.subtitle.fontFamily,
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
                                color: Colors.redAccent,
                                fontSize: 15,
                                fontFamily: AppTheme.subtitle.fontFamily,
                                fontWeight: FontWeight.normal,
                              ),
                              // TextStyle(
                              //   color:
                              //       Theme.of(context).textTheme.headline5.color,
                              //   fontSize: 15,
                              //   fontFamily: Theme.of(context)
                              //       .textTheme
                              //       .headline5
                              //       .fontFamily,
                              //   fontWeight: FontWeight.normal,
                              // ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
