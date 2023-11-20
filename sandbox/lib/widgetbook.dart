import 'package:flutter/material.dart';
import 'package:widgetbook/src/themes.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'text.stories.dart';
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
      directories: [...directories, $Text],
      integrations: [
        WidgetbookCloudIntegration(),
      ],
      addons: [
        AccessibilityAddon(),
        TimeDilationAddon(),
        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone12,
            Devices.ios.iPhone13,
          ],
        ),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Dark',
              data: Themes.dark,
            ),
          ],
        ),
        GridAddon(),
        AlignmentAddon(),
        TextScaleAddon(
          scales: [1.0, 2.0],
        ),
        LocalizationAddon(
          locales: [
            const Locale('en', 'US'),
          ],
          localizationsDelegates: [
            DefaultWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate,
          ],
        ),
        BuilderAddon(
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
