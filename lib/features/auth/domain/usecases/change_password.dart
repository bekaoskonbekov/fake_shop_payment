import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class ChangePassword {
  final UserRepository repository;

  ChangePassword(this.repository);

  Future<Either<Failure, Unit>> call(
      {required String oldPassword, required String newPassword}) async {
    return repository.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }
}
