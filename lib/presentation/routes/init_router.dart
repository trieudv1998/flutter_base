
import 'package:flutter_base/core/domain/storages/global_storages.dart';
import 'package:flutter_base/presentation/pages/home/home_screen.dart';

class InitRoute {
  Future<void> getInitialRoute() async {
    GlobalStorage.initialRoute = const HomeScreen();
  }
}
