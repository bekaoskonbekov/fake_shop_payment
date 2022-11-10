import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/navigate_and_finish.dart';
import '../../../../core/strings/map_failure_to_message.dart';
import '../../../../core/var.dart';
import '../../domain/entities/payment.dart';
import '../../domain/usecases/add_payment_usecase.dart';
import '../../domain/usecases/create_payment_database_usecase.dart';
import '../../domain/usecases/delete_payment_usecase.dart';
import '../../domain/usecases/get_all_payment_usecase.dart';
import '../../domain/usecases/update_payment_usecase.dart';
import '../pages/check_out_page.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(
      {required this.getAllPayment,
      required this.createPaymentDataBase,
      required this.addPayment,
      required this.updatePayment,
      required this.deletePayment})
      : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  final GetAllPaymentUseCase getAllPayment;
  final CreatePaymentDataBaseUseCase createPaymentDataBase;
  final AddPaymentUseCase addPayment;
  final UpdatePaymentUseCase updatePayment;
  final DeletePaymentUseCase deletePayment;

  double subTotal = 0;
  double calculateSupTotal() {
    emit(SubTotalChangeLoading());
    subTotal = 0;
    for (var element in carts) {
      subTotal = subTotal + (element.quantity * element.product.price);
    }
    emit(SubTotalChangeSuccess());
    return subTotal;
  }

  // function to change icon in add card page
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    print("1");
    AddCardPageChangePasswordVisibilityLoadingState();
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AddCardPageChangePasswordVisibilitySuccessState());
  }

  void createPaymentDataBaseCubit() async {
    emit(CreatePaymentDataBaseLoadingState());
    final failureOrDataBase = await createPaymentDataBase();
    failureOrDataBase.fold(
        (failure) =>
            emit(CreatePaymentDataBaseErrorState(mapFailureToMessage(failure))),
        (r) {
      database = r;
      return emit(CreatePaymentDataBaseSuccessState());
    });
  }

  void getAllPaymentsCubit() async {
    emit(GetAllPaymentsLoadingState());
    final failureOrPayments = await getAllPayment(database);
    failureOrPayments.fold(
        (failure) =>
            emit(GetAllPaymentsErrorState(mapFailureToMessage(failure))),
        (paymentsList) {
      payments = paymentsList;
      return emit(GetAllPaymentsSuccessState());
    });
  }

  void addPaymentCubit(Payment payment, BuildContext context) async {
    emit(AddPaymentLoadingState());
    final failureOrUnit = await addPayment(payment);
    failureOrUnit.fold(
        (failure) => emit(AddPaymentErrorState(mapFailureToMessage(failure))),
        (r) {
      getAllPaymentsCubit();
      navigateAndFinish(context, const CheckOutPage());
      emit(AddPaymentSuccessState());
    });
  }

  void updatePaymentCubit(Payment payment, BuildContext context) async {
    emit(UpdatePaymentLoadingState());
    final failureOrUnit = await updatePayment(payment);
    failureOrUnit.fold(
        (failure) =>
            emit(UpdatePaymentErrorState(mapFailureToMessage(failure))), (r) {
      getAllPaymentsCubit();
      navigateAndFinish(context, const CheckOutPage());
      emit(UpdatePaymentSuccessState());
    });
  }

  void deletePaymentCubit(String uId) async {
    emit(DeletePaymentLoadingState());
    final failureOrUnit = await deletePayment(uId);
    failureOrUnit.fold(
        (failure) =>
            emit(DeletePaymentErrorState(mapFailureToMessage(failure))),
        (r) => emit(DeletePaymentSuccessState()));
  }
}
