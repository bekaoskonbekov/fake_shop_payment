import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_database.dart';
import '../datasources/remote_product_database.dart';
import '../models/product_model.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataBase localDataBase;
  final ProductRemoteDataBase remoteDataBase;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {required this.localDataBase,
      required this.remoteDataBase,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataBase.getAllProducts();
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct({required int idProduct}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData =
            await remoteDataBase.getProduct(idProduct: idProduct);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllCategory() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataBase.getAllCategory();
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addProduct({required Product product}) async {
    ProductModel productModel = ProductModel(
        id: product.id,
        title: product.title,
        price: product.price,
        description: product.description,
        category: product.category,
        image: product.image);
    return await _getMessage(
        () => remoteDataBase.addProduct(productModel: productModel));
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct({required int idProduct}) async {
    return await _getMessage(
        () => remoteDataBase.deleteProduct(idProduct: idProduct));
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(
      {required Product product}) async {
    ProductModel productModel = ProductModel(
        id: product.id,
        title: product.title,
        price: product.price,
        description: product.description,
        category: product.category,
        image: product.image);
    return await _getMessage(
        () => remoteDataBase.updateProduct(productModel: productModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
