import 'package:flutter/material.dart';
// import 'package:unWrapp/screens/albums_overview_screen.dart';
// import 'package:unWrapp/models/templatelist.dart';

class TemplateItem extends StatelessWidget {
  final String id;
  final String title;
  final String appbackgroundpic;
  final String tempbuttonimage;
  final Color appbackgroundcolor;
  final String appbackgroundcolorname;

  TemplateItem(this.id, this.title, this.appbackgroundpic, this.tempbuttonimage,
      this.appbackgroundcolor, this.appbackgroundcolorname);

  void selectCategory(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      elevation: 5.0,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              tempbuttonimage,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.all(10),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => selectCategory(context),
                splashColor: Color.fromRGBO(255, 255, 255, 0.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
