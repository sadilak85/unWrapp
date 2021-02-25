import 'package:flutter/material.dart';
import '../screens/albums_overview_screen.dart';
import '../models/template.dart';

class TemplateItem extends StatelessWidget {
  final String id;
  final String title;
  final String templatebackground;
  final String buttonimage;

  TemplateItem(this.id, this.title, this.templatebackground, this.buttonimage);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      AlbumsOverviewScreen.routeName,
      arguments: ScreenArguments(
        id,
        title,
        templatebackground,
      ),
    );

    // Navigator.of(ctx).pushNamed(
    //   CategoryMealsScreen.routeName,
    //   arguments: {
    //     'id': id,
    //     'title': title,
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      elevation: 10.0,
      child: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  buttonimage,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                bottom: 15,
                top: 80,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline2,
                    softWrap: true,
                    overflow: TextOverflow.fade,
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
          );
        },
      ),
    );
  }
}
