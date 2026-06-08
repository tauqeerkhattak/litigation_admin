import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'api/auth_api.dart';
import 'services/auth_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  final dio = Dio();
  // Optional: Add interceptors for logging or token handling here
  // dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  getIt.registerLazySingleton<AuthApi>(() => AuthApi(dio));
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<AuthApi>()));
}
