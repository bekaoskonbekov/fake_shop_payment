import 'package:dartz/dartz.dart';

import '../../../../core/dio/cache_helper.dart';

abstract class UserLocalDataSource {
  Future<Unit> saveToken({required String token});
  Future<String> getToken();
  Future<Unit> deleteToken({required String token});
}

class UserLocalDataSourceWithDio implements UserLocalDataSource {
  @override
  Future<String> getToken() async {
    String uId = await CacheHelper.getData(key: "uId");
    return uId;
  }

  @override
  Future<Unit> saveToken({required String token}) async {
    await CacheHelper.saveData(key: 'uId', value: token);
    return Future.value(unit);
  }

  @override
  Future<Unit> deleteToken({required String token}) async {
    await CacheHelper.removeData(key: "uId");
    return Future.value(unit);
  }
}
