import 'package:flutter/material.dart';

const TEMPLATES = const [
  Template(
    id: 'c1',
    title: "Valentine's day",
    tempbackgroundpic:
        'https://images.pexels.com/photos/704748/pexels-photo-704748.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    tempbuttonimage:
        'https://images.pexels.com/photos/6478949/pexels-photo-6478949.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    tempbackgroundcolor: Colors.red,
    backgroundcolorname: 'red',
  ),
  Template(
    id: 'c2',
    title: 'Birthday',
    tempbackgroundpic:
        'https://www.iihs.org/media/3750e123-dbe4-4e00-8df2-8c4c054c7b60/5shZNw/Ratings/About%20our%20tests/BioRID.jpg',
    tempbuttonimage:
        'https://cdn.pixabay.com/photo/2014/06/30/11/40/birthday-cake-380178_1280.jpg',
    tempbackgroundcolor: Colors.yellow,
    backgroundcolorname: 'yellow',
  ),
  Template(
    id: 'c3',
    title: "Mother's day",
    tempbackgroundpic:
        'https://images.pexels.com/photos/776635/pexels-photo-776635.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    tempbuttonimage:
        'https://images.pexels.com/photos/867462/pexels-photo-867462.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    tempbackgroundcolor: Colors.green,
    backgroundcolorname: 'green',
  ),
  Template(
    id: 'c4',
    title: "Father's day",
    tempbackgroundpic:
        'https://images.pexels.com/photos/4618653/pexels-photo-4618653.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    tempbuttonimage:
        'https://images.pexels.com/photos/2312124/pexels-photo-2312124.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    tempbackgroundcolor: Colors.blue,
    backgroundcolorname: 'blue',
  ),
  Template(
    id: 'c5',
    title: "Anniversary",
    tempbackgroundpic:
        'https://www.iihs.org/media/3750e123-dbe4-4e00-8df2-8c4c054c7b60/5shZNw/Ratings/About%20our%20tests/BioRID.jpg',
    tempbuttonimage:
        'https://cdn.pixabay.com/photo/2017/01/09/02/02/pink-wine-1964457_1280.jpg',
    tempbackgroundcolor: Colors.pink,
    backgroundcolorname: 'pink',
  ),
  Template(
    id: 'c6',
    title: "Create a design",
    tempbackgroundpic:
        'https://www.iihs.org/media/3750e123-dbe4-4e00-8df2-8c4c054c7b60/5shZNw/Ratings/About%20our%20tests/BioRID.jpg',
    tempbuttonimage:
        'https://cdn.pixabay.com/photo/2017/03/12/13/41/beaded-2137080_1280.jpg',
    tempbackgroundcolor: Colors.white,
    backgroundcolorname: 'white',
  ),
];

class Template {
  final String id;
  final String title;
  final String tempbackgroundpic;
  final String tempbuttonimage;
  final Color tempbackgroundcolor;
  final String backgroundcolorname;

  const Template({
    @required this.id,
    @required this.title,
    @required this.tempbackgroundpic,
    @required this.tempbuttonimage,
    @required this.tempbackgroundcolor,
    @required this.backgroundcolorname,
  });
}

class ScreenArguments {
  final String id;
  final String title;
  final String tempbackgroundpic;
  final String backgroundcolorname;

  ScreenArguments(
      this.id, this.title, this.tempbackgroundpic, this.backgroundcolorname);
}
