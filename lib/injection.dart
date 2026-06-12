import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'api/auth_api.dart';
import 'api/case_api.dart';
import 'api/dashboard_api.dart';
import 'api/user_api.dart';
import 'controllers/auth_controller.dart';
import 'controllers/case_controller.dart';
import 'controllers/dashboard_controller.dart';
import 'controllers/user_controller.dart';
import 'services/auth_service.dart';
import 'services/case_service.dart';
import 'services/dashboard_service.dart';
import 'services/storage_service.dart';
import 'services/user_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  final dio = Dio();
  const secureStorage = FlutterSecureStorage();
  final storageService = StorageService(secureStorage);

  getIt.registerLazySingleton<StorageService>(() => storageService);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await storageService.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
    ),
  );

  getIt.registerLazySingleton<AuthApi>(() => AuthApi(dio));
  getIt.registerLazySingleton<UserApi>(() => UserApi(dio));
  getIt.registerLazySingleton<CaseApi>(() => CaseApi(dio));
  getIt.registerLazySingleton<DashboardApi>(() => DashboardApi(dio));

  getIt.registerLazySingleton<AuthService>(
    () => AuthService(getIt<AuthApi>(), getIt<StorageService>()),
  );
  getIt.registerLazySingleton<UserService>(() => UserService(getIt<UserApi>()));
  getIt.registerLazySingleton<CaseService>(() => CaseService(getIt<CaseApi>()));
  getIt.registerLazySingleton<DashboardService>(
    () => DashboardService(getIt<DashboardApi>()),
  );

  // Controllers
  getIt.registerLazySingleton<AuthController>(
    () => AuthController(getIt<AuthService>()),
  );
  getIt.registerLazySingleton<DashboardController>(
    () => DashboardController(getIt<DashboardService>()),
  );
  getIt.registerLazySingleton<UserController>(
    () => UserController(getIt<UserService>()),
  );
  getIt.registerLazySingleton<CaseController>(
    () => CaseController(getIt<CaseService>()),
  );
}
