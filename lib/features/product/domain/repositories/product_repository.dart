
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository{
  Future<Either<Failure,List<Product>>> getAllProducts();
  Future<Either<Failure,Product>> getProduct({required int idProduct});
  Future<Either<Failure,List<String>>> getAllCategory();
  Future<Either<Failure,Unit>> addProduct({required Product product,});
  Future<Either<Failure,Unit>> updateProduct({required Product product,});
  Future<Either<Failure,Unit>> deleteProduct({required int idProduct,});
}