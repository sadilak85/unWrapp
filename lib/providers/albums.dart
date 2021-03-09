import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:unWrapp/main.dart';
import 'package:unWrapp/providers/auth.dart';
import 'package:unWrapp/models/http_exception.dart';
import 'package:unWrapp/providers/album.dart';

class Albums with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<Album> _items = [];
  final String userId;

  Albums(this.userId, this._items);

  List<Album> get items {
    return [..._items];
  }

  Album findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  final databaseRef =
      FirebaseDatabase.instance.reference(); //database reference object

  final databaseReference =
      FirebaseDatabase.instance.reference().child('templates');

  Future<void> fetchAndSetAlbums([bool filterByUser = false]) async {
    final List<Album> loadedProducts = [];
    try {
      final extractedData = _firestore.collection('templates').snapshots();
      if (extractedData == null) {
        return;
      }

      await for (var snapshot
          in _firestore.collection('templates').snapshots()) {
        for (var template in snapshot.docs) {
          loadedProducts.add(Album(
            id: template.data()['id'],
            title: template.data()['title'],
            appbackgroundcolorname: template.data()['appbackgroundcolorname'],
            appbackgroundpic: template.data()['appbackgroundpic'],
          ));
        }
      }

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      navigatorKey.currentState.pop();
      navigatorKey.currentState.pushReplacementNamed('/');

      Provider.of<Auth>(navigatorKey.currentContext, listen: false).logout();
    }
  }

  Future<void> addProduct(Album product) async {
    try {
      _firestore.collection('templates').add({
        'id': product.id,
        'title': product.title,
        'appbackgroundpic': product.appbackgroundpic,
        'appbackgroundcolorname': product.appbackgroundcolorname,
      });

      final newProduct = Album(
        id: product.id,
        title: product.title,
        appbackgroundcolorname: product.appbackgroundcolorname,
        appbackgroundpic: product.appbackgroundpic,
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Album newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://unwrapp-58927-default-rtdb.firebaseio.com/products/$id.json?auth=';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'appbackgroundcolorname': newProduct.appbackgroundcolorname,
            'appbackgroundpic': newProduct.appbackgroundpic,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://unwrapp-58927-default-rtdb.firebaseio.com/products/$id.json?auth=';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
