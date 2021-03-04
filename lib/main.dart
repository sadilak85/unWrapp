import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:unWrapp/helpers/custom_route.dart';
import 'package:unWrapp/helpers/welcomescreen_controller.dart';
import 'package:unWrapp/providers/albums.dart';
import 'package:unWrapp/providers/orders.dart';
import 'package:unWrapp/providers/auth.dart';
import 'package:unWrapp/screens/codeEntry_screen.dart';
import 'package:unWrapp/screens/splash_screen.dart';
import 'package:unWrapp/screens/albums_overview_screen.dart';
import 'package:unWrapp/screens/album_detail_screen.dart';
import 'package:unWrapp/screens/orders_screen.dart';
import 'package:unWrapp/screens/edit_album_screen.dart';
import 'package:unWrapp/screens/LoginFormWithValidation.dart';
import 'package:unWrapp/screens/navigation_home_screen.dart';
import 'package:unWrapp/screens/templates_selection_screen.dart';
import 'package:unWrapp/screens/colors_selection_screen.dart';
import 'package:unWrapp/screens/fonts_selection_screen.dart';
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
  ]).then((_) => runApp(MyApp()));
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
        ChangeNotifierProxyProvider<Auth, Albums>(
          create: null,
          update: (context, auth, previousProducts) => Albums(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (context, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'unWrapp',
          debugShowCheckedModeBanner: false,
          navigatorKey: key,
          theme: ThemeData(
            //platform: TargetPlatform.android,
            // ef4f4f
            // ee9595
            // ffcda3
            // 74c7b8
            primarySwatch: Colors.red,
            backgroundColor: Colors.white,
            primaryColor: Color.fromRGBO(244, 67, 54, 1),
            primaryColorLight: Color.fromRGBO(255, 205, 210, 1),
            primaryColorDark: Color.fromRGBO(211, 47, 47, 1),
            accentColor: Color.fromRGBO(3, 169, 244, 1),
            bottomAppBarColor: Color.fromRGBO(189, 189, 189, 1),
            canvasColor: Colors.white,
            //canvasColor: Color.fromRGBO(255, 254, 229, 1),
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
          ),
          home: auth.isAuth
              ? NavigationTemplatesScreen()

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
            LoginFormValidation.routeName: (context) => LoginFormValidation(),
            CodeScreen.routeName: (context) => CodeScreen(),
            // LoginScreen.routeName: (context) => LoginScreen(),
            // RegistrationScreen.routeName: (context) => RegistrationScreen(),
            NavigationHomeScreen.routeName: (context) => NavigationHomeScreen(),
            NavigationTemplatesScreen.routeName: (context) =>
                NavigationTemplatesScreen(),
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
