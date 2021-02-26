import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../screens/templates_overview_screen.dart';

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
    if (value == '123') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

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
                    key: formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? deviceSize.height / 2.5
                              : deviceSize.width / 2.5,
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconTheme(
                              data: IconThemeData(color: Colors.grey),
                              child: Icon(
                                Icons.chevron_right_outlined,
                                // Icons.double_arrow,
                                size: 60,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? deviceSize.height / 20
                              : deviceSize.width / 20,
                        ),
                        Padding(
                          // padding: const EdgeInsets.all(25.0),
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Container(
                            color: Colors.white,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Code',
                                  hintText:
                                      'Enter secure code obtained from beloved one'),
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
                        SizedBox(
                          height: orientation == Orientation.portrait
                              ? deviceSize.height / 5
                              : deviceSize.width / 5,
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
                                  // final user =
                                  //     await _auth.signInWithEmailAndPassword(
                                  //         email: _authData['email'],
                                  //         password: _authData['password']);
                                  if (_authData['specialkey'] != null) {
                                    Navigator.of(context).pushNamed(
                                        TemplatesOverviewScreen.routeName);
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
