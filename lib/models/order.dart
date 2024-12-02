import 'food_item.dart';

class Order {
  final String id;
  final String userId;
  final List<FoodItem> items;
  final double totalPrice;
  final String status;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.status,
  });

  factory Order.fromMap(Map<String, dynamic> data, String id) {
    return Order(
      id: id,
      userId: data['userId'] ?? '',
      items: (data['items'] as List<dynamic>)
          .map((item) =>
              FoodItem.fromMap(item as Map<String, dynamic>, item['id']))
          .toList(),
      totalPrice: data['totalPrice'] ?? 0.0,
      status: data['status'] ?? 'Pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items
          .map((item) => {
                'id': item.id,
                'name': item.name,
                'quantity': item.quantity,
                'price': item.price,
              })
          .toList(),
      'totalPrice': totalPrice,
      'status': status,
    };
  }
}
