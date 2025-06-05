/// A complete example for Widgetbook manual approach
///
/// Use [WidgetbookFolder],[WidgetbookComponent], and [WidgetbookUseCase]
/// to create directories
/// [Ref link]: https://docs.widgetbook.io/guides/complete-example
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart' hide AlignmentAddon;

import 'customs/custom_addon.dart';
import 'homepage.dart';
import 'widgetbook.generator.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        DeviceFrameAddon(devices: Devices.ios.all),
        InspectorAddon(),
        GridAddon(100),
        AlignmentAddon(),
        ZoomAddon(),
      ],
      directories: directories,
      home: const Homepage(),
    );
  }
}
