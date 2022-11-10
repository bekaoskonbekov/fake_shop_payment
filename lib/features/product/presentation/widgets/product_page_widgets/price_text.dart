import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  final dynamic price;
  const PriceText({Key? key,required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "\$ ",
          style: TextStyle(color: Colors.orange[400], fontSize: 17),
        ),
        Text(
          "$price",
          style: const TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}
