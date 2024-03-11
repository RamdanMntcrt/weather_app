import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherWidget extends StatelessWidget {
  final String city, desc, temp, icon;

  const WeatherWidget(
      {super.key,
      required this.city,
      required this.desc,
      required this.temp,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Column(
        children: [
          Text(
            city,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
              height: 100.sp,
              child: Image.asset(
                icon,
                fit: BoxFit.fill,
              )),
          SizedBox(height: 10.h),
          Text(
            "$temp \u2103",
            style: const TextStyle(fontSize: 22),
          ),
          SizedBox(height: 10.h),
          SizedBox(
              width: 320.w,
              child: Center(
                  child: Text(
                desc,
                style: const TextStyle(fontSize: 18),
              )))
        ],
      ),
    );
  }
}
