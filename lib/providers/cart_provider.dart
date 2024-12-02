import 'package:flutter/material.dart';
import '../models/food_item.dart';

class CartProvider extends ChangeNotifier {
  Map<String, FoodItem> _cartItems = {};

  Map<String, FoodItem> get cartItems => _cartItems;

  double get totalPrice => _cartItems.values
      .map((item) => item.price * item.quantity)
      .fold(0.0, (prev, next) => prev + next);

  void addItem(FoodItem item) {
    if (_cartItems.containsKey(item.id)) {
      _cartItems[item.id]!.quantity++;
    } else {
      _cartItems[item.id] = item;
    }
    notifyListeners();
  }

  void removeItem(String id) {
    if (_cartItems.containsKey(id)) {
      _cartItems.remove(id);
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
