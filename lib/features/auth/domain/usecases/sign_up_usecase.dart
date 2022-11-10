import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class SignUpUseCase{
  final UserRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, Unit>> call(
      {required String name, required String email, required String password})async{
    return await repository.signUp(name: name, email: email, password: password);
  }

}