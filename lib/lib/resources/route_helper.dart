import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/lib/bloc/splash_bloc/splash_bloc.dart';

import '../screens/home_screen/home_screen.dart';

import '../screens/splash_screen.dart';

final SplashBloc _splashBloc = SplashBloc();

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        _splashBloc.add(NavigationEvent());
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _splashBloc, child: SplashScreen()));

      case '/Home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return _errorRoute();
    }
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
}
