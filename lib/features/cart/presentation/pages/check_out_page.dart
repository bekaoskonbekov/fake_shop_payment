import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/get_translate.dart';
import '../../../../core/var.dart';
import '../cubit/cart_cubit.dart';
import '../widgets/checkout_widgets/delivery_addreess_widget.dart';
import '../widgets/checkout_widgets/my_cart_widget.dart';
import '../widgets/checkout_widgets/pay_now_button.dart';
import '../widgets/checkout_widgets/paymenth_method_widget.dart';
import '../widgets/checkout_widgets/total_price_widget.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartCubit.get(context).getAllPaymentsCubit();
    print("payments lenght = ${payments.length}");
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is DeletePaymentSuccessState) {
          CartCubit.get(context).getAllPaymentsCubit();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title:
                Text(getTranslated(context, "Checkout_page_appBar_title_key")),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  DeliveryAddressWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  PaymenthMethodWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  MyCartWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  TotalPriceWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  PayNowButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
