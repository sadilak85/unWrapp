// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:unWrapp/helpers/operations.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final String layoutType;
  final String celebrationType;
  final String colorPalette;
  final String fontStyle;
  ProductItem({
    @required this.layoutType,
    @required this.celebrationType,
    @required this.colorPalette,
    @required this.fontStyle,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.layoutType ?? 'defaultlayoutvalue',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.celebrationType ?? 'defaultFontvalue',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.colorPalette ?? 'defaultColorvalue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.fontStyle ?? 'defaultvalue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
      ),
    );
  }
}
