import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Loading...',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: Theme.of(context).textTheme.headline2.fontFamily,
            fontWeight: Theme.of(context).textTheme.headline2.fontWeight,
          ),
        ),
      ),
    );
  }
}
