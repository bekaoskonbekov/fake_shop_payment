import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/cart_repository.dart';

class DeletePaymentUseCase {
  final CartRepository cartRepository;

  DeletePaymentUseCase(this.cartRepository);

  Future<Either<Failure, Unit>> call(String uId) async {
    return await cartRepository.deletePayment(uId);
  }
}
