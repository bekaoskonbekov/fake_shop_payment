

import '../../../product/domain/entities/product.dart';

class CartItem {
  final Product product;
   int quantity;
  final String size;
  final String color;

  CartItem({required this.color,required this.size,required this.product, required this.quantity});
}

class Cart {
  final List<CartItem> carts;
  final DateTime dateTime;
  final String location;
  final double price;

  Cart(
      {required this.carts,
        required this.dateTime,
        required this.location,
        required this.price});
}
