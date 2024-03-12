import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../resources/utils/color_constants.dart';

class VoiceBottomSheet extends StatelessWidget {
  final bool? isListening;
  final String city;

  const VoiceBottomSheet(
      {super.key, required this.isListening, required this.city});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 300.sp,
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
            color: ClrConst.blackClr.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24.sp)),
        child: Column(
          children: [
            SizedBox(
              height: 30.sp,
            ),
            Text(
              'Tell me a City',
              style: TextStyle(
                  color: ClrConst.whiteClr,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30.sp,
            ),
            Text(
              city,
              style: TextStyle(
                color: ClrConst.whiteClr,
                fontSize: 26,
              ),
            ),
            SizedBox(
              height: 30.sp,
            ),
            SizedBox(
              height: 90.sp,
              width: 90.sp,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isListening == true)
                      SpinKitRipple(
                        size: 90.sp,
                        color: ClrConst.greyClr,
                      ),
                    Icon(
                      isListening == true
                          ? CupertinoIcons.mic_fill
                          : CupertinoIcons.mic,
                      color: ClrConst.whiteClr,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
