import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:unwrapp/screens/welcomescreen_controller.dart';
import 'package:unwrapp/providers/auth.dart';
import 'package:unwrapp/providers/userchoices.dart';
import 'package:unwrapp/providers/themedata.dart';
import 'package:unwrapp/screens/codeEntry_screen.dart';
import 'package:unwrapp/screens/splash_screen.dart';
import 'package:unwrapp/screens/albums_overview_screen.dart';
import 'package:unwrapp/screens/album_detail_screen.dart';
import 'package:unwrapp/screens/orders_screen.dart';
import 'package:unwrapp/screens/edit_album_screen.dart';
import 'package:unwrapp/screens/LoginFormWithValidation.dart';
import 'package:unwrapp/screens/navigation_home_screen.dart';
import 'package:unwrapp/screens/celebration_selection_screen.dart';
import 'package:unwrapp/screens/colors_selection_screen.dart';
import 'package:unwrapp/screens/fonts_selection_screen.dart';

// import './screens/login_screen.dart';
// import './screens/registration_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// void main() => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then(
    (_) => runApp(
      ChangeNotifierProvider<ThemeModel>(
        create: (context) => ThemeModel(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, UserChoices>(
          create: null,
          update: (ctx, auth, previousChoices) => UserChoices(
            auth.userId,
            previousChoices == null ? [] : previousChoices.choices,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'unwrapp',
          debugShowCheckedModeBanner: false,
          navigatorKey: key,
          //platform: TargetPlatform.android,
          theme: Provider.of<ThemeModel>(context).currentTheme,
          home: auth.isAuth
              ? NavigationHomeScreen()

              ///  Change this to the final main screen
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : WelcomeScreen(),
                ),
          routes: {
            WelcomeScreen.routeName: (context) => WelcomeScreen(),
            LoginFormValidation.routeName: (context) => LoginFormValidation(),
            CodeScreen.routeName: (context) => CodeScreen(),
            // LoginScreen.routeName: (context) => LoginScreen(),
            // RegistrationScreen.routeName: (context) => RegistrationScreen(),
            NavigationHomeScreen.routeName: (context) => NavigationHomeScreen(),
            CelebrationSelectionScreen.routeName: (context) =>
                CelebrationSelectionScreen(),
            NavigationColorsScreen.routeName: (context) =>
                NavigationColorsScreen(),
            NavigationFontsScreen.routeName: (context) =>
                NavigationFontsScreen(),

            AlbumsOverviewScreen.routeName: (context) => AlbumsOverviewScreen(),
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
