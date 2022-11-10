import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> signUp(
      {required String name, required String email, required String password});

  Future<Either<Failure, Unit>> logIn(
      {required String email, required String password});

  Future<Either<Failure, Unit>> logOut();
  Future<Either<Failure, Unit>> changePassword({required String oldPassword,required String newPassword});
  Future<Either<Failure, User>> getProfile();
  Future<Either<Failure, User>> updateProfile({required User user});
}
