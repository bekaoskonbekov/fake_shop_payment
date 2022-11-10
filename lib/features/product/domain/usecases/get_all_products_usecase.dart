import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProductsUseCase {
  final ProductRepository productRepository;

  const GetAllProductsUseCase(this.productRepository);

  Future<Either<Failure, List<Product>>> call() async {
    return await productRepository.getAllProducts();
  }
}
