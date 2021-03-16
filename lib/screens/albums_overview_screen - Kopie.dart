import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unwrapp/providers/albums.dart';
import 'package:unwrapp/widgets/app_drawer.dart';

class AlbumsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-overview';

  @override
  _AlbumsOverviewScreenState createState() => _AlbumsOverviewScreenState();
}

class _AlbumsOverviewScreenState extends State<AlbumsOverviewScreen> {
  var _isInit = true;
  var _isLoading = false;
  String _selectedTabTitle;
  final _titleController = TextEditingController();

  @override
  void initState() {
    // Provider.of<Albums>(context).fetchAndSetAlbums(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Albums>(context).fetchAndSetAlbums();
    // });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Albums>(context).fetchAndSetOrders().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // void _changeTabTitle(String title) {
  //   setState(() {
  //     _selectedTabTitle = title;
  //   });
  // }

  void _submitData() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty) {
      return;
    }
    setState(() {
      _selectedTabTitle = enteredTitle;
    });
    Navigator.of(context).pop();
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                    onSubmitted: (_) => _submitData(),
                    // onChanged: (val) {
                    //   titleInput = val;
                    // },
                  ),
                ],
              ),
            ),
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _selectedTabTitle = 'title';
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedTabTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: SpinKitDoubleBounce(
                color: Colors.white,
                size: 100.0,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('appbackgroundpic'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                ),
              ),
              child: null),
    );
  }
}
