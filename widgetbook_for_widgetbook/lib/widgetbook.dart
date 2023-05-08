import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_core/widgetbook_core.dart';

import 'widgetbook.g.dart';

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
          Devices.ios.iPhoneSE,
          Devices.ios.iPhone12,
          Devices.ios.iPhone13,
        ],
      ),
    );
  }
}
