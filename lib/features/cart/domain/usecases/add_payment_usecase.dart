import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/payment.dart';
import '../repositories/cart_repository.dart';

class AddPaymentUseCase {
  final CartRepository cartRepository;

  AddPaymentUseCase(this.cartRepository);

  Future<Either<Failure, Unit>> call(Payment payment) async {
    return await cartRepository.addPayment(payment);
  }
}
