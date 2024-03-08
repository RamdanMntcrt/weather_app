import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class WeatherWidget extends StatelessWidget {
  final String weather, desc;

  const WeatherWidget({super.key, required this.weather, required this.desc});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: 50.h,
      width: 200.w,
      color: Colors.grey.withOpacity(0.2),
      blur: 8,
      child: Column(
        children: [Text(weather), Text(desc)],
      ),
    );
  }
}
