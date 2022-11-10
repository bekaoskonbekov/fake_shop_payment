import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/error/failures.dart';
import '../entities/payment.dart';
import '../repositories/cart_repository.dart';

class GetAllPaymentUseCase {
  final CartRepository cartRepository;

  GetAllPaymentUseCase(this.cartRepository);

  Future<Either<Failure, List<Payment>>> call(Database database) async {
    return await cartRepository.getAllPayments(database);
  }
}
