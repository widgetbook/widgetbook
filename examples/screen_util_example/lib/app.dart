import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_core/widgetbook_core.dart';

import 'app.widgetbook.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: configureMaterialAddons(
        themes: [
          WidgetbookTheme(
            name: 'Dark',
            data: Themes.dark,
          ),
          WidgetbookTheme(
            name: 'Dark',
            data: Themes.dark,
          ),
        ],
        textScales: [
          1.0,
          2.0,
        ],
        locales: [
          Locale('en', 'US'),
        ],
        localizationsDelegates: [
          DefaultWidgetsLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
        ],
        devices: [
          Apple.iPhone11,
          Apple.iPhone12,
          Apple.iPhone13,
        ],
      ),

      /// Customize your appBuilder function so the [ScreenUtilInit] widget is
      /// injected into the [Widget] tree.
      ///
      /// For more context on how to create the app builder see
      /// [materialAppBuilder] or have a look at the documentation.
      appBuilder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          // This is needed to use the workbench [MediaQuery]
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return MaterialApp(
              useInheritedMediaQuery: true,
              debugShowCheckedModeBanner: false,
              home: child,
            );
          },
          child: child,
        );
      },
    );
  }
}
