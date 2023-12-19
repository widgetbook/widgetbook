import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook/next.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components.book.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      components: components,
      addons: [
        TextScaleAddon(),
        DeviceFrameAddon([
          Devices.ios.iPhoneSE,
          Devices.ios.iPhone12,
          Devices.ios.iPhone13,
        ]),
        BuilderAddon(
          name: 'ScreenUtil',
          builder: (context, child) {
            return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              // This is needed to use the workbench [MediaQuery]
              useInheritedMediaQuery: true,
              builder: (context, child) => child!,
              child: child,
            );
          },
        ),
      ],
    );
  }
}
