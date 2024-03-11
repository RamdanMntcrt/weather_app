import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/utils/color_constants.dart';

class LoadingWidget extends StatelessWidget {
  final String title;

  const LoadingWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Container(
        width: 200.sp,
        height: 150.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ClrConst.whiteClr,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20.sp),
            const CupertinoActivityIndicator()
          ],
        ),
      ),
    );
  }
}
