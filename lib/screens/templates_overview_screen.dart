import 'package:flutter/material.dart';
import '../widgets/template_item.dart';
import '../models/template.dart';

class TemplatesOverviewScreen extends StatelessWidget {
  static const routeName = '/templates-overview';
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: OrientationBuilder(
              builder: (context, orientation) {
                return GridView(
                  padding: const EdgeInsets.all(10),
                  children: TEMPLATES
                      .map(
                        (catData) => TemplateItem(
                          catData.id,
                          catData.title,
                          catData.templatebackground,
                          catData.buttonimage,
                        ),
                      )
                      .toList(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: orientation == Orientation.portrait
                        ? _deviceSize.width / 2
                        : _deviceSize.height / 2,
                    childAspectRatio: orientation == Orientation.portrait
                        ? _deviceSize.width / 400
                        : _deviceSize.height / 300,
                    crossAxisSpacing: orientation == Orientation.portrait
                        ? _deviceSize.width / 20
                        : _deviceSize.height / 20,
                    mainAxisSpacing: orientation == Orientation.portrait
                        ? _deviceSize.width / 10
                        : _deviceSize.height / 10,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
