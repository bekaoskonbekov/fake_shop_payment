import 'package:flutter/material.dart';

import '../../../../core/localization/get_translate.dart';
import '../../../../core/var.dart';
import '../../domain/entities/cart.dart';
import '../cubit/cart_cubit.dart';

class ListCartItem extends StatefulWidget {
  final CartItem cartItem;
  const ListCartItem({Key? key, required this.cartItem}) : super(key: key);

  @override
  State<ListCartItem> createState() => _ListCartItemState();
}

class _ListCartItemState extends State<ListCartItem> {
  @override
  Widget build(BuildContext context) {
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
                image: NetworkImage(widget.cartItem.product.image),
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
                      widget.cartItem.product.title,
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
                      widget.cartItem.size,
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
                      "${widget.cartItem.product.price}",
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            widget.cartItem.quantity += 1;
                            CartCubit.get(context).calculateSupTotal();
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline_outlined)),
                    Text("${widget.cartItem.quantity}"),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (widget.cartItem.quantity > 1) {
                              widget.cartItem.quantity -= 1;
                              CartCubit.get(context).calculateSupTotal();
                            }
                          });
                        },
                        icon: const Icon(Icons.remove_circle_outline_outlined)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          CartCubit.get(context)
                              .emit(DeleteProductFromCartLoading());
                          carts.remove(widget.cartItem);
                          CartCubit.get(context)
                              .emit(DeleteProductFromCartSuccess());
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.grey,
                        )),
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
