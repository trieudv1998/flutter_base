import 'package:flutter_base/data/repository/home_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';
import 'domain/repository/home_repository.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  await getIt.init();
  getIt.registerSingleton<HomeRepository>(HomeRepositoryImpl());
}
