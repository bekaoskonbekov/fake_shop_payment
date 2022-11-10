import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/var.dart';
import '../cubit/cart_cubit.dart';
import 'list_cart_item.dart';

class ListCartProducts extends StatefulWidget {
  const ListCartProducts({Key? key}) : super(key: key);

  @override
  State<ListCartProducts> createState() => _ListCartProductsState();
}

class _ListCartProductsState extends State<ListCartProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListCartItem(
                cartItem: carts[index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
            itemCount: carts.length);
      },
    );
  }
}
