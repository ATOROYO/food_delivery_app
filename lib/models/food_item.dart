class FoodItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description; // Added description
  final String category; // Added category
  int quantity;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.description = '', // Default empty description
    this.category = '', // Default empty category
    this.quantity = 1, // Default quantity is 1
  });

  // Factory constructor to create a FoodItem from Firestore data
  factory FoodItem.fromMap(Map<String, dynamic> data, String id) {
    return FoodItem(
      id: id,
      name:
          data['name'] ?? 'Unknown', // Fallback to 'Unknown' if name is missing
      price:
          (data['price'] as num?)?.toDouble() ?? 0.0, // Ensure price is double
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
    );
  }

  // Convert FoodItem to a map for Firestore
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
