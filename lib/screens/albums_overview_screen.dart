import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unwrapp/widgets/app_drawer.dart';
import 'package:unwrapp/models/userChoicesList.dart';

class AlbumsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-overview';

  @override
  _AlbumsOverviewScreenState createState() => _AlbumsOverviewScreenState();
}

class _AlbumsOverviewScreenState extends State<AlbumsOverviewScreen> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference _collection =
        FirebaseFirestore.instance.collection('templates');

    final UserChoicesList userchoiceargs =
        ModalRoute.of(context).settings.arguments;
    print(userchoiceargs.appBartitle);
    print(userchoiceargs.appbackgroundcolorname);
    print(userchoiceargs.appbackgroundpic);
    print(userchoiceargs.apptypeindex);
    print(userchoiceargs.celebrationtitle);
    print(userchoiceargs.celebrationtype);
    print(userchoiceargs.tempbuttonimage);
    print(userchoiceargs.usercolorpalette.appbackgroundcolorpalette);
    print(userchoiceargs.userselectedfont);

    String _selectedTabTitle = userchoiceargs.appBartitle.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedTabTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: null,
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
                  itemCount: 1, itemBuilder: (context, index) => null,

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
