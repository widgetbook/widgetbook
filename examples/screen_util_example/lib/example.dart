import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'show screen height and width',
  type: ScreenUtilExample,
)
Widget exampleBuilder(BuildContext context) {
  return const ScreenUtilExample();
}

/// An example [Widget] that uses [ScreenUtil].
class ScreenUtilExample extends StatelessWidget {
  const ScreenUtilExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Scale height: ${ScreenUtil().screenHeight}',
            style: TextStyle(fontSize: 40.sp),
          ),
          Text(
            'Scale width: ${ScreenUtil().screenWidth}',
            style: TextStyle(fontSize: 40.sp),
          ),
        ],
      ),
    );
  }
}
