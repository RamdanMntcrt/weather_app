import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/lib/resources/utils/color_constants.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;

  const CustomButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: 150.w,
        height: 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.sp),
            color: ClrConst.blackClr),
        child: Center(
          child: Text(
            'OK',
            style: TextStyle(color: ClrConst.whiteClr, fontSize: 20.sp),
          ),
        ),
      ),
    );
  }
}
