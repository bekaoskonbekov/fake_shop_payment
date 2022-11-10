import 'package:fake_shop/features/product/presentation/widgets/search_page/product_search_item.dart';
import 'package:flutter/material.dart';

import '../../../../../core/var.dart';

class ListProducts extends StatelessWidget {
  final TextEditingController searchController;
  const ListProducts({Key? key, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (products[index].title.contains(searchController.text)) {
            return ProductSearchItem(product: products[index]);
          } else {
            return Container();
          }
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
        itemCount: products.length);
  }
}
