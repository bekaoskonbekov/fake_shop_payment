import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class GetAllCategoryUseCase {
  final ProductRepository productRepository;

  const GetAllCategoryUseCase(this.productRepository);

  Future<Either<Failure, List<String>>> call() async {
    return await productRepository.getAllCategory();
  }
}
