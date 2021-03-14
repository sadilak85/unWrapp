import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unwrapp/helpers/app_theme.dart';
import 'package:unwrapp/custom_drawer/drawer_user_controller.dart';
import 'package:unwrapp/custom_drawer/home_drawer.dart';
import 'package:unwrapp/screens/fonts_selection_screen.dart';
import 'package:unwrapp/screens/drawer_share_screen.dart';
import 'package:unwrapp/screens/drawer_contact_screen.dart';
import 'package:unwrapp/screens/drawer_help_screen.dart';
import 'package:unwrapp/screens/welcomescreen_controller.dart';
import 'package:unwrapp/providers/auth.dart';
import 'package:unwrapp/models/userChoicesList.dart';
import 'package:unwrapp/models/colorpalette.dart';

class NavigationColorsScreen extends StatefulWidget {
  static const routeName = '/colors-selection-screen';
  @override
  _NavigationColorsScreenState createState() => _NavigationColorsScreenState();
}

class _NavigationColorsScreenState extends State<NavigationColorsScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const ColorsOverviewScreen();
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
          screenView = const ColorsOverviewScreen();
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

class ColorsOverviewScreen extends StatefulWidget {
  const ColorsOverviewScreen({Key key}) : super(key: key);

  @override
  _ColorsOverviewScreenState createState() => _ColorsOverviewScreenState();
}

class _ColorsOverviewScreenState extends State<ColorsOverviewScreen>
    with TickerProviderStateMixin {
  List<UserColorPalette> colorPaletteList = UserColorPalette.colorPaletteList;
  List<UserChoicesList> templateList = UserChoicesList.templateList;

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

  void showDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 200),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300,
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.help_outline,
                        color: AppTheme.dark_grey,
                      ),
                    ),
                    Text(
                      '''\n\nSelect a color palette for your gift app. 
                      \n\nColors are great sources to express someones's feelings''',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: AppTheme.subtitle.fontFamily,
                        fontSize: 18,
                        color: AppTheme.darkText,
                        fontWeight: FontWeight.w700,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            ),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

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
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return GridView(
                            padding: const EdgeInsets.only(
                                top: 0, left: 12, right: 12),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: List<Widget>.generate(
                              colorPaletteList.length,
                              (int index) {
                                final int count = colorPaletteList.length;

                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: animationController,
                                    curve: Interval((1 / count) * index, 1.0,
                                        curve: Curves.fastOutSlowIn),
                                  ),
                                );
                                animationController.forward();
                                return ColorsListView(
                                  animation: animation,
                                  animationController: animationController,
                                  colorlistData: colorPaletteList[index],
                                  callBack: (_usercolorpalette) {
                                    userchoiceargs.usercolorpalette =
                                        _usercolorpalette;

                                    Navigator.of(context).pushNamed(
                                      NavigationFontsScreen.routeName,
                                      arguments: userchoiceargs,

                                      // UserChoicesList(
                                      //   appBartitle:
                                      //       templateList[index].appBartitle,
                                      //   appbackgroundpic: templateList[index]
                                      //       .appbackgroundpic,
                                      //   appbackgroundcolorname:
                                      //       templateList[index]
                                      //           .appbackgroundcolorname,
                                      //   apptypeindex: ModalRoute.of(context)
                                      //       .settings
                                      //       .arguments,
                                      //   tempbuttonimage:
                                      //       templateList[index].tempbuttonimage,
                                      //   celebrationtitle: templateList[index]
                                      //       .celebrationtitle,
                                      //   celebrationtype:
                                      //       templateList[index].celebrationtype,
                                      //   usercolorpalette:
                                      //       colorPaletteList[index],
                                      //   userselectedfont: templateList[index]
                                      //       .userselectedfont,
                                      // ),
                                    );

                                    // Navigator.push<dynamic>(
                                    //   context,
                                    //   MaterialPageRoute<dynamic>(
                                    //     builder: (BuildContext context) =>
                                    //         colorPaletteList[index].navigateScreen,
                                    //   ),
                                    // );
                                  },
                                );
                              },
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 20.0,
                              childAspectRatio: 1.0,
                            ),
                          );
                        }
                      },
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
                  'Your color palette',
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
                  onTap: showDialog,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorsListView extends StatelessWidget {
  const ColorsListView(
      {Key key,
      this.colorlistData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final UserColorPalette colorlistData;
  final void Function(UserColorPalette) callBack;
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
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          // colorlistData.appbackgroundcolorpalette.asMap().forEach((index, value) => f);
                          color: colorlistData.appbackgroundcolorpalette[3],
                        ),
                        AspectRatio(
                          aspectRatio: 1.15,
                          child: Container(
                            color: colorlistData.appbackgroundcolorpalette[2],
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 1.5,
                          child: Container(
                            color: colorlistData.appbackgroundcolorpalette[1],
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 2.4,
                          child: Container(
                            color: colorlistData.appbackgroundcolorpalette[0],
                          ),
                        ),
                      ],
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: () {
                          callBack(colorlistData);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
