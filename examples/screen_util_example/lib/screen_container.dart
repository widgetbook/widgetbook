import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Displays the Screen's Width and Height using [ScreenUtil].
class ScreenContainer extends StatelessWidget {
  const ScreenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil();

    return Container(
      color: Colors.lightGreen,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'H ${screenUtil.screenHeight.toInt()}',
              style: TextStyle(
                fontSize: 40.sp,
              ),
            ),
            Text(
              'W ${screenUtil.screenWidth.toInt()}',
              style: TextStyle(
                fontSize: 40.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
