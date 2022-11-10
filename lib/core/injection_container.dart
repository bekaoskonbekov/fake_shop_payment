import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/auth/data/datasources/user_local_data_source.dart';
import '../features/auth/data/datasources/user_remote_data_source.dart';
import '../features/auth/data/repositories/user_repository_impl.dart';
import '../features/auth/domain/repositories/user_repository.dart';
import '../features/auth/domain/usecases/change_password.dart';
import '../features/auth/domain/usecases/get_profile.dart';
import '../features/auth/domain/usecases/log_in_usecase.dart';
import '../features/auth/domain/usecases/log_out_usecase.dart';
import '../features/auth/domain/usecases/sign_up_usecase.dart';
import '../features/auth/domain/usecases/update_profile.dart';
import '../features/auth/presentation/cubit/user_cubit.dart';
import '../features/cart/data/datasources/cart_local_database.dart';
import '../features/cart/data/repositories/cart_repository_impl.dart';
import '../features/cart/domain/repositories/cart_repository.dart';
import '../features/cart/domain/usecases/add_payment_usecase.dart';
import '../features/cart/domain/usecases/create_payment_database_usecase.dart';
import '../features/cart/domain/usecases/delete_payment_usecase.dart';
import '../features/cart/domain/usecases/get_all_payment_usecase.dart';
import '../features/cart/domain/usecases/update_payment_usecase.dart';
import '../features/cart/presentation/cubit/cart_cubit.dart';
import '../features/product/data/datasources/product_local_database.dart';
import '../features/product/data/datasources/remote_product_database.dart';
import '../features/product/data/repositories/product_repository_empl.dart';
import '../features/product/domain/repositories/product_repository.dart';
import '../features/product/domain/usecases/add_product_usecase.dart';
import '../features/product/domain/usecases/delete_product_usecase.dart';
import '../features/product/domain/usecases/get_all_category.dart';
import '../features/product/domain/usecases/get_all_products_usecase.dart';
import '../features/product/domain/usecases/get_product_usecase.dart';
import '../features/product/domain/usecases/update_product_usecase.dart';
import '../features/product/presentation/cubit/product_cubit.dart';
import 'network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // cubit product
  sl.registerFactory(() => ProductCubit(
      getAllProductsUseCase: sl(),
      getAllCategoryUseCase: sl(),
      getProductUseCase: sl(),
      addProductUseCase: sl(),
      updateProductUseCase: sl(),
      deleteProductUseCase: sl()));

  // UseCase product
  sl.registerLazySingleton(() => GetAllProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCategoryUseCase(sl()));
  sl.registerLazySingleton(() => AddProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(sl()));

// Repository product
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      remoteDataBase: sl(), localDataBase: sl(), networkInfo: sl()));

  // DataSources product
  sl.registerLazySingleton<ProductRemoteDataBase>(
      () => ProductRemoteDataBaseImpl());
  sl.registerLazySingleton<ProductLocalDataBase>(
      () => ProductLocalDataBaseImpl());

  // cubit user
  sl.registerFactory(() => UserCubit(logIn: sl(), signUp: sl(), logOut: sl()));

  // UseCase user
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LogInUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUseCase(sl()));
  sl.registerLazySingleton(() => ChangePassword(sl()));
  sl.registerLazySingleton(() => UpdateProfileUpUseCase(sl()));
  sl.registerLazySingleton(() => GetProfile(sl()));

  // Repository user
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // DataSources user
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceWithDio());
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceWithDio());

  // cubit cart
  sl.registerFactory(() => CartCubit(
      getAllPayment: sl(),
      createPaymentDataBase: sl(),
      addPayment: sl(),
      updatePayment: sl(),
      deletePayment: sl()));

  // UseCase cart
  sl.registerLazySingleton(() => CreatePaymentDataBaseUseCase(sl()));
  sl.registerLazySingleton(() => GetAllPaymentUseCase(sl()));
  sl.registerLazySingleton(() => AddPaymentUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePaymentUseCase(sl()));
  sl.registerLazySingleton(() => DeletePaymentUseCase(sl()));

  // Repository cart
  sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(localDataBase: sl()));

  // DataSources cart
  sl.registerLazySingleton<PaymentLocalDataBase>(
      () => PaymentLocalDataBaseFromSqfLite());

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
