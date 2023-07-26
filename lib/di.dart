import 'package:flutter_base/infrastructure/repositories/auth_repository.dart';
import 'package:flutter_base/infrastructure/repositories/home_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  await getIt.init();

  // repository
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepository());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());

}
