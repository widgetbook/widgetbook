import 'template.dart';

class ConfigTemplate extends Template {
  ConfigTemplate()
    : super(
        'lib/widgetbook.config.dart',
        '''
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components.book.dart';

final config = Config(
  components: components,
  addons: [
    ViewportAddon([
      Viewports.none,
      IosViewports.iPhone13,
    ]),
    MaterialThemeAddon({
      'Light': ThemeData.light(),
      'Dark': ThemeData.dark(),
    }),
  ],
);
''',
      );
}
