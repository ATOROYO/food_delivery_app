import 'package:cloud_firestore/cloud_firestore.dart';
import 'food_item.dart';

class Order {
  final String id;
  final String userId;
  final List<FoodItem> items;
  final double totalPrice;
  final OrderStatus status;
  final Timestamp timestamp;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    this.status = OrderStatus.pending,
    required this.timestamp,
  });

  factory Order.fromMap(Map<String, dynamic> data, String id) {
    return Order(
      id: id,
      userId: data['userId']?.toString() ?? '',
      items: _parseItems(data['items']),
      totalPrice: _parseDouble(data['totalPrice']),
      status: OrderStatus.fromString(data['status']?.toString()),
      timestamp: data['timestamp'] as Timestamp? ?? Timestamp.now(),
    );
  }

  static List<FoodItem> _parseItems(dynamic items) {
    if (items is! List) return [];
    return items.whereType<Map<String, dynamic>>().map((item) {
      return FoodItem(
        id: item['id']?.toString() ?? '',
        name: item['name']?.toString() ?? 'Unknown Item',
        price: _parseDouble(item['price']),
        imageUrl: item['imageUrl']?.toString() ?? '',
        quantity: (item['quantity'] as int?) ?? 1,
      );
    }).toList();
  }

  static double _parseDouble(dynamic value) {
    try {
      return double.parse(value.toString());
    } catch (e) {
      return 0.0;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalPrice': totalPrice,
      'status': status.name,
      'timestamp': timestamp,
    };
  }

  Order copyWith({
    String? id,
    String? userId,
    List<FoodItem>? items,
    double? totalPrice,
    OrderStatus? status,
    Timestamp? timestamp,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId;

  @override
  int get hashCode => id.hashCode ^ userId.hashCode;
}

enum OrderStatus {
  pending('Pending'),
  preparing('Preparing'),
  delivered('Delivered'),
  cancelled('Cancelled');

  final String name;
  const OrderStatus(this.name);

  static OrderStatus fromString(String? value) {
    return OrderStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => OrderStatus.pending,
    );
  }
}
