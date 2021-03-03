import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:unWrapp/helpers/rounded_button.dart';
import 'package:unWrapp/helpers/constants.dart';
import 'package:unWrapp/screens/templates_selection_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  static const routeName = '/registration-screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  final _text = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Text(
                      'Flash Chat',
                      style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.headline3.fontFamily,
                        color: Theme.of(context).textTheme.headline3.color,
                        fontSize:
                            Theme.of(context).textTheme.headline3.fontSize,
                        fontWeight:
                            Theme.of(context).textTheme.headline3.fontWeight,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  //kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                  labelText: 'Enter the Value',
                  errorText: _validate ? 'Value Can\'t Be Empty' : null,
                ),
                controller: _text,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                colour: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                    _text.text.isEmpty ? _validate = true : _validate = false;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.of(context)
                          .pushNamed(NavigationTemplatesScreen.routeName);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
