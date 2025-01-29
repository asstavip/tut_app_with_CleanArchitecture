import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:flutter_advanced/app/app_prefs.dart';
import 'package:flutter_advanced/data/network/dio_factory.dart';
import 'package:flutter_advanced/domain/usecase/forget_password_usecase.dart';
import 'package:flutter_advanced/domain/usecase/login_usecase.dart';
import 'package:flutter_advanced/domain/usecase/register_usecase.dart';
import 'package:flutter_advanced/presentation/forgot_password/forgot_password_view_model.dart';
import 'package:flutter_advanced/presentation/register/register_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../presentation/login/login_view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  /// app module, its a module where we put all generic dependencies
  /// that can be used in the whole application

  // shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // app prefs instance as you see you can put only instance and it solve it for you
  instance.registerLazySingleton<AppPreferences>(() =>
      AppPreferences(instance<SharedPreferences>())); // shared preferences
  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));
  // dio
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance<AppPreferences>()));
  Dio dio = await instance<DioFactory>().getDio();
  // App Service Client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImplementer(instance<AppServiceClient>()));

  // repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance<RemoteDataSource>(), instance<NetworkInfo>()));
  
}

Future<void> initLoginModule() async {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory(() => LoginUseCase(instance<Repository>()));
    instance.registerFactory(() => LoginViewModel(instance()));
  }
}

initForgotPasswordModule(){
  if(!GetIt.I.isRegistered<ForgetPasswordUseCase>()){
    instance.registerFactory<ForgetPasswordUseCase>(() => ForgetPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(() => ForgotPasswordViewModel(instance()));
  }
}

initRegisterModule(){
  if(!GetIt.I.isRegistered<RegisterUsecase>()){
    instance.registerFactory<RegisterUsecase>(() => RegisterUsecase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
  }
}