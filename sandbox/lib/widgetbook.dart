import 'package:flutter/material.dart';
import 'package:widgetbook/next.dart' as next;
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
      directories: components,
      integrations: [
        WidgetbookCloudIntegration(),
      ],
      addons: [
        next.AccessibilityAddon(),
        next.TimeDilationAddon(),
        next.DeviceFrameAddon([
          Devices.ios.iPhoneSE,
          Devices.ios.iPhone12,
          Devices.ios.iPhone13,
        ]),
        next.MaterialThemeAddon({
          'Dark': Themes.dark,
          'Light': Themes.light,
        }),
        next.GridAddon(),
        next.AlignmentAddon(),
        next.TextScaleAddon(),
        next.LocaleAddon(
          [const Locale('en', 'US')],
          [
            DefaultWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate,
          ],
        ),
        next.BuilderAddon(
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
