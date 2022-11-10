import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../../core/widget/show_dialog_delete.dart';
import '../../../../../core/localization/get_translate.dart';
import '../../../../../core/routing/navigate_to.dart';
import '../../../domain/entities/product.dart';
import '../../pages/product_page.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _child(context);
  }

  Widget _child(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(context, ProductPage(productItem:product ,));
      },
      child: Column(
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.image),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
              width: 300,
              child: Text(
                product.title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
              )),
          Row(
            children: [
              Text(
                "\$ ",
                style: TextStyle(color: Colors.orange[400],fontSize:17 ),
              ),
              Text(
                "${product.price}",
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
