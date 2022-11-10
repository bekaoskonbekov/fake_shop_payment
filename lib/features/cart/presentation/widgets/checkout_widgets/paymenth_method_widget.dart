import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../../core/localization/get_translate.dart';
import '../../../../../core/routing/navigate_to.dart';
import '../../../../../core/var.dart';
import '../../../../../core/widget/show_dialog_delete.dart';
import '../../../domain/entities/payment.dart';
import '../../cubit/cart_cubit.dart';
import '../../pages/add_card_page.dart';

class PaymenthMethodWidget extends StatelessWidget {
  const PaymenthMethodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(getTranslated(context,
                      "PaymenthMethodWidget_page_text_PaymenthMethod_key")),
                  const Spacer(),

                  ///ToDo:Change icon button to dropDown menu
                  IconButton(
                      onPressed: () {
                        navigateTo(context, AddCardPage());
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.grey,
                      )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.separated(
                    itemBuilder: (context, index) =>
                        itemPayment(context, payments[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                    itemCount: payments.length),
              ),
            ],
          );
        },
        listener: (context, state) {});
  }

  Widget itemPayment(BuildContext context, Payment payment) {
    bool _value = false;
    return Slidable(
      startActionPane: deleteActionPane(context: context, payment: payment),
      endActionPane: editActionPane(context: context, payment: payment),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(Radius.circular(13)),
            ),
            child: const Icon(Icons.payment),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (payment.bankName != "null")
                Text(payment.bankName ?? payment.numberCart),
              Text(
                payment.numberCart,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check_circle_outline_outlined),
          ),
          /* Checkbox(
              value: _value,
              checkColor: Colors.lightGreen,

              onChanged: (value) {
                _value = _value;
                if (_value == true) {
                  print("ok");
                }
              }),*/
        ],
      ),
    );
  }

  ActionPane deleteActionPane(
      {required BuildContext context, required Payment payment}) {
    return ActionPane(motion: const ScrollMotion(), children: [
      SlidableAction(
        onPressed: (_) {
          showDialogDelete(
              context: context,
              title: payment.numberCart,
              describe: getTranslated(
                  context, "PaymenthMethodWidget_body_showDialogDelete_dec"),
              function: () {
                CartCubit.get(context).deletePaymentCubit(payment.numberCart);
              });
        },
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: getTranslated(
            context, "PaymenthMethodWidget_SlidableAction_delete_label"),
        borderRadius: BorderRadius.circular(20),
      ),
    ]);
  }

  ActionPane editActionPane(
      {required BuildContext context, required Payment payment}) {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          // An action can be bigger than the others.
          flex: 1,
          onPressed: (_) {
            navigateTo(
                context,
                AddCardPage(
                  payment: payment,
                ));
          },
          backgroundColor: const Color(0xFF7BC043),
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: getTranslated(
              context, "PaymenthMethodWidget_SlidableAction_update_label"),
          borderRadius: BorderRadius.circular(20),
        )
      ],
    );
  }
}
