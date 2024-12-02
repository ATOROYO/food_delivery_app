import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_item.dart';
import '../widgets/food_item_card.dart';
import '../widgets/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  final CollectionReference foodItemsRef =
      FirebaseFirestore.instance.collection('food_items');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Delivery App')),
      body: StreamBuilder<QuerySnapshot>(
        stream: foodItemsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No food items available.'));
          }

          final foodItems = snapshot.data!.docs.map((doc) {
            return FoodItem.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          return ListView.builder(
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              return FoodItemCard(foodItem: foodItems[index]);
            },
          );
        },
      ),
      bottomNavigationBar: NavigationBar(),
    );
  }
}
