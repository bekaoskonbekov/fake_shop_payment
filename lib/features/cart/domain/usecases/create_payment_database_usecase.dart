import 'package:dartz/dartz.dart';

import 'package:sqflite/sqflite.dart';

import '../../../../core/error/failures.dart';
import '../repositories/cart_repository.dart';

class CreatePaymentDataBaseUseCase {
  final CartRepository cartRepository;

  CreatePaymentDataBaseUseCase(this.cartRepository);

  Future<Either<Failure, Database>> call() async {
    return await cartRepository.createPaymentDataBase();
  }
}
