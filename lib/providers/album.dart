import 'package:flutter/foundation.dart';

class Album with ChangeNotifier {
  final String id;
  final String title;
  final String appbackgroundcolorname;
  final String appbackgroundpic;

  Album({
    @required this.id,
    @required this.title,
    @required this.appbackgroundcolorname,
    @required this.appbackgroundpic,
  });
}
