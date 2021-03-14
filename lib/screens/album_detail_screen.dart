import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:unwrapp/models/userChoicesList.dart';
import 'package:unwrapp/providers/albums.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    var _choicesList = UserChoicesList(
      appBartitle: '',
      appbackgroundpic: '',
      appbackgroundcolorname: '',
      apptypeindex: null,
      celebrationtype: null,
    );

    final loadedProduct = Provider.of<Albums>(
      context,
      listen: false,
    ).fetchAndSetOrders();
    return Scaffold(
      appBar: AppBar(
        title: Text('komiya'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                _choicesList.appbackgroundpic,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'tello gider',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                _choicesList.appBartitle,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
