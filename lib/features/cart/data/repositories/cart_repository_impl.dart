import 'package:dartz/dartz.dart';

import 'package:sqflite_common/sqlite_api.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_database.dart';
import '../models/payment_model.dart';

class CartRepositoryImpl implements CartRepository {
  final PaymentLocalDataBase localDataBase;

  CartRepositoryImpl({required this.localDataBase});

  @override
  Future<Either<Failure, Database>> createPaymentDataBase() async {
    try {
      final database = await localDataBase.createPaymentDataBase();
      return Right(database);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addPayment(Payment payment) async {
    PaymentModel paymentModel = PaymentModel(
        numberCart: payment.numberCart,
        expiryDate: payment.expiryDate,
        cvvCode: payment.cvvCode,
        bankName: payment.bankName,
        cardHolderName: payment.cardHolderName);
    try {
      await localDataBase.addPayment(paymentModel);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePayment(String uId) async {
    try {
      await localDataBase.deletePayment(uId);
      return const Right(unit);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Payment>>> getAllPayments(
      Database database) async {
    try {
      final payments = await localDataBase.getAllPayments(database);
      return Right(payments);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePayment(Payment payment) async {
    PaymentModel paymentModel = PaymentModel(
        numberCart: payment.numberCart,
        expiryDate: payment.expiryDate,
        cvvCode: payment.cvvCode,
        bankName: payment.bankName,
        cardHolderName: payment.cardHolderName);
    try {
      await localDataBase.updatePayment(paymentModel);
      return const Right(unit);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }
}
