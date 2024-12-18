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
        title: const Text(
          'Food Delivery App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: foodItemsRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              debugPrint('No data received from Firestore.');
              return const Center(
                child: Text(
                  'No food items available.',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              debugPrint('Firestore returned an empty list.');
              return const Center(
                child: Text(
                  'No food items available.',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            }

            final foodItems = snapshot.data!.docs.map((doc) {
              debugPrint('Document data: ${doc.data()}');
              return FoodItem.fromMap(
                doc.data() as Map<String, dynamic>,
                doc.id,
              );
            }).toList();

            return GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                return FoodItemCard(foodItem: foodItems[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
