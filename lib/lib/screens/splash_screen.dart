import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/lib/resources/utils/color_constants.dart';

import '../bloc/splash_bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashBloc _splashBloc = SplashBloc();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      bloc: _splashBloc,
      listener: (context, state) {
        if (state is SplashNavigateST) {
          Navigator.pushNamed(context, '/Home');
        }
      },
      child: Scaffold(
        backgroundColor: ClrConst.accentColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: SizedBox(
                          height: 280.h,
                          child: Image.asset('assets/png/splash_icon.png'))
                      .animate()
                      .scale(duration: const Duration(milliseconds: 700))),
              SizedBox(
                height: 50.h,
              ),
              const CupertinoActivityIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
