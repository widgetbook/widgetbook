import 'template.dart';

class TestTemplate extends Template {
  TestTemplate()
    : super(
        'test/widgetbook_test.dart',
        '''
import 'package:widgetbook/test.dart';
import 'package:widgetbook_workspace/widgetbook.config.dart';

Future<void> main() async {
  await testWidgetbook(config);
}
''',
      );
}
