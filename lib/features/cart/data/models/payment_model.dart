import '../../domain/entities/payment.dart';

class PaymentModel extends Payment {
  PaymentModel(
      {required super.numberCart,
      required super.expiryDate,
      required super.cvvCode,
      super.bankName,
      super.cardHolderName});

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      numberCart: json["numberCart"],
      expiryDate: json["expiryDate"],
      cvvCode: json["cvvCode"],
      bankName: json["bankName"],
      cardHolderName: json["cardHolderName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "numberCart": numberCart,
      "expiryDate": expiryDate,
      "cvvCode": cvvCode,
      "bankName": bankName,
      "cardHolderName": cardHolderName,
    };
  }
}
