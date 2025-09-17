import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components.book.dart';

void main() {
  runWidgetbook(
    Config(
      components: components,
      addons: [
        TextScaleAddon(),
        ViewportAddon([
          IosViewports.iPhoneSE,
          IosViewports.iPhone12,
          IosViewports.iPhone13,
        ]),
        BuilderAddon(
          name: 'ScreenUtil',
          builder: (context, child) {
            // flutter_screenutil must be version 3.9.1 or lower
            // to work properly with Widgetbook
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
    ),
  );
}
