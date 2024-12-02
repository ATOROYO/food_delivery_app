import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPanel extends StatelessWidget {
  final CollectionReference foodItemsRef =
      FirebaseFirestore.instance.collection('food_items');

  void addFoodItem(BuildContext context) async {
    await foodItemsRef.add({
      'name': 'New Item',
      'price': 10.0,
      'imageUrl': '',
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Item added')));
  }

  void deleteFoodItem(String id, BuildContext context) async {
    await foodItemsRef.doc(id).delete();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Item deleted')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel')),
      body: StreamBuilder<QuerySnapshot>(
        stream: foodItemsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text('Error loading items'));
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final items = snapshot.data!.docs;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final data = item.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['name']),
                subtitle: Text('\$${data['price']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteFoodItem(item.id, context),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addFoodItem(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
