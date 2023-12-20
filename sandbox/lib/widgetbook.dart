import 'package:flutter/material.dart';
import 'package:widgetbook/next.dart';
import 'package:widgetbook/src/themes.dart';
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
      integrations: [
        WidgetbookCloudIntegration(),
      ],
      addons: [
        AccessibilityAddon(),
        TimeDilationAddon(),
        DeviceFrameAddon([
          Devices.ios.iPhoneSE,
          Devices.ios.iPhone12,
          Devices.ios.iPhone13,
        ]),
        MaterialThemeAddon({
          'Dark': Themes.dark,
          'Light': Themes.light,
        }),
        GridAddon(),
        AlignmentAddon(),
        TextScaleAddon(),
        LocaleAddon(
          [const Locale('en', 'US')],
          [
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
