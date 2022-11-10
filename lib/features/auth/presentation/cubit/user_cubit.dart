import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/strings/map_failure_to_message.dart';
import '../../domain/usecases/log_in_usecase.dart';
import '../../domain/usecases/log_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignUpUseCase signUp;
  final LogInUseCase logIn;
  final LogOutUseCase logOut;
  UserCubit({
    required this.signUp,
    required this.logIn,
    required this.logOut,
  }) : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AddUserChangePasswordVisibilityState());
  }

  void signUpCubit({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoadingState());
    final failureOrDoneMessage =
        await signUp(name: name, email: email, password: password);
    failureOrDoneMessage.fold(
        (failure) => emit(SignUpErrorState(mapFailureToMessage(failure))),
        (r) => emit(SignUpSuccessState()));
  }

  void logInCubit({
    required String email,
    required String password,
  }) async {
    emit(LogInLoadingState());
    final failureOrDoneMessage = await logIn(email: email, password: password);
    failureOrDoneMessage.fold(
        (failure) => emit(LogInErrorState(mapFailureToMessage(failure))),
        (r) => emit(LogInSuccessState()));
  }

  void logOutCubit() async {
    final failureOrDoneMessage = await logOut();
    failureOrDoneMessage.fold(
        (failure) => emit(LogOutErrorState(mapFailureToMessage(failure))), (r) {
      return emit(LogOutSuccessState());
    });
  }
}
