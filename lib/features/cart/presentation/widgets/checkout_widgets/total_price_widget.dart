import 'package:flutter/material.dart';

import '../../../../../core/localization/get_translate.dart';
import '../../cubit/cart_cubit.dart';

class TotalPriceWidget extends StatelessWidget {
  const TotalPriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getTranslated(context, "Cart_page_Total_key"),
          style: const TextStyle(
              color: Colors.grey, fontSize: 15),
        ),
        Row(
          children: [
            Text(
              "\$ ",
              style: TextStyle(
                  color: Colors.orange[400],
                  fontSize: 17),
            ),
            Text(
              (CartCubit.get(context).subTotal + 10)
                  .toStringAsFixed(2),
              style: const TextStyle(
                  color: Colors.black, fontSize: 17),
            ),
          ],
        ),
      ],
    );

  }
}
