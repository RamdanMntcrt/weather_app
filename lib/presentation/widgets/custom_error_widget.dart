import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/utils/color_constants.dart';
import '../../resources/utils/string_constants.dart';
import 'custom_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title, page;

  const CustomErrorWidget({super.key, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Container(
        width: 200.w,
        height: 250.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ClrConst.whiteClr,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 250.sp,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            CustomButton(
              onPressed: () {
                if (page == StrConst.searchScreen) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
