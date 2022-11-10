import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/strings/map_failure_to_message.dart';
import '../../../../core/var.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/get_all_category.dart';
import 'package:bloc/bloc.dart';

import '../../domain/usecases/get_all_products_usecase.dart';
import '../../domain/usecases/get_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetAllCategoryUseCase getAllCategoryUseCase;
  final GetProductUseCase getProductUseCase;
  final AddProductUseCase addProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ProductCubit(
      {required this.getAllProductsUseCase,
      required this.getAllCategoryUseCase,
      required this.getProductUseCase,
      required this.addProductUseCase,
      required this.updateProductUseCase,
      required this.deleteProductUseCase})
      : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of(context);

  // List<Product> p = [];
  void getAllProductsCubit() async {
    emit(GetAllProductsLoadingState());
    final failureOrProducts = await getAllProductsUseCase();
    failureOrProducts.fold(
        (failure) =>
            emit(GetAllProductsErrorState(mapFailureToMessage(failure))),
        (productsList) {
      products = productsList;
      return emit(GetAllProductsSuccessState(products));
    });
  }

  void getProductCubit(int idProduct) async {
    emit(GetProductLoadingState());
    final failureOrProduct = await getProductUseCase(idProduct: idProduct);
    failureOrProduct.fold(
        (failure) => emit(GetProductErrorState(mapFailureToMessage(failure))),
        (product) => emit(GetProductSuccessState(product)));
  }

  void getAllCategoriesCubit() async {
    emit(GetAllCategoriesLoadingState());
    final failureOrCategories = await getAllCategoryUseCase();
    failureOrCategories.fold(
        (failure) =>
            emit(GetAllCategoriesErrorState(mapFailureToMessage(failure))),
        (categoriesList) {
      categories = categoriesList;
      return emit(GetAllCategoriesSuccessState());
    });
  }

  void addProductCubit({required Product product}) async {
    emit(AddProductLoadingState());
    final failureOrUnit = await addProductUseCase(product: product);
    failureOrUnit.fold(
        (failure) => emit(AddProductErrorState(mapFailureToMessage(failure))),
        (_) => emit(AddProductSuccessState()));
  }

  void updateProductCubit({required Product product}) async {
    emit(UpdateProductLoadingState());
    final failureOrUnit = await updateProductUseCase(product: product);
    failureOrUnit.fold(
        (failure) =>
            emit(UpdateProductErrorState(mapFailureToMessage(failure))),
        (_) => emit(UpdateProductSuccessState()));
  }

  void deleteProductCubit({required int productId}) async {
    emit(DeleteProductLoadingState());
    final failureOrUnit = await deleteProductUseCase(idProduct: productId);
    failureOrUnit.fold(
        (failure) =>
            emit(DeleteProductErrorState(mapFailureToMessage(failure))),
        (_) => emit(DeleteProductSuccessState()));
  }

  void changeCategoryItemColor() {}
}
