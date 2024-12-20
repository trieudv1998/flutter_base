import 'package:flutter_base/core/services/logger_service.dart';
import 'package:flutter_base/infrastructure/repositories/auth_repository.dart';
import 'package:flutter_base/infrastructure/repositories/home_repository.dart';
import 'package:flutter_base/infrastructure/services/logger_service_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'core/repositories/auth_repository.dart';
import 'core/repositories/home_repository.dart';
import 'core/services/shared_preferences_service.dart';
import 'di.config.dart';
import 'infrastructure/services/shared_preferences_service_impl.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  await getIt.init();

  // repository
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // services
  getIt.registerLazySingleton<LoggerService>(() => LoggerServiceImpl());
  getIt.registerLazySingleton<SharedPreferencesService>(() => SharedPreferencesServiceImpl());

}
