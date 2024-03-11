import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/lib/resources/utils/color_constants.dart';

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
        width: 70.sp,
        decoration: BoxDecoration(
            color: ClrConst.whiteClr.withOpacity(0.2),
            border: Border.all(
                width: 2.sp, color: ClrConst.whiteClr.withOpacity(0.3)),
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
