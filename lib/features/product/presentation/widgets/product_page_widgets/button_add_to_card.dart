import 'package:flutter/material.dart';

import '../../../../../core/localization/get_os.dart';
import '../../../../../core/routing/navigate_and_finish.dart';
import '../../../../../core/var.dart';
import '../../../../../core/widget/adaptive/adaptive_button.dart';
import '../../../../cart/domain/entities/cart.dart';
import '../../../domain/entities/product.dart';
import '../../pages/home_page.dart';
import '../var.dart';
import 'make_item_list_false.dart';

class ButtonAddToCart extends StatelessWidget {
  final Product product;
  const ButtonAddToCart({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveButton(
      os: getOs(),
      function: () {
        carts.add(CartItem(
            product: product,
            quantity: 1,
            size: size ?? "S",
            color: color ?? "#2ab7ca"));
        color = null;
        size = null;
        changeItemListToFalse(booleanColorList);
        changeItemListToFalse(booleanSizeList);

        navigateAndFinish(context, const HomePage());
      },
      text: "Add to cart",
      background: Colors.black87,
      width: 150,
      radius: 15,
    );
  }
}
