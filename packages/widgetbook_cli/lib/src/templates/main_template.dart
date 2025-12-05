import 'template.dart';

class MainTemplate extends Template {
  MainTemplate()
    : super(
        'lib/main.dart',
        '''
import 'package:widgetbook/widgetbook.dart';

import 'widgetbook.config.dart';

void main() {
  runWidgetbook(config);
}
''',
      );
}
