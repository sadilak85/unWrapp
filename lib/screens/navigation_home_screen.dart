import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unWrapp/helpers/app_theme.dart';
import 'package:unWrapp/custom_drawer/drawer_user_controller.dart';
import 'package:unWrapp/custom_drawer/home_drawer.dart';
import 'package:unWrapp/screens/home_screen.dart';
import 'package:unWrapp/screens/drawer_help_screen.dart';
import 'package:unWrapp/screens/drawer_share_screen.dart';
import 'package:unWrapp/screens/drawer_contact_screen.dart';
import 'package:unWrapp/helpers/welcomescreen_controller.dart';
import 'package:unWrapp/providers/auth.dart';

class NavigationHomeScreen extends StatefulWidget {
  static const routeName = '/navigationhome-screen';
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = const MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = HelpScreen();
        });
      } else if (drawerIndex == DrawerIndex.Share) {
        setState(() {
          screenView = ShareScreen();
        });
      } else if (drawerIndex == DrawerIndex.Contact) {
        setState(() {
          screenView = ContactScreen();
        });
      } else if (drawerIndex == DrawerIndex.Logout) {
        Navigator.of(context).pushNamed(WelcomeScreen.routeName);
        Provider.of<Auth>(context, listen: false).logout();
      } else {
        //do in your way......
      }
    }
  }
}
