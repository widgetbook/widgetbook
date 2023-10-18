// widgetbook.dart

import 'package:cookbook1/widgetbook.directories.g.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the generated directories variable

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // Use the generated directories variable
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: ThemeData.light()
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: ThemeData.dark()
            ),
          ],
        ),
        TextScaleAddon(
          scales: [1.0, 2.0, 3.0],
          initialScale: 1,
        ),
        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone13,
          ],
          initialDevice: Devices.ios.iPhone13,
        ),
      ],
    );
  }
}
