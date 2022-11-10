import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class LogOutUseCase {
  final UserRepository userRepository;

  LogOutUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call() async {
    return await userRepository.logOut();
  }
}
