import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateProfileUpUseCase {
  final UserRepository repository;

  UpdateProfileUpUseCase(this.repository);

  Future<Either<Failure, User>> updateProfile({required User user}) async {
    return await repository.updateProfile(user: user);
  }
}
