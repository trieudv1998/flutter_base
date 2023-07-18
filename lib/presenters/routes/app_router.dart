import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_base/di.dart';
import 'package:flutter_base/presenters/pages/home/cubit/home_cubit.dart';
import 'package:flutter_base/presenters/pages/home/home_screen.dart';
import 'package:flutter_base/presenters/pages/login/login_screen.dart';
import 'package:flutter_base/presenters/routes/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
    Widget initialWidget = const HomeScreen();
    Widget _routeWidget = initialWidget;

    switch (routeSettings.name) {
      case RouteName.rootScreen:
        _routeWidget = BlocProvider(
            create: (context) {
              return HomeCubit(homeRepository: getIt());
            },
            child: initialWidget);
        break;
      case RouteName.login: //login screen
        _routeWidget = const LoginScreen();
        break;
      default:
        _routeWidget;
        break;
    }
    return MaterialPageRoute(
      builder: (_) => _routeWidget,
      settings: routeSettings,
    );
  }
}
