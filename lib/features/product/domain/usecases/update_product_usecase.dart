import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository productRepository;

  const UpdateProductUseCase(this.productRepository);

  Future<Either<Failure, Unit>> call({required Product product}) async {
    return await productRepository.updateProduct(product: product);
  }
}
