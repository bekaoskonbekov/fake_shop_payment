import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetProfile {
  final UserRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, User>> call() async {
    return await repository.getProfile();
  }
}
