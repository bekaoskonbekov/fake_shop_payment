import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProductUseCase {
  final ProductRepository productRepository;

  const AddProductUseCase(this.productRepository);

  Future<Either<Failure, Unit>> call({required Product product}) async {
    return await productRepository.addProduct(product: product);
  }
}
