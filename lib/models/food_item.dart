class FoodItem {
  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.tagline,
  });

  final String id;
  final String name;
  final String description;
  final int price;
  final String imagePath;
  final String category;
  final String tagline;
}
