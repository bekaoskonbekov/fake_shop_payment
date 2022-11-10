class Product {
  final int id;
  final String title;
  final dynamic price;
  final String description;
  final String category;
  final String image;

  const Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image});
}
