import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_item.dart';
import '../widgets/food_item_card.dart';

class HomeScreen extends StatelessWidget {
  final CollectionReference foodItemsRef =
      FirebaseFirestore.instance.collection('food_items');

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Delivery App'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 10,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: foodItemsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No food items available.'));
          }

          final foodItems = snapshot.data!.docs.map((doc) {
            return FoodItem.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.8,
            ),
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              return FoodItemCard(foodItem: foodItems[index]);
            },
          );
        },
      ),
    );
  }
}
