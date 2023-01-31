import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as anno;
import 'package:widgetbook_core/widgetbook_core.dart';

@anno.WidgetbookApp.material(
  name: 'Widgetbook',
  devices: [
    Apple.iPhone11,
    Apple.iPhone12,
    Apple.iPhone13,
  ],
  textScaleFactors: [
    1,
    2,
  ],
)
const int notUsed = 0;

@anno.WidgetbookTheme(name: 'Dark', isDefault: true)
ThemeData themeDark() => Themes.dark;

@anno.WidgetbookTheme(
  name: 'Light',
)
ThemeData themeLight() => Themes.light;

@anno.WidgetbookAppBuilder()
Widget customAppBuilder(BuildContext context, Widget child) {
  final frameBuilder = context.frameBuilder;
  return frameBuilder!(
    context,
    Builder(
      builder: (context) {
        return MaterialApp(
          theme: context.materialTheme,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: context.textScale,
              ),
              child: child,
            ),
          ),
        );
      },
    ),
  );
}
