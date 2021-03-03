import 'package:flutter/material.dart';
import 'package:unWrapp/helpers/app_theme.dart';
import 'package:unWrapp/models/templatelist.dart';
// import 'package:unWrapp/widgets/template_item.dart';
import 'package:unWrapp/custom_drawer/drawer_user_controller.dart';
import 'package:unWrapp/custom_drawer/home_drawer.dart';
import 'package:unWrapp/screens/colors_selection_screen.dart';
import 'package:unWrapp/screens/drawer_share_screen.dart';
import 'package:unWrapp/screens/drawer_about_screen.dart';
import 'package:unWrapp/screens/drawer_help_screen.dart';

class NavigationTemplatesScreen extends StatefulWidget {
  static const routeName = '/templates-selection-screen';
  @override
  _NavigationTemplatesScreenState createState() =>
      _NavigationTemplatesScreenState();
}

class _NavigationTemplatesScreenState extends State<NavigationTemplatesScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const TemplatesOverviewScreen();
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
          screenView = const TemplatesOverviewScreen();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = HelpScreen();
        });
      } else if (drawerIndex == DrawerIndex.Share) {
        setState(() {
          screenView = ShareScreen();
        });
      } else if (drawerIndex == DrawerIndex.About) {
        setState(() {
          screenView = AboutScreen();
        });
      } else {
        //do in your way......
      }
    }
  }
}

class TemplatesOverviewScreen extends StatefulWidget {
  const TemplatesOverviewScreen({Key key}) : super(key: key);

  @override
  _TemplatesOverviewScreenState createState() =>
      _TemplatesOverviewScreenState();
}

class _TemplatesOverviewScreenState extends State<TemplatesOverviewScreen>
    with TickerProviderStateMixin {
  List<AppUserChoiceList> templateList = AppUserChoiceList.templateList;

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
      transitionDuration: Duration(milliseconds: 500),
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
                      '''\n\nChoose a celebration concept for your app. 
                      \n\nAI will make it easy for you to start creation regarding your selection''',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16,
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
                              templateList.length,
                              (int index) {
                                final int count = templateList.length;
                                final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: animationController,
                                    curve: Interval((1 / count) * index, 1.0,
                                        curve: Curves.fastOutSlowIn),
                                  ),
                                );
                                animationController.forward();
                                return TemplateListView(
                                  animation: animation,
                                  animationController: animationController,
                                  listData: templateList[index],
                                  callBack: () {
                                    Navigator.of(context).pushNamed(
                                      NavigationColorsScreen.routeName,
                                    );

                                    // Navigator.push<dynamic>(
                                    //   context,
                                    //   MaterialPageRoute<dynamic>(
                                    //     builder: (BuildContext context) =>
                                    //         templateList[index].navigateScreen,
                                    //   ),
                                    // );
                                  },
                                );
                              },
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 12.0,
                              crossAxisSpacing: 12.0,
                              childAspectRatio: 1.5,
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
                  'Celebration type',
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

class TemplateListView extends StatelessWidget {
  const TemplateListView(
      {Key key,
      this.listData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final AppUserChoiceList listData;
  final VoidCallback callBack;
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
                        Image.network(
                          listData.tempbuttonimage,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              color: Colors.black45,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  listData.title,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
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
                          callBack();
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

// import 'package:flutter/material.dart';
// import 'package:unWrapp/widgets/template_item.dart';
// import 'package:unWrapp/models/template.dart';

// class TemplatesOverviewScreen extends StatelessWidget {
//   static const routeName = '/templates-overview';
//   @override
//   Widget build(BuildContext context) {
//     final _deviceSize = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context).backgroundColor,
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: OrientationBuilder(
//             builder: (context, orientation) {
//               return Padding(
//                 padding: orientation == Orientation.portrait
//                     ? EdgeInsets.only(top: 20.0)
//                     : EdgeInsets.only(top: 0.0),
//                 child: GridView(
//                   padding: const EdgeInsets.all(10),
//                   children: TEMPLATES
//                       .map(
//                         (catData) => TemplateItem(
//                           catData.id,
//                           catData.title,
//                           catData.appbackgroundpic,
//                           catData.tempbuttonimage,
//                           catData.appbackgroundcolor,
//                           catData.appbackgroundcolorname,
//                         ),
//                       )
//                       .toList(),
//                   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: orientation == Orientation.portrait
//                         ? _deviceSize.width / 2
//                         : _deviceSize.height / 2,
//                     childAspectRatio: orientation == Orientation.portrait
//                         ? _deviceSize.width / 400
//                         : _deviceSize.height / 300,
//                     crossAxisSpacing: orientation == Orientation.portrait
//                         ? _deviceSize.width / 20
//                         : _deviceSize.height / 20,
//                     mainAxisSpacing: orientation == Orientation.portrait
//                         ? _deviceSize.width / 10
//                         : _deviceSize.height / 10,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
