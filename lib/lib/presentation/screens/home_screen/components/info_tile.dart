import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoTile extends StatelessWidget {
  final String title, icon, value;

  const InfoTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        width: 70.w,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            border: Border.all(width: 2.sp, color: Colors.white30),
            borderRadius: BorderRadius.circular(12.sp)),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(title),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(height: 40.h, child: Image.asset(icon)),
            SizedBox(
              height: 20.h,
            ),
            Text(value)
          ],
        ),
      ),
    );
  }
}
