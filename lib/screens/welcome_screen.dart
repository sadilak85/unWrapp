import 'package:flutter/material.dart';
import '../helpers/rounded_button.dart';

import './login_screen.dart';
import './registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  static const routeName = '/welcome-screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                child: Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.headline3.fontFamily,
                    color: Theme.of(context).textTheme.headline3.color,
                    fontSize: Theme.of(context).textTheme.headline3.fontSize,
                    fontWeight:
                        Theme.of(context).textTheme.headline3.fontWeight,
                  ),
                ),
                height: 60.0,
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: Theme.of(context).primaryColorDark,
              onPressed: () {
                Navigator.of(context).pushNamed(RegistrationScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
