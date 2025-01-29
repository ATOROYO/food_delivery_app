class FoodItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;
  int quantity;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.description = '',
    this.category = 'Uncategorized',
    this.quantity = 1,
  });

  factory FoodItem.fromMap(Map<String, dynamic> data, String id) {
    return FoodItem(
      id: id,
      name: data['name']?.toString() ?? 'Unnamed Item',
      price: _parsePrice(data['price']),
      imageUrl: data['imageUrl']?.toString() ?? '',
      description: data['description']?.toString() ?? '',
      category: data['category']?.toString() ?? 'Uncategorized',
    );
  }

  static double _parsePrice(dynamic price) {
    try {
      return double.parse(price.toString());
    } catch (e) {
      return 0.0;
    }
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
