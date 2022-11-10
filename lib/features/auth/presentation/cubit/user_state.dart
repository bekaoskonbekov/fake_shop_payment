part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

// all states exist in LogIn screen and Register screen
class AddUserChangePasswordVisibilityState extends UserState {}

/*
class AddUserChangeRadioButton extends UserState {}

class AddUserProfileImagePickedSuccessState extends UserState {}

class AddUserProfileImagePickedErrorState extends UserState {}
*/

// SingUp with email and password user states
class SignUpLoadingState extends UserState {}

class SignUpSuccessState extends UserState {}

class SignUpErrorState extends UserState {
  final String error;

  const SignUpErrorState(this.error);
}

// Create user states
class LogInLoadingState extends UserState {}

class LogInSuccessState extends UserState {}

class LogInErrorState extends UserState {
  final String error;

  const LogInErrorState(this.error);
}

class LogOutSuccessState extends UserState {}

class LogOutErrorState extends UserState {
  final String error;

  const LogOutErrorState(this.error);
}