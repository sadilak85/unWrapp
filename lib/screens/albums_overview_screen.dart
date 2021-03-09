import 'package:flutter/material.dart';
import 'package:unWrapp/widgets/app_drawer.dart';
import 'package:unWrapp/models/templatelist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unWrapp/widgets/productItem.dart';

class AlbumsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-overview';

  @override
  _AlbumsOverviewScreenState createState() => _AlbumsOverviewScreenState();
}

class _AlbumsOverviewScreenState extends State<AlbumsOverviewScreen> {
  var _isLoading = false;
  String _selectedTabTitle;

  Future<void> uploadingData(String _id, String _title,
      String _appbackgroundcolorname, String _appbackgroundpic) async {
    await FirebaseFirestore.instance.collection("templates").add({
      'id': _id,
      'title': _title,
      'appbackgroundcolorname': _appbackgroundcolorname,
      'appbackgroundpic': _appbackgroundpic,
    });
  }

  Future<void> getData() async {
    print('ssdfah');
    FirebaseFirestore.instance
        .collection('templates')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(doc["layoutType"]);
              }),
            });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference _collection =
        FirebaseFirestore.instance.collection('templates');

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    _selectedTabTitle = args.userchoices['title'];
    return Scaffold(
      appBar: AppBar(
        title: Text('_selectedTabTitle'),
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
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          final templateDocs = snapshot.data.docs;
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => ProductItem(
                    layoutType: templateDocs[index].data()['layoutType'],
                    fontStyle: templateDocs[index].data()['fontStyle'],
                    celebrationType:
                        templateDocs[index].data()['celebrationType'],
                    colorPalette: templateDocs[index].data()['colorPalette'],
                  ),
                );
        },
      ),
    );
  }
}
