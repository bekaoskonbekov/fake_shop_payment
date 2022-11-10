part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

// Products state
class GetAllProductsSuccessState extends ProductState {
  final List<Product> products;

  const GetAllProductsSuccessState(this.products);
}

class GetAllProductsLoadingState extends ProductState {}

class GetAllProductsErrorState extends ProductState {
  final String errorMessage;

  const GetAllProductsErrorState(this.errorMessage);
}

//product state
class GetProductSuccessState extends ProductState {
  final Product products;

  const GetProductSuccessState(this.products);
}

class GetProductLoadingState extends ProductState {}

class GetProductErrorState extends ProductState {
  final String errorMessage;

  const GetProductErrorState(this.errorMessage);
}

//Categories state
class GetAllCategoriesSuccessState extends ProductState {}

class GetAllCategoriesLoadingState extends ProductState {}

class GetAllCategoriesErrorState extends ProductState {
  final String errorMessage;

  const GetAllCategoriesErrorState(this.errorMessage);
}



// Add state
class AddProductSuccessState extends ProductState {}

class AddProductLoadingState extends ProductState {}

class AddProductErrorState extends ProductState {
  final String errorMessage;

  const AddProductErrorState(this.errorMessage);
}

//Update state
class UpdateProductSuccessState extends ProductState {}

class UpdateProductLoadingState extends ProductState {}

class UpdateProductErrorState extends ProductState {
  final String errorMessage;

  const UpdateProductErrorState(this.errorMessage);
}

//Delete state
class DeleteProductSuccessState extends ProductState {}

class DeleteProductLoadingState extends ProductState {}

class DeleteProductErrorState extends ProductState {
  final String errorMessage;

  const DeleteProductErrorState(this.errorMessage);
}

// change category
class ChangeCategory extends ProductState {}