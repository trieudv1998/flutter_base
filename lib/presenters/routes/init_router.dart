

import 'package:flutter_base/core/storages/global_storages.dart';
import 'package:flutter_base/presenters/pages/home/home_screen.dart';

class InitRoute {
  Future<void> getInitialRoute() async {
    GlobalStorage.initialRoute = const HomeScreen();
  }
}
