import 'package:flutter/material.dart';
import 'package:unwrapp/screens/LoginFormWithValidation.dart';
import 'package:unwrapp/screens/codeEntry_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        CodeScreen(),
        LoginFormValidation(),
      ],
    );
  }
}
