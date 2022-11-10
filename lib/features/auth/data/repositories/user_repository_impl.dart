import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/app_string.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> logIn(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource
            .logIn(email: email, password: password)
            .then((_) {
          localDataSource.saveToken(token: "${AppString.userToken}");
        });
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp(
      {required String name,
      required String email,
      required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource
            .signUp(name: name, email: email, password: password)
            .then((_) {
          localDataSource.saveToken(token: "${AppString.userToken}");
        });
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.logOut().then((_) {
          localDataSource.deleteToken(token: AppString.userToken!);
        });
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.changePassword(
            oldPassword: oldPassword, newPassword: newPassword);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        UserModel user = await remoteDataSource.getProfile();
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({required User user}) async {
    UserModel userModel = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        address: user.address,
        password: user.password,
        phone: user.phone);

    if (await networkInfo.isConnected) {
      try {
        UserModel user =
            await remoteDataSource.updateProfile(userModel: userModel);
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
