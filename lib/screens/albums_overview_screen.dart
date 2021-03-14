import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:unwrapp/widgets/app_drawer.dart';
import 'package:unwrapp/models/userChoicesList.dart';
import 'package:unwrapp/providers/themedata.dart';
import 'package:unwrapp/helpers/showdialogbox.dart';

class AlbumsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-overview';

  @override
  _AlbumsOverviewScreenState createState() => _AlbumsOverviewScreenState();
}

class _AlbumsOverviewScreenState extends State<AlbumsOverviewScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  // bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  bool creator = true;
  Color currentColor = Colors.red;
  String _selectedTabTitle;
  bool _initial = true;
  String _textboxmessage = '''\n\nChoose a celebration concept for your app. 
                      \n\nAI will make it easy for you to start creation regarding your selection''';

  @override
  Widget build(BuildContext context) {
    CollectionReference _collection =
        FirebaseFirestore.instance.collection('templates');

    final UserChoicesList userchoiceargs =
        ModalRoute.of(context).settings.arguments;

    // Color currentColor =
    //     userchoiceargs.usercolorpalette.appbackgroundcolorpalette[0];

    print(userchoiceargs.appBartitle);
    print(userchoiceargs.appbackgroundcolorname);
    print(userchoiceargs.appbackgroundpic);
    print(userchoiceargs.apptypeindex);
    print(userchoiceargs.celebrationtitle);
    print(userchoiceargs.celebrationtype);
    print(userchoiceargs.tempbuttonimage);
    print(userchoiceargs.usercolorpalette.appbackgroundcolorpalette);
    print(userchoiceargs.userselectedfont);

    if (_initial) {
      _selectedTabTitle = userchoiceargs.appBartitle.toString();
      _initial = !_initial;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Provider.of<ThemeModel>(context, listen: false).primarycolor,

        title: creator
            ? GestureDetector(
                onTap: () => {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Enter your main title'),
                        content: TextField(
                          onChanged: (value) {
                            setState(() => _selectedTabTitle = value);
                          },
                          decoration:
                              InputDecoration(hintText: "Type your title"),
                        ),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Provider.of<ThemeModel>(context,
                                      listen: false)
                                  .primarycolor,
                            ),
                            child: Text('OK'),
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),
                },

                //setState(() => _selectedTabTitle = "teketek")},
                child: Container(
                  child: Text(_selectedTabTitle),
                ),
              )
            : Text(userchoiceargs.appBartitle.toString()),

        //title: Text(_selectedTabTitle),
        actions: creator
            ? <Widget>[
                // TextField(
                //           textAlign: TextAlign.center,
                //           decoration: InputDecoration(
                //             border: OutlineInputBorder(
                //               borderRadius: const BorderRadius.all(
                //                 Radius.circular(5),
                //               ),
                //             ),
                //             hintText: 'Change title',
                //           ),
                //           onChanged: (value) {
                //             setState(() => _selectedTabTitle = value);
                //           },
                //         ),

                IconButton(
                  icon: Icon(
                    Icons.palette,
                    color: creator
                        ? Provider.of<ThemeModel>(context, listen: false)
                            .accentcolor
                        : Provider.of<ThemeModel>(context, listen: false)
                            .primarycolor,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select a color'),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: currentColor,
                              onColorChanged: (Color value) {
                                Provider.of<ThemeModel>(context, listen: false)
                                    .primarycolor = value;

                                setState(() => currentColor = value);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ]
            : null,
      ),
      drawer: AppDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _collection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Column(
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
                Text("Something went wrong"),
              ],
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
                Text("Loading"),
              ],
            );
          }

          final templateDocs = snapshot.data.docs;
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) =>
                      Center(child: Text('Press the button below!')),

                  //   UserChoicesList(
                  //   appBartitle:templateDocs[index].data()['appBartitle'],
                  //   appbackgroundpic: templateDocs[index].data()['appbackgroundpic'],
                  //   appbackgroundcolorname: templateDocs[index].data()['appbackgroundcolorname'],
                  //   apptypeindex: templateDocs[index].data()['apptypeindex'],
                  //   tempbuttonimage: templateDocs[index].data()['tempbuttonimage'],
                  //   celebrationtitle: templateDocs[index].data()['celebrationtitle'],
                  //   celebrationtype: templateDocs[index].data()['celebrationtype'],
                  //   usercolorpalette: templateDocs[index].data()['usercolorpalette'],
                  //   userselectedfont: templateDocs[index].data()['userselectedfont'],
                  // ),
                );
        },
      ),
      floatingActionButton: creator
          ? FloatingActionButton(
              onPressed: () => showDialogmenu(context, _textboxmessage),
              child: Icon(Icons.add,
                  color: Provider.of<ThemeModel>(context, listen: false)
                      .accentcolor),
              backgroundColor:
                  Provider.of<ThemeModel>(context, listen: false).primarycolor,
            )
          : null,
    );
  }
}
