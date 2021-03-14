import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:unwrapp/providers/album.dart';

class OrderItem {
  final String id;
  final double amount;

  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
  });
}

class Albums with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Albums(this.authToken, this.userId, this._orders);

  List<OrderItem> get albums {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://unwrapp-58927-default-rtdb.firebaseio.com/albums/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addProduct(Album product) async {
    final url =
        'https://dayanio-98e6f-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId,
        }),
      );
      final newProduct = Album(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _orders.add(null);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Album newProduct) async {
    final prodIndex = _orders.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://dayanio-98e6f-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _orders[prodIndex] = null;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://dayanio-98e6f-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _orders.indexWhere((prod) => prod.id == id);
    var existingProduct = _orders[existingProductIndex];
    _orders.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _orders.insert(existingProductIndex, existingProduct);
      notifyListeners();
    }
    existingProduct = null;
  }
}
