import 'package:flutter/material.dart';
import '../../../../core/var.dart';
import '../../domain/entities/product.dart';
import '../widgets/product_page_widgets/button_add_to_card.dart';
import '../widgets/product_page_widgets/chose_color.dart';
import '../widgets/product_page_widgets/chose_size.dart';
import '../widgets/product_page_widgets/image_item.dart';
import '../widgets/product_page_widgets/price_text.dart';
import '../widgets/product_page_widgets/title_text.dart';

class ProductPage extends StatelessWidget {
  final Product productItem;
  const ProductPage({Key? key, required this.productItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleText(
                  title: productItem.title,
                ),
                ImageItem(
                  imageUrl: productItem.image,
                ),
                const ChoseSize(),
                const ChoseColor(),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PriceText(price: productItem.price),
                ButtonAddToCart(
                  product: productItem,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
