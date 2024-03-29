import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/splash_bloc/splash_bloc.dart';
import '../../resources/utils/color_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateST) {
          Navigator.pushNamed(context, '/Home');
        }
      },
      child: Scaffold(
        backgroundColor: ClrConst.accentColor1,
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
