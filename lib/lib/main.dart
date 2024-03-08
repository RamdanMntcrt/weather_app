import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/lib/di/injection_container.dart';
import 'package:weather_app/lib/resources/route_helper.dart';

void main() {
  initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, child) => const MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
