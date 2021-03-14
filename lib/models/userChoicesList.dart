import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:unwrapp/models/colorpalette.dart';

class UserChoicesList {
  final String appBartitle;
  final String appbackgroundpic;
  final String appbackgroundcolorname;
  final AppLayout apptypeindex;
  final String tempbuttonimage;
  final String celebrationtitle;
  final CelebrationType celebrationtype;
  UserColorPalette usercolorpalette;
  String userselectedfont;

  UserChoicesList({
    @required this.appBartitle,
    @required this.appbackgroundpic,
    @required this.appbackgroundcolorname,
    @required this.apptypeindex,
    @required this.tempbuttonimage,
    @required this.celebrationtitle,
    @required this.celebrationtype,
    @required this.usercolorpalette,
    @required this.userselectedfont,
  });

  static List<UserChoicesList> templateList = [
    UserChoicesList(
      appBartitle: "Valentine's App",
      appbackgroundpic:
          'https://images.pexels.com/photos/704748/pexels-photo-704748.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      appbackgroundcolorname: 'red',
      apptypeindex: AppLayout.Traveltype,
      celebrationtitle: "Valentine's day",
      tempbuttonimage:
          'https://images.pexels.com/photos/4065880/pexels-photo-4065880.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
      celebrationtype: CelebrationType.Valentine,
      usercolorpalette: UserColorPalette.colorPaletteList[0],
      userselectedfont: 'Roboto',
    ),
    UserChoicesList(
      appBartitle: "Birthday App",
      appbackgroundpic:
          'https://www.iihs.org/media/3750e123-dbe4-4e00-8df2-8c4c054c7b60/5shZNw/Ratings/About%20our%20tests/BioRID.jpg',
      appbackgroundcolorname: 'yellow',
      apptypeindex: AppLayout.Traveltype,
      celebrationtitle: 'Birthday',
      tempbuttonimage:
          'https://cdn.pixabay.com/photo/2016/02/18/22/18/birthday-1208233_1280.jpg',
      celebrationtype: CelebrationType.Birthday,
      usercolorpalette: UserColorPalette.colorPaletteList[0],
      userselectedfont: 'Roboto',
    ),
    UserChoicesList(
      appBartitle: "Mother's App",
      appbackgroundpic:
          'https://images.pexels.com/photos/776635/pexels-photo-776635.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      appbackgroundcolorname: 'green',
      apptypeindex: AppLayout.Traveltype,
      celebrationtitle: "Mother's day",
      tempbuttonimage:
          'https://images.pexels.com/photos/867462/pexels-photo-867462.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      celebrationtype: CelebrationType.Mother,
      usercolorpalette: UserColorPalette.colorPaletteList[0],
      userselectedfont: 'Roboto',
    ),
    UserChoicesList(
      appBartitle: "Father's App",
      appbackgroundpic:
          'https://images.pexels.com/photos/4618653/pexels-photo-4618653.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      appbackgroundcolorname: 'blue',
      apptypeindex: AppLayout.Traveltype,
      celebrationtitle: "Father's day",
      tempbuttonimage:
          'https://images.pexels.com/photos/2312124/pexels-photo-2312124.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      celebrationtype: CelebrationType.Father,
      usercolorpalette: UserColorPalette.colorPaletteList[0],
      userselectedfont: 'Roboto',
    ),
    UserChoicesList(
      appBartitle: "Teacher's App",
      appbackgroundpic:
          'https://www.iihs.org/media/3750e123-dbe4-4e00-8df2-8c4c054c7b60/5shZNw/Ratings/About%20our%20tests/BioRID.jpg',
      appbackgroundcolorname: 'cyan',
      apptypeindex: AppLayout.Traveltype,
      celebrationtitle: "Teachers' day",
      tempbuttonimage:
          'https://cdn.pixabay.com/photo/2017/01/09/02/02/pink-wine-1964457_1280.jpg',
      celebrationtype: CelebrationType.Teacher,
      usercolorpalette: UserColorPalette.colorPaletteList[0],
      userselectedfont: 'Roboto',
    ),
    UserChoicesList(
      appBartitle: "Anniversary's App",
      appbackgroundpic:
          'https://www.iihs.org/media/3750e123-dbe4-4e00-8df2-8c4c054c7b60/5shZNw/Ratings/About%20our%20tests/BioRID.jpg',
      appbackgroundcolorname: 'purple',
      apptypeindex: AppLayout.Traveltype,
      celebrationtitle: "Anniversary",
      tempbuttonimage:
          'https://cdn.pixabay.com/photo/2017/01/09/02/02/pink-wine-1964457_1280.jpg',
      celebrationtype: CelebrationType.Anniversary,
      usercolorpalette: UserColorPalette.colorPaletteList[0],
      userselectedfont: 'Roboto',
    ),
    UserChoicesList(
      appBartitle: "Proposal's App",
      appbackgroundpic:
          'https://www.iihs.org/media/3750e123-dbe4-4e00-8df2-8c4c054c7b60/5shZNw/Ratings/About%20our%20tests/BioRID.jpg',
      appbackgroundcolorname: 'pink',
      apptypeindex: AppLayout.Traveltype,
      celebrationtitle: "Proposal",
      tempbuttonimage:
          'https://cdn.pixabay.com/photo/2017/01/09/02/02/pink-wine-1964457_1280.jpg',
      celebrationtype: CelebrationType.Proposal,
      usercolorpalette: UserColorPalette.colorPaletteList[0],
      userselectedfont: 'Roboto',
    ),
    UserChoicesList(
      appBartitle: "My Creative App",
      appbackgroundpic:
          'https://www.iihs.org/media/3750e123-dbe4-4e00-8df2-8c4c054c7b60/5shZNw/Ratings/About%20our%20tests/BioRID.jpg',
      appbackgroundcolorname: 'white',
      apptypeindex: AppLayout.Traveltype,
      celebrationtitle: "Create a design",
      tempbuttonimage:
          'https://cdn.pixabay.com/photo/2017/03/12/13/41/beaded-2137080_1280.jpg',
      celebrationtype: CelebrationType.Create,
      usercolorpalette: UserColorPalette.colorPaletteList[0],
      userselectedfont: 'Roboto',
    ),
  ];
}

enum AppLayout {
  Traveltype,
  Coursetype,
  Fitnesstype,
}

enum CelebrationType {
  Valentine,
  Birthday,
  Mother,
  Father,
  Teacher,
  Anniversary,
  Proposal,
  Create,
}
