part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class SubTotalChangeLoading extends CartState {}
class SubTotalChangeSuccess extends CartState {}

class DeleteProductFromCartLoading extends CartState {}
class DeleteProductFromCartSuccess extends CartState {}


class AddCardPageChangePasswordVisibilityLoadingState extends CartState {}
class AddCardPageChangePasswordVisibilitySuccessState extends CartState {}


class CreatePaymentDataBaseLoadingState extends CartState {}
class CreatePaymentDataBaseSuccessState extends CartState {}
class CreatePaymentDataBaseErrorState extends CartState {
  final String error;

  const CreatePaymentDataBaseErrorState(this.error);
}

class GetAllPaymentsLoadingState extends CartState {}
class GetAllPaymentsSuccessState extends CartState {}
class GetAllPaymentsErrorState extends CartState {
  final String error;

  const GetAllPaymentsErrorState(this.error);
}

class AddPaymentLoadingState extends CartState {}
class AddPaymentSuccessState extends CartState {}
class AddPaymentErrorState extends CartState {
  final String error;

  const AddPaymentErrorState(this.error);
}

class UpdatePaymentLoadingState extends CartState {}
class UpdatePaymentSuccessState extends CartState {}
class UpdatePaymentErrorState extends CartState {
  final String error;

  const UpdatePaymentErrorState(this.error);
}

class DeletePaymentLoadingState extends CartState {}
class DeletePaymentSuccessState extends CartState {}
class DeletePaymentErrorState extends CartState {
  final String error;

  const DeletePaymentErrorState(this.error);
}