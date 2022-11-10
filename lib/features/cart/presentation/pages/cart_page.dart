import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/get_os.dart';
import '../../../../core/localization/get_translate.dart';
import '../../../../core/routing/navigate_to.dart';
import '../../../../core/var.dart';
import '../../../../core/widget/adaptive/adaptive_button.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/list_cart_products.dart';
import 'check_out_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CartCubit.get(context).calculateSupTotal();
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(getTranslated(context, "Cart_page_appBar_title_key")),
            centerTitle: true,
          ),
          body: carts.isEmpty
              ? Center(
                  child: Text(getTranslated(
                      context, "Cart_page_appBar_carts_isEmpty_key")))
              : Column(
                  children: [
                    const Expanded(child: ListCartProducts()),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getTranslated(
                                    context, "Cart_page_subTotal_key"),
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
                                    CartCubit.get(context)
                                        .subTotal
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getTranslated(
                                    context, "Cart_page_shipping_key"),
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
                                  const Text(
                                    "10",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ),
                          Row(
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
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AdaptiveButton(
                            os: getOs(),
                            function: () {
                              navigateTo(context, const CheckOutPage());
                            },
                            text: getTranslated(
                                context, "Cart_page_CheckOut_title_key"),
                            background: Colors.black87,
                            radius: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
