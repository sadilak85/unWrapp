import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:unwrapp/screens/orders_screen.dart';
import 'package:unwrapp/providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Templates Home',
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.headline3.fontFamily,
                color: Theme.of(context).textTheme.headline3.color,
                fontSize: Theme.of(context).textTheme.headline3.fontSize,
                fontWeight: Theme.of(context).textTheme.headline3.fontWeight,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              'Your Apps',
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.headline3.fontFamily,
                color: Theme.of(context).textTheme.headline3.color,
                fontSize: Theme.of(context).textTheme.headline3.fontSize,
                fontWeight: Theme.of(context).textTheme.headline3.fontWeight,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Manage Albums',
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.headline3.fontFamily,
                color: Theme.of(context).textTheme.headline3.color,
                fontSize: Theme.of(context).textTheme.headline3.fontSize,
                fontWeight: Theme.of(context).textTheme.headline3.fontWeight,
              ),
            ),
            onTap: null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.headline3.fontFamily,
                color: Theme.of(context).textTheme.headline3.color,
                fontSize: Theme.of(context).textTheme.headline3.fontSize,
                fontWeight: Theme.of(context).textTheme.headline3.fontWeight,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');

              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
