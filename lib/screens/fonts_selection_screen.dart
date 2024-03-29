import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unwrapp/helpers/app_theme.dart';
import 'package:unwrapp/custom_drawer/drawer_user_controller.dart';
import 'package:unwrapp/custom_drawer/home_drawer.dart';
import 'package:unwrapp/screens/albums_overview_screen.dart';
import 'package:unwrapp/screens/drawer_help_screen.dart';
import 'package:unwrapp/screens/drawer_share_screen.dart';
import 'package:unwrapp/screens/drawer_contact_screen.dart';
import 'package:unwrapp/screens/welcomescreen_controller.dart';
import 'package:unwrapp/providers/auth.dart';
import 'package:unwrapp/models/fontslist.dart';
import 'package:unwrapp/models/userChoicesList.dart';
import 'package:unwrapp/helpers/showdialogbox.dart';

class NavigationFontsScreen extends StatefulWidget {
  static const routeName = '/fonts-selection-screen';
  @override
  _NavigationFontsScreenState createState() => _NavigationFontsScreenState();
}

class _NavigationFontsScreenState extends State<NavigationFontsScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const FontsOverviewScreen();
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
          screenView = const FontsOverviewScreen();
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

class FontsOverviewScreen extends StatefulWidget {
  const FontsOverviewScreen({Key key}) : super(key: key);

  @override
  _FontsOverviewScreenState createState() => _FontsOverviewScreenState();
}

class _FontsOverviewScreenState extends State<FontsOverviewScreen>
    with TickerProviderStateMixin {
  List<String> userFontsList = UserSelectionFonts.userFontsList;

  AnimationController animationController;
  // bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  String _textboxmessage =
      '''\n\nSelect a layout of your gift app before starting to create it. 
                      \n\nTap to open detailed view then click check icon to confirm.''';

  @override
  Widget build(BuildContext context) {
    final UserChoicesList userchoiceargs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  Expanded(
                    child: GridView(
                      padding:
                          const EdgeInsets.only(top: 10, left: 25, right: 25),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: List<Widget>.generate(
                        userFontsList.length,
                        (int index) {
                          final int count = userFontsList.length;

                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn),
                            ),
                          );
                          animationController.forward();
                          return FontsListView(
                            animation: animation,
                            animationController: animationController,
                            fontslistData: userFontsList[index],
                            callBack: (_userfont) {
                              userchoiceargs.userselectedfont = _userfont;

                              Navigator.of(context).pushNamed(
                                AlbumsOverviewScreen.routeName,
                                arguments: userchoiceargs,
                              );

                              // Navigator.push<dynamic>(
                              //   context,
                              //   MaterialPageRoute<dynamic>(
                              //     builder: (BuildContext context) =>
                              //         userFontsList[index].navigateScreen,
                              //   ),
                              // );
                            },
                          );
                        },
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        childAspectRatio: 2,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Your font style',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    Icons.help_outline,
                    color: AppTheme.dark_grey,
                  ),
                  onTap: () => showDialogmenu(context, _textboxmessage),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FontsListView extends StatelessWidget {
  const FontsListView(
      {Key key,
      this.fontslistData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final String fontslistData;
  final void Function(String) callBack;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: AspectRatio(
              aspectRatio: 2,
              child: Container(
                color: Colors.red.shade100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.grey.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          onTap: () {
                            callBack(fontslistData);
                          },
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Fonts have also feelings',
                            style: GoogleFonts.getFont(
                              fontslistData,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            'Fonts have also feelings',
                            style: GoogleFonts.getFont(
                              fontslistData,
                              fontSize: 22,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            'Fonts have also feelings',
                            style: GoogleFonts.getFont(
                              fontslistData,
                              fontSize: 22,
                              fontStyle: FontStyle.italic,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
