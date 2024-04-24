import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> item) {
    cart.add(item);
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> item) {
    cart.remove(item);
    notifyListeners();
  }
}
