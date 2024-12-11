import 'package:flutter/material.dart';
import '../models/food_item.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class FoodItemCard extends StatelessWidget {
  final FoodItem foodItem;

  const FoodItemCard({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Card(
      child: ListTile(
        leading: Image.network(foodItem.imageUrl,
            width: 50, height: 50, fit: BoxFit.cover),
        title: Text(foodItem.name),
        subtitle: Text('\$${foodItem.price.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () => cartProvider.addItem(foodItem),
        ),
      ),
    );
  }
}
