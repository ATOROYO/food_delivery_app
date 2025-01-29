import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/food_item.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, FoodItem> _cartItems = {};

  Map<String, FoodItem> get cartItems => Map.unmodifiable(_cartItems);

  double get totalPrice => _cartItems.values
      .map((item) => item.price * item.quantity)
      .fold(0.0, (prev, next) => prev + next)
      .clamp(0.0, double.maxFinite);

  // Remove the SharedPreferences import if not needed yet
  // Keep these if you plan to implement persistence later:

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = jsonEncode(_cartItems.values.toList());
    await prefs.setString('cart', cartJson);
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');
    if (cartJson != null) {
      final List<dynamic> data = jsonDecode(cartJson);
      _cartItems.clear();
      for (var item in data) {
        final foodItem = FoodItem.fromMap(item);
        _cartItems[foodItem.id] = foodItem;
      }
      notifyListeners();
    }
  }

  void addItem(FoodItem item) {
    if (item.quantity < 1) throw ArgumentError('Invalid quantity');
    if (item.price <= 0) throw ArgumentError('Invalid price');

    _cartItems.update(
      item.id,
      (existing) => existing.copyWith(quantity: existing.quantity + 1),
      ifAbsent: () => item.copyWith(quantity: 1),
    );
    notifyListeners();
  }

  void removeItem(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void incrementQuantity(String itemId) {
    _cartItems.update(
      itemId,
      (item) => item.copyWith(quantity: item.quantity + 1),
    );
    notifyListeners();
  }

  void decrementQuantity(String itemId) {
    final item = _cartItems[itemId]!;
    if (item.quantity > 1) {
      _cartItems[itemId] = item.copyWith(quantity: item.quantity - 1);
    } else {
      _cartItems.remove(itemId);
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
