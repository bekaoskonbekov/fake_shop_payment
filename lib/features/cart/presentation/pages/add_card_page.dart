import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../../../../core/localization/get_os.dart';
import '../../../../core/localization/get_translate.dart';
import '../../../../core/widget/adaptive/adaptive_button.dart';
import '../../../../core/widget/adaptive/adaptive_text_field.dart';
import '../../domain/entities/payment.dart';
import '../cubit/cart_cubit.dart';

class AddCardPage extends StatefulWidget {
  AddCardPage({this.payment, Key? key}) : super(key: key);
  Payment? payment;
  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  String? cardNumber;
  String? expiryDate;
  String? cardHolderName;
  String? cvvCode;
  //String? bankName;

  bool obscureCardNumber = true;
  bool obscureCardHolderName = true;
  bool obscureCvvCode = true;

  bool isCvvFocused = false;

  //OutlineInputBorder? border;
  InputBorder? enabledBorder;

  Color colorHintText = Colors.grey;
  Color colorText = Colors.black54;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController bankController = TextEditingController();
  @override
  void initState() {
    enabledBorder = const UnderlineInputBorder();
    if (widget.payment != null) {
      cardNumber = widget.payment?.numberCart;
      cvvCode = widget.payment?.cvvCode;
      expiryDate = widget.payment?.expiryDate;
      cardHolderName = widget.payment?.cardHolderName;
      bankController.text = "${widget.payment?.bankName}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
            child: CreditCardWidget(
              cardNumber: cardNumber ?? "",
              expiryDate: expiryDate ?? "",
              cardHolderName: cardHolderName ?? "",
              cvvCode: cvvCode ?? "",
              bankName: bankController.text,
              showBackView: isCvvFocused,
              obscureCardNumber: obscureCardNumber,
              obscureCardCvv: obscureCvvCode,
              isHolderNameVisible: obscureCardHolderName,
              cardBgColor: Colors.black,
              onCreditCardWidgetChange:
                  (CreditCardBrand) {}, //true when you want to show cvv(back) view
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: obscureCvvCode,
                    obscureNumber: obscureCardNumber,
                    cardNumber: cardNumber ?? "",
                    cvvCode: cvvCode ?? "",
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    cardHolderName: cardHolderName ?? "",
                    expiryDate: expiryDate ?? "",
                    themeColor: Colors.black,
                    textColor: Colors.black,
                    cardNumberValidator: (String? cardNumber) {
                      if (cardNumber == null || cardNumber.isEmpty) {
                        return getTranslated(context,
                            "AddCart_page_CreditCardForm_cardNumberValidator_key");
                      }
                      if (cardNumber.length < 19) {
                        return getTranslated(context,
                            "AddCart_page_CreditCardForm_cardNumber_length_key");
                      }
                      return null;
                    },
                    expiryDateValidator: (String? expiryDate) {
                      if (expiryDate == null || expiryDate.isEmpty) {
                        return getTranslated(context,
                            "AddCart_page_CreditCardForm_expiryDateValidator_key");
                      }
                      if (expiryDate.length < 5) {
                        return getTranslated(context,
                            "AddCart_page_CreditCardForm_expiryDate_length_key");
                      }
                      return null;
                    },
                    cvvValidator: (String? cvv) {
                      if (cvvCode == null || cvvCode!.isEmpty) {
                        return getTranslated(context,
                            "AddCart_page_CreditCardForm_cvvValidator_key");
                      }
                      if (cvvCode!.length < 3) {
                        return getTranslated(context,
                            "AddCart_page_CreditCardForm_cvv_length_key");
                      }
                      return null;
                    },
                    cardNumberDecoration: InputDecoration(
                      labelText: getTranslated(context,
                          "AddCart_page_CreditCardForm_cardNumber_label_key"),
                      hintText: 'XXXX XXXX XXXX XXXX',
                      hintStyle: TextStyle(color: colorHintText),
                      labelStyle: TextStyle(color: colorText),
                      //focusedBorder: focusedBorder,
                      enabledBorder: enabledBorder,
                      suffix: IconButton(
                        icon: Icon(obscureCardNumber
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () {
                          setState(() {
                            obscureCardNumber = !obscureCardNumber;
                          });
                        },
                      ),
                    ),
                    expiryDateDecoration: InputDecoration(
                      hintStyle: TextStyle(color: colorHintText),
                      labelStyle: TextStyle(color: colorText),
                      // focusedBorder: focusedBorder,
                      enabledBorder: enabledBorder,
                      labelText: getTranslated(context,
                          "AddCart_page_CreditCardForm_expiryDate_label_key"),
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: InputDecoration(
                      hintStyle: TextStyle(color: colorHintText),
                      labelStyle: TextStyle(color: colorText),
                      // focusedBorder: focusedBorder,
                      enabledBorder: enabledBorder,
                      labelText: getTranslated(
                          context, "AddCart_page_CreditCardForm_cvv_label_key"),
                      hintText: 'XXX',
                      suffix: IconButton(
                        icon: Icon(obscureCvvCode
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () {
                          setState(() {
                            obscureCvvCode = !obscureCvvCode;
                          });
                        },
                      ),
                    ),
                    cardHolderDecoration: InputDecoration(
                      hintStyle: TextStyle(color: colorHintText),
                      labelStyle: TextStyle(color: colorText),
                      //focusedBorder: focusedBorder,
                      enabledBorder: enabledBorder,
                      labelText: getTranslated(context,
                          "AddCart_page_CreditCardForm_CardHolder_label_key"),
                    ),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 13.0, left: 13.0, bottom: 20),
                    child: AdaptiveTextField(
                      os: getOs(),
                      controller: bankController,
                      label: getTranslated(context,
                          "AddCart_page_CreditCardForm_bankName_label_key"),
                      inputBorder: enabledBorder!,
                    ),
                  ),
                ],
              ),
            ),
          ),
          widget.payment == null
              ? AdaptiveButton(
                  os: getOs(),
                  function: () {
                    if (formKey.currentState!.validate()) {
                      Payment payment = Payment(
                          numberCart: "$cardNumber",
                          expiryDate: "$expiryDate",
                          cvvCode: "$cvvCode",
                          cardHolderName: "$cardHolderName",
                          bankName: bankController.text);
                      CartCubit.get(context).addPaymentCubit(payment, context);
                    }
                  },
                  text:
                      getTranslated(context, "AddCart_page_button_addCard_key"),
                  background: Colors.black87,
                  radius: 15,
                )
              : AdaptiveButton(
                  os: getOs(),
                  function: () {
                    if (formKey.currentState!.validate()) {
                      Payment payment = Payment(
                          numberCart: "$cardNumber",
                          expiryDate: "$expiryDate",
                          cvvCode: "$cvvCode",
                          cardHolderName: "$cardHolderName",
                          bankName: bankController.text);
                      CartCubit.get(context)
                          .updatePaymentCubit(payment, context);
                    }
                  },
                  text: getTranslated(
                      context, "AddCart_page_button_updateCard_key"),
                  background: Colors.black87,
                  radius: 15,
                ),
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
