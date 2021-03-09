import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:unWrapp/screens/navigation_home_screen.dart';
import 'package:unWrapp/helpers/app_theme.dart';
import 'package:unWrapp/providers/auth.dart';

class LoginFormValidation extends StatefulWidget {
  static const routeName = '/LoginFormValidation-screen';
  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<LoginFormValidation> {
  GlobalKey<FormState> loginformkey = GlobalKey<FormState>();
  bool showSpinner = false;
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  var authHandler = Auth();

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
          'Oops!',
          style: TextStyle(
            //decoration: TextDecoration.none,
            fontFamily: AppTheme.subtitle.fontFamily,
            fontSize: 18,
            color: AppTheme.darkText,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            //decoration: TextDecoration.none,
            fontFamily: AppTheme.subtitle.fontFamily,
            fontSize: 16,
            color: AppTheme.darkText,
            //fontWeight: FontWeight.w700,
          ),
          softWrap: true,
          overflow: TextOverflow.fade,
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
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
                        child: TextButton(
                          onPressed: () async {
                            if (loginformkey.currentState.validate()) {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                await authHandler
                                    .handleSignInEmail(_authData['email'],
                                        _authData['password'])
                                    .then((String errorMessage) {
                                  errorMessage == null
                                      ? Navigator.of(context).pushNamed(
                                          NavigationHomeScreen.routeName)
                                      : _showErrorDialog(errorMessage);
                                }).catchError((e) => print(e));

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
                          TextButton(
                            onPressed: () async {
                              if (loginformkey.currentState.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });
                                try {
                                  await authHandler
                                      .handleSignUp(_authData['email'],
                                          _authData['password'])
                                      .then((String errorMessage) {
                                    errorMessage == null
                                        ? Navigator.of(context).pushNamed(
                                            NavigationHomeScreen.routeName)
                                        : _showErrorDialog(errorMessage);
                                  }).catchError((e) => print(e));

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
                          TextButton(
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
