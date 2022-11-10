import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/payment.dart';
import '../repositories/cart_repository.dart';

class UpdatePaymentUseCase {
  final CartRepository cartRepository;

  UpdatePaymentUseCase(this.cartRepository);

  Future<Either<Failure, Unit>> call(Payment payment) async {
    return await cartRepository.updatePayment(payment);
  }
}
