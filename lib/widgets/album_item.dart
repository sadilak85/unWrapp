import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:unwrapp/screens/album_detail_screen.dart';
import 'package:unwrapp/providers/userchoices.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<UserChoices>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              // arguments: product.userFontname,
            );
          },
          child: Image.network(
            null,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          // leading: Consumer<Album>(
          //   builder: (context, product, _) => IconButton(
          //     icon: Icon(
          //       Icons.favorite,
          //     ),
          //     color: Theme.of(context).accentColor,
          //     onPressed: null,
          //   ),
          // ),
          title: Text(
            '',
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: null,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
