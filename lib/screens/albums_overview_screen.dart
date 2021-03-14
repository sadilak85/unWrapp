import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unwrapp/widgets/app_drawer.dart';
import 'package:unwrapp/models/userChoicesList.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:unwrapp/providers/themedata.dart';
import 'package:provider/provider.dart';

class AlbumsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-overview';

  @override
  _AlbumsOverviewScreenState createState() => _AlbumsOverviewScreenState();
}

class _AlbumsOverviewScreenState extends State<AlbumsOverviewScreen> {
  var _isLoading = false;
  bool creator = true;
  Color currentColor = Colors.yellow;
  String _selectedTabTitle = 'val';

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

    // String _selectedTabTitle = userchoiceargs.appBartitle.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeModel>(context).primarycolor,

        title: GestureDetector(
          onTap: () => {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('TextField in Dialog'),
                  content: TextField(
                    onChanged: (value) {
                      setState(() => _selectedTabTitle = value);
                    },
                    decoration:
                        InputDecoration(hintText: "Text Field in Dialog"),
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor:
                            Provider.of<ThemeModel>(context).primarycolor,
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
        ),

        //title: Text(_selectedTabTitle),
        actions: <Widget>[
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
                  ? Provider.of<ThemeModel>(context).accentcolor
                  : Provider.of<ThemeModel>(context).primarycolor,
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
        ],
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
                  itemBuilder: (context, index) => Center(
                    child: Text('baka'),
                  ),

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
    );
  }
}
