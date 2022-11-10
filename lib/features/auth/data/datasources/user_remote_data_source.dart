import 'package:dartz/dartz.dart';

import '../../../../core/dio/dio_helper.dart';
import '../../../../core/dio/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/strings/app_string.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<Unit> logIn({required String email, required String password});
  Future<Unit> signUp(
      {required String name, required String email, required String password});

  Future<Unit> logOut();
  Future<Unit> changePassword(
      {required String oldPassword, required String newPassword});
  Future<UserModel> getProfile();
  Future<UserModel> updateProfile({required UserModel userModel});
}

class UserRemoteDataSourceWithDio implements UserRemoteDataSource {
  @override
  Future<Unit> logIn({required String email, required String password}) async {
    final body = {
      "email": email,
      "password": password,
    };
    final response = await DioHelper.postData(url: login, data: body);
    print("responce.statuscode = ${response.statusCode}");
    AppString.userToken = response.data["data"]["token"];
    print("token is ${AppString.userToken = response.data["data"]["token"]}");
    if (response.statusCode == 200) {
      await DioHelper.init(null);
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final body = {
      "email": email,
      "name": name,
      "password": password,
      "image": "",
      "phone": "",
    };
    final response = await DioHelper.postData(url: register, data: body);
    print("responce.statuscode = ${response.statusCode}");
    if (response.statusCode == 200) {
      await DioHelper.init(null);
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> changePassword(
      {required String oldPassword, required String newPassword}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future<Unit> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<UserModel> updateProfile({required UserModel userModel}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  // @override
  // Future<Unit> logOut() async {
  //   final body = {"fcm_token": "Thank you to use app"};
  //   await DioHelper.init(baseUrlAuth);
  //   final response = await DioHelper.postData(
  //       url: logout, data: body, token: AppString.userToken);
  //   if (response.statusCode == 200) {
  //     return Future.value(unit);
  //   } else {
  //     throw ServerException();
  //   }
  // }

  // @override
  // Future<Unit> changePassword(
  //     {required String oldPassword, required String newPassword}) async {
  //   final body = {
  //     "current_password": oldPassword,
  //     "new_password": newPassword,
  //   };
  //   await DioHelper.init(baseUrlAuth);
  //   final response = await DioHelper.postData(
  //       url: changePasswordUrl, data: body, token: AppString.userToken);
  //   if (response.statusCode == 200) {
  //     return Future.value(unit);
  //   } else {
  //     throw ServerException();
  //   }
  // }

  // @override
  // Future<UserModel> getProfile() async {
  //   await DioHelper.init(baseUrlAuth);
  //   final response =
  //       await DioHelper.getData(url: profile, token: AppString.userToken);
  //   if (response.statusCode == 200) {
  //     UserModel user = UserModel.fromJson(response.data["data"]);
  //     return Future.value(user);
  //   } else {
  //     throw ServerException();
  //   }
  // }

  // @override
  // Future<UserModel> updateProfile({required UserModel userModel}) async{
  //   final body = {
  //     "name": userModel.name,
  //     "phone": userModel.phone,
  //     "email": userModel.email,

  //     ///ToDO:add image
  //     //  "image": userModel.,
  //   };
  //   await DioHelper.init(baseUrlAuth);
  //   final response = await DioHelper.putData(
  //       url: updateProfileUrl, token: AppString.userToken, data: body);
  //   if (response.statusCode == 200) {
  //     UserModel user = UserModel.fromJson(response.data["data"]);
  //     return Future.value(user);
  //   } else {
  //     throw ServerException();
  //   }
  // }

}
