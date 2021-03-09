import 'package:flutter/material.dart';
import 'dart:convert';
//import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _userId;

  bool get isAuth {
    if (_auth.currentUser?.uid == null) {
      print('dead auth');
      print(_auth.currentUser);
      return false;
    } else {
      print('already auth');
      print(_auth.currentUser);
      return true;
    }
  }

  String get userId {
    return _userId;
  }

  Future<String> handleSignInEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user;

      _userId = _auth.currentUser.uid;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'userId': _userId,
          'email': user.email,
        },
      );
      prefs.setString('userData', userData);
      return null;
    } on FirebaseAuthException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('firebase_auth/wrong-password')) {
        errorMessage = 'The password is invalid.';
      } else if (error.toString().contains('firebase_auth/invalid-email')) {
        errorMessage = 'The email address is badly formatted.';
      } else if (error.toString().contains('firebase_auth/user-not-found')) {
        errorMessage =
            'There is no user record corresponding to this identifier. The user may have been deleted.';
      }
      return errorMessage;
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      return errorMessage;
    }
  }

  Future<String> handleSignUp(email, password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user;

      _userId = _auth.currentUser.uid;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'userId': _userId,
          'email': user.email,
        },
      );
      prefs.setString('userData', userData);
      return null;
    } on FirebaseAuthException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('firebase_auth/invalid-email')) {
        errorMessage = 'The email address is badly formatted.';
      } else if (error
          .toString()
          .contains('firebase_auth/email-already-in-use')) {
        errorMessage =
            'The email address is already in use by another account.';
      }
      return errorMessage;
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      return errorMessage;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _userId = extractedUserData['userId'];
    notifyListeners();

    return true;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _userId = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
