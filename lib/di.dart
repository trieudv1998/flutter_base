import 'package:flutter_base/core/application/data_sources/implementations/home_datasource_impl.dart';
import 'package:flutter_base/core/application/data_sources/interfaces/home_datasource.dart';
import 'package:flutter_base/infrastructure/repositories/implementations/home_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';
import 'infrastructure/repositories/interfaces/home_repository.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  await getIt.init();
  // data source
  getIt.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl());

  // repository
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(homeDataSource: getIt()));
}
