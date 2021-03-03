import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:unWrapp/screens/navigation_home_screen.dart';

class CodeScreen extends StatefulWidget {
  static const routeName = '/code-screen';
  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  Map<String, String> _authData = {
    'specialkey': null,
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('An Error Occurred!'),
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

  bool _codeValidation(String value) {
    if (value == '123') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/welcomelogo.png'),
              fit: BoxFit.cover),
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
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: _deviceSize.height / 1.6,
                      ),

                      Padding(
                        // padding: const EdgeInsets.all(25.0),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                hintText: 'Enter your secret code'),
                            onChanged: (value) {
                              if (_codeValidation(value)) {
                                _authData['specialkey'] = value;
                              } else {
                                _authData['specialkey'] = null;
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: _deviceSize.height / 14,
                          width: _deviceSize.width / 2,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black87,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: FlatButton(
                            onPressed: () async {
                              if (formkey.currentState.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });
                                print(_authData);
                                try {
                                  // final user =
                                  //     await _auth.signInWithEmailAndPassword(
                                  //         email: _authData['email'],
                                  //         password: _authData['password']);
                                  if (_authData['specialkey'] != null) {
                                    Navigator.of(context).pushNamed(
                                        NavigationHomeScreen.routeName);
                                  } else {
                                    _showErrorDialog("Not Validated");
                                    setState(() {
                                      showSpinner = false;
                                    });
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
                              'Unwrap it!',
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
                      ),
                      // Container(
                      //   child: Align(
                      //     alignment: Alignment.centerRight,
                      //     child: IconTheme(
                      //       data: IconThemeData(color: Colors.grey),
                      //       child: Icon(
                      //         Icons.chevron_right_outlined,
                      //         // Icons.double_arrow,
                      //         size: 60,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: _deviceSize.height / 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '...or swipe left to prepare a lovely app',
                          style: TextStyle(
                            color: Colors.redAccent,
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
