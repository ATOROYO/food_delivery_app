class FoodItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  factory FoodItem.fromMap(Map<String, dynamic> data, String id) {
    return FoodItem(
      id: id,
      name: data['name'],
      price: data['price'],
      imageUrl: data['imageUrl'],
    );
  }
}
