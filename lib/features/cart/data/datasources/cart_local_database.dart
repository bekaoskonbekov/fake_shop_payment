import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/var.dart';
import '../models/payment_model.dart';

abstract class PaymentLocalDataBase {
  Future<Database> createPaymentDataBase();
  Future<List<PaymentModel>> getAllPayments(Database database);
  Future<Unit> addPayment(PaymentModel payment);
  Future<Unit> updatePayment(PaymentModel payment);
  Future<Unit> deletePayment(String uId);
}

class PaymentLocalDataBaseFromSqfLite implements PaymentLocalDataBase {
  @override
  Future<Database> createPaymentDataBase() async {
    return await openDatabase(
      'payments.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database.execute(
            'CREATE TABLE payments (numberCart TEXT PRIMARY KEY, expiryDate TEXT, cvvCode TEXT, bankName TEXT, cardHolderName TEXT)');
      },
      onOpen: (database) {
        ///ToDo: what happen if this is comment
        // getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) => database = value);
  }

  @override
  Future<List<PaymentModel>> getAllPayments(Database database) async {
    List<PaymentModel> payments = [];
    await database.rawQuery('SELECT * FROM payments').then((value) {
      for (var element in value) {
        payments.add(PaymentModel.fromJson(element));
      }
    });
    return payments;
  }

  @override
  Future<Unit> addPayment(PaymentModel payment) async {
    return await database.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO payments(numberCart, expiryDate, cvvCode, bankName, cardHolderName) VALUES("${payment.numberCart}", "${payment.expiryDate}", "${payment.cvvCode}", "${payment.bankName}", "${payment.cardHolderName}")',
      );
      //this line maybe make mistake
      return unit;
    });
  }

  @override
  Future<Unit> updatePayment(PaymentModel payment) async {
    await database.rawUpdate(
      'UPDATE payments SET expiryDate = ?,cvvCode = ?,bankName = ?,cardHolderName = ? WHERE numberCart = ?',
      [
        payment.expiryDate,
        payment.cvvCode,
        payment.bankName,
        payment.cardHolderName,
        payment.numberCart
      ],
    );
    return unit;
  }

  @override
  Future<Unit> deletePayment(String uId) async {
    await database
        .rawDelete('DELETE FROM payments WHERE numberCart = ?', [uId]);
    return unit;
  }
}
