import 'package:flutter/material.dart';

import '../../../../../core/localization/get_translate.dart';
import '../../../../../core/var.dart';
import '../../../domain/entities/cart.dart';
import '../list_cart_products.dart';

class MyCartWidget extends StatelessWidget {
  const MyCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(getTranslated(context, "MyCart_page_text_MyCart_key")),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.grey,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(height: 110, width: double.infinity, child: myCartProducts()),
      ],
    );
  }

  Widget myCartProducts() {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return myCartItem(
            cartItem: carts[index],
            context: context,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
        itemCount: carts.length);
  }

  Widget myCartItem(
      {required CartItem cartItem, required BuildContext context}) {
    return Row(
      children: [
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(cartItem.product.image),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      cartItem.product.title,
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                      maxLines: 2,
                    )),
                Row(
                  children: [
                    Text(
                      getTranslated(context, "Cart_page_cartItem_size_key"),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      cartItem.size,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "\$ ",
                      style: TextStyle(color: Colors.orange[400], fontSize: 17),
                    ),
                    Text(
                      "${cartItem.product.price}",
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
