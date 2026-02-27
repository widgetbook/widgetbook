import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components.g.dart';

void main() {
  runWidgetbook(
    Config(
      components: components,
      addons: [
        ViewportAddon(Viewports.all),
        AlignmentAddon(),
        ZoomAddon(),
        MaterialThemeAddon({
          'Light': ThemeData.light(),
          'Dark': ThemeData.dark(),
        }),
      ],
    ),
  );
}
