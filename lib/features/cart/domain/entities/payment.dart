import 'package:flutter/material.dart';

class Payment {
  final String numberCart;
  final String expiryDate;
  final String cvvCode;
  final String? cardHolderName;
  final String? bankName;

  Payment(
      {required this.numberCart,
      required this.expiryDate,
      required this.cvvCode,
      this.cardHolderName,
      this.bankName});
}
