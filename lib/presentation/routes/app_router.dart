import 'package:flutter/material.dart';
import 'package:flutter_base/di.dart';
import 'package:flutter_base/presentation/routes/route_name.dart';
import 'package:flutter_base/presentation/screen/home/cubit/home_cubit.dart';
import 'package:flutter_base/presentation/screen/home/home_screen.dart';
import 'package:flutter_base/presentation/screen/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
    Widget initialWidget = const HomeScreen();
    Widget routeWidget = initialWidget;

    switch (routeSettings.name) {
      case RouteName.rootScreen:
        routeWidget = const SplashScreen();
        break;
      case RouteName.home:
        routeWidget = BlocProvider(
            create: (context) {
              return HomeCubit();
            },
            child: initialWidget);
        break;
      default:
        routeWidget;
        break;
    }
    return MaterialPageRoute(
      builder: (_) => routeWidget,
      settings: routeSettings,
    );
  }
}
