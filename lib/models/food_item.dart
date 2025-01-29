class FoodItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;
  final int quantity;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.description = '',
    this.category = '',
    this.quantity = 1,
  });

  // Add this copyWith method
  FoodItem copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    String? description,
    String? category,
    int? quantity,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }

  // Rest of your existing code...
  factory FoodItem.fromMap(Map<String, dynamic> data, String id) {
    return FoodItem(
      id: id,
      name: data['name'] ?? 'Unknown',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
    };
  }
}
