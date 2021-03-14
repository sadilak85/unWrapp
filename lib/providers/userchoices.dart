import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unwrapp/models/userChoicesList.dart';

class UserChoices with ChangeNotifier {
  final String userId;
  List<UserChoicesList> _choices = [];

  UserChoices(this.userId, this._choices);

  List<UserChoicesList> get choices {
    return [..._choices];
  }

  Future<void> fetchChoices() async {
    final List<UserChoicesList> loadedChoices = [];

    FirebaseFirestore.instance.collection('templates').get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) {
                loadedChoices.add(
                  UserChoicesList(
                    appBartitle: doc['appBartitle'],
                    appbackgroundpic: doc['appbackgroundpic'],
                    appbackgroundcolorname: doc['appbackgroundcolorname'],
                    apptypeindex: doc['apptypeindex'],
                    tempbuttonimage: doc['tempbuttonimage'],
                    celebrationtitle: doc['celebrationtitle'],
                    celebrationtype: doc['celebrationtype'],
                    usercolorpalette: doc['usercolorpalette'],
                    userselectedfont: doc['userselectedfont'],
                  ),
                );
              },
            ),
          },
        );
    _choices = loadedChoices.toList();
    notifyListeners();
  }
}
