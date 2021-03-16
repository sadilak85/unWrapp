import 'package:flutter/material.dart';
import 'package:unwrapp/helpers/custom_route.dart';

class ThemeModel extends ChangeNotifier {
  Color primarycolor = Color.fromRGBO(244, 67, 54, 1);
  Color accentcolor = Color.fromRGBO(212, 226, 212, 1);

  ThemeData get currentTheme => ThemeData(
// brightness: Brightness.dark,
        primarySwatch: Colors.red,
        backgroundColor: Colors.white,
        // primaryColorLight: Color.fromRGBO(255, 205, 210, 1),
        // primaryColorDark: Color.fromRGBO(211, 47, 47, 1),
        //
        // primaryColor: Color.fromRGBO(244, 67, 54, 1),
        // accentColor: Color.fromRGBO(3, 169, 244, 1),
        // bottomAppBarColor: Color.fromRGBO(189, 189, 189, 1),

        primaryColor: primarycolor,
        accentColor: accentcolor,

        bottomAppBarColor: Color.fromRGBO(223, 120, 97, 1),
        canvasColor: Colors.white,
        //
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          },
        ),
      );
}

// Color.fromRGBO(252, 248, 232, 1),
// Color.fromRGBO(212, 226, 212, 1),
// Color.fromRGBO(236, 179, 144, 1),
// Color.fromRGBO(223, 120, 97, 1),
