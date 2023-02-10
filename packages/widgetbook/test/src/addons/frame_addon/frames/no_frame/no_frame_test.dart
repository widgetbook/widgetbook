import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../../helper/widget_test_helper.dart';
import '../../../utils/extensions/widget_tester_extension.dart';

void main() {
  group(
    '$NoFrame',
    () {
      const key = ValueKey('key');
      testWidgets(
        'overrides $MediaQuery',
        (tester) async {
          tester.binding.window.physicalSizeTestValue = const Size(800, 600);
          final frame = NoFrame();
          await tester.pumpWidgetWithMaterialApp(
            Builder(
              builder: (context) {
                return frame.builder(
                  context,
                  const Text(
                    'Text',
                    key: key,
                  ),
                );
              },
            ),
          );

          final context = tester.findContextByKey(key);
          final mediaQuery = MediaQuery.of(context);
          final window = tester.binding.window;

          expect(
            mediaQuery.size.width,
            equals(window.physicalSize.width / window.devicePixelRatio),
          );

          expect(
            mediaQuery.size.height,
            equals(window.physicalSize.height / window.devicePixelRatio),
          );

          expect(
            mediaQuery.devicePixelRatio,
            equals(window.devicePixelRatio),
          );
        },
      );
    },
  );
}
