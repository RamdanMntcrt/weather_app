import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/resources/route_helper.dart';

import 'bloc/connectivity_bloc/connectivity_bloc.dart';
import 'di/injection_container.dart';


void main() {
  initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ConnectivityBloc connectivityBloc = sl.get<ConnectivityBloc>();
    connectivityBloc.add(CheckConnectivityET());
    RouteGenerator routeGenerator = RouteGenerator();
    return BlocProvider(
      create: (context) => connectivityBloc,
      child: BlocListener<ConnectivityBloc, ConnectivityState>(
        listener: (context, state) {
          if (state is NoConnectionST) {
            Fluttertoast.showToast(msg: 'No internet connection');
          }
        },
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (_, child) => MaterialApp(
            theme: ThemeData(
              fontFamily: 'Manrope',
            ),
            title: 'Flutter Demo',
            onGenerateRoute: routeGenerator.generateRoute,
            initialRoute: '/',
          ),
        ),
      ),
    );
  }
}
