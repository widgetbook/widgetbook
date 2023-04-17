import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/src/addons/device_addon/frames/no_frame.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../helper/widget_test_helper.dart';
import '../../utils/extensions/widget_tester_extension.dart';

void main() {
  group(
    '$NoFrameBuilder',
    () {
      const key = ValueKey('key');
      testWidgets(
        'overrides $MediaQuery',
        (tester) async {
          tester.binding.window.physicalSizeTestValue = const Size(800, 600);

          final frame = NoFrameBuilder(
            setting: DeviceSetting.firstAsSelected(
              devices: [null],
            ),
          );

          await tester.pumpWidgetWithMaterialApp(
            Builder(
              builder: (context) {
                return frame.build(
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
