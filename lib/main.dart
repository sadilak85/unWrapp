import 'package:unWrapp/screens/templates_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './helpers/custom_route.dart';
import './providers/albums.dart';
import './providers/orders.dart';
import './providers/auth.dart';

import './screens/splash_screen.dart';
import './screens/albums_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/orders_screen.dart';
import './screens/edit_product_screen.dart';

// import './screens/welcome_screen.dart';
// import './screens/login_screen.dart';
// import './screens/registration_screen.dart';

import './widgets/LoginFormWithValidation.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// void main() => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'unWrapp',
          debugShowCheckedModeBanner: false,
          navigatorKey: key,
          theme: ThemeData(
            backgroundColor: Colors.red[300],
            primaryColor: Colors.red,
            primaryColorLight: Colors.red[400],
            primaryColorDark: Colors.red[800],
            accentColor: Colors.pink,
            bottomAppBarColor: Color.fromRGBO(52, 52, 52, 1),
            canvasColor: Colors.white,
            //canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Lato',
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline1: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  headline2: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  headline3: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto',
                  ),
                  headline4: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Anton',
                  ),
                  headline5: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto',
                  ),
                ),
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
          ),
          home: auth.isAuth
              ? TemplatesOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : LoginFormValidation(),
                ),
          routes: {
            LoginFormValidation.routeName: (ctx) => LoginFormValidation(),
            // LoginScreen.routeName: (ctx) => LoginScreen(),
            // RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
            TemplatesOverviewScreen.routeName: (ctx) =>
                TemplatesOverviewScreen(),
            AlbumsOverviewScreen.routeName: (ctx) => AlbumsOverviewScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
