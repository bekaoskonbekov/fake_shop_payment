import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductUseCase {
  final ProductRepository productRepository;

  const GetProductUseCase(this.productRepository);

  Future<Either<Failure, Product>> call({required int idProduct}) async {
    return await productRepository.getProduct(idProduct: idProduct);
  }
}
