import 'package:dartz/dartz.dart';

import 'package:sqflite/sqflite.dart';

import '../../../../core/error/failures.dart';
import '../entities/payment.dart';

abstract class CartRepository {
  Future<Either<Failure, Database>> createPaymentDataBase();
  Future<Either<Failure, List<Payment>>> getAllPayments(Database database);
  Future<Either<Failure, Unit>> addPayment(Payment payment);
  Future<Either<Failure, Unit>> updatePayment(Payment payment);
  Future<Either<Failure, Unit>> deletePayment(String uId);
}
