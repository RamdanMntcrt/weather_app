import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/lib/bloc/splash_bloc/splash_bloc.dart';
import 'package:weather_app/lib/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/lib/presentation/screens/weather_search_screen/weather_search_screen.dart';

import '../di/injection_container.dart';
import '../presentation/screens/home_screen/home_screen.dart';
import '../presentation/screens/splash_screen.dart';

class RouteGenerator {
  final SplashBloc _splashBloc = sl.get<SplashBloc>();

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        _splashBloc.add(NavigationEvent());
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _splashBloc, child: const SplashScreen()));

      case '/Home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/SearchScreen':
        if (args != '' && args is String) {
          return CupertinoPageRoute(
              builder: (_) => WeatherSearchScreen(cityName: args));
        }
      default:
        return _errorRoute();
    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }

  void dispose() {
    _splashBloc.close();
  }
}
