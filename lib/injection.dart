import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'api/auth_api.dart';
import 'api/case_api.dart';
import 'api/dashboard_api.dart';
import 'api/user_api.dart';
import 'services/auth_service.dart';
import 'services/case_service.dart';
import 'services/dashboard_service.dart';
import 'services/storage_service.dart';
import 'services/user_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  final dio = Dio()
    ..options = BaseOptions(
      baseUrl:
          "https://litigation-backend-74427736097.us-central1.run.app/api/v1/",
    );
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
}
