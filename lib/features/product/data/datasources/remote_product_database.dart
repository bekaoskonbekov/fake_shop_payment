import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../../../core/dio/dio_helper.dart';
import '../../../../core/dio/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataBase {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProduct({required int idProduct});
  Future<List<String>> getAllCategory();
  Future<Unit> addProduct({
    required ProductModel productModel,
  });
  Future<Unit> updateProduct({
    required ProductModel productModel,
  });
  Future<Unit> deleteProduct({
    required int idProduct,
  });
}

class ProductRemoteDataBaseImpl implements ProductRemoteDataBase {
  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await DioHelper.getData(url: product);
    if (response.statusCode == 200) {
      final List<ProductModel> products = response.data
          .map<ProductModel>(
              (jsonProductModel) => ProductModel.fromJson(jsonProductModel))
          .toList();
      return products;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<String>> getAllCategory() async {
    final response = await DioHelper.getData(url: category);
    if (response.statusCode == 200) {
      final List<String> categories = response.data
          .map<String>((jsonProductModel) => jsonProductModel.toString())
          .toList();

//      List<String> categories = response.data;
      categories.insert(0, "All");
      return categories;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProduct({required int idProduct}) async {
    final response = await DioHelper.getData(url: product);
    if (response.statusCode == 200) {
      final product = ProductModel.fromJson(response.data);
      return product;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addProduct({required ProductModel productModel}) async {
    final body = {
      "title": productModel.title,
      "description": productModel.description,
      "price": productModel.price,
      "category": productModel.category,
      "image": productModel.image,
      "rating": {"rate": 3.9, "count": 120}
    };
    final response = await DioHelper.postData(url: product, data: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateProduct({required ProductModel productModel}) async {
    final productId = productModel.id;
    final body = {
      "title": productModel.title,
      "description": productModel.description,
      "price": productModel.price,
      "category": productModel.category,
      "image": productModel.image,
      "rating": {"rate": 3.9, "count": 120}
    };

    final response =
        await DioHelper.putData(url: "$product/$productId", data: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteProduct({required int idProduct}) async {
    final response =
        await DioHelper.deleteData(url: product, productId: idProduct);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
