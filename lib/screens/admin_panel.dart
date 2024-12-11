import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPanel extends StatelessWidget {
  final CollectionReference foodItemsRef =
      FirebaseFirestore.instance.collection('food_items');

  // Constructor with Key
  AdminPanel({super.key});

  void addFoodItem(BuildContext context) async {
    try {
      await foodItemsRef.add({
        'name': 'New Item',
        'price': 10.0,
        'imageUrl': '',
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item added successfully.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add item: $e')),
        );
      }
    }
  }

  void deleteFoodItem(String id, BuildContext context) async {
    try {
      await foodItemsRef.doc(id).delete();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item deleted successfully.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete item: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: foodItemsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading items.'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data!.docs;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final data = item.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['name'] ?? 'Unnamed Item'),
                subtitle: Text(data['price'] != null
                    ? '\$${data['price']}'
                    : 'No price available'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteFoodItem(item.id, context),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addFoodItem(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
