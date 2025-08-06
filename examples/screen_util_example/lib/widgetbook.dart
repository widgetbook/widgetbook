import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook/widgetbook.dart';

import 'responsive_image.dart';
import 'screen_container.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
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
      directories: [
        WidgetbookComponent(
          name: '$ScreenContainer',
          useCases: [
            WidgetbookUseCase(
              name: 'Default',
              builder: (context) {
                return const ScreenContainer();
              },
            ),
          ],
        ),
        WidgetbookComponent(
          name: '$ResponsiveImage',
          useCases: [
            WidgetbookUseCase(
              name: 'Default',
              builder: (context) {
                return const ResponsiveImage(
                  url:
                      'https://images.nintendolife.com/bb503ef1f79ff/'
                      'ash-and-pikachu.original.jpg',
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
