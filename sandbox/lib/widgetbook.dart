import 'package:flutter/material.dart';
import 'package:widgetbook/next.dart';
import 'package:widgetbook/src/themes.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'next/types_table.stories.dart';
import 'widgetbook.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        ...directories,
        TypesTableComponent,
      ],
      integrations: [
        WidgetbookCloudIntegration(),
      ],
      addons: [
        AccessibilityMode(),
        TimeDilationMode(),
        DeviceFrameMode(
          devices: [
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone12,
            Devices.ios.iPhone13,
          ],
        ),
        MaterialThemeMode(
          initialTheme: Themes.dark,
          themes: {
            'Light': Themes.light,
            'Dark': Themes.dark,
          },
        ),
        GridMode(),
        AlignmentMode(),
        TextScaleMode(
          scales: [1.0, 2.0],
        ),
        LocalizationMode(
          locales: [
            const Locale('en', 'US'),
          ],
          localizationsDelegates: [
            DefaultWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate,
          ],
        ),
        BuilderMode(
          name: 'Bounds',
          builder: (context, child) => Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
