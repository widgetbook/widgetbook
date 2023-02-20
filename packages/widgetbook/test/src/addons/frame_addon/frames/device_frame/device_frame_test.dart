import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../../helper/widget_test_helper.dart';
import '../../../utils/extensions/widget_tester_extension.dart';

void main() {
  const key = ValueKey('key');
  group(
    '$DefaultDeviceFrame',
    () {
      testWidgets(
        'overrides $MediaQuery',
        (tester) async {
          const phone = Apple.iPhone13;
          final addon = DeviceAddon(
            setting: DeviceSetting.firstAsSelected(
              devices: [
                phone,
              ],
            ),
          );

          final devices = [phone];
          final frame = DefaultDeviceFrame(
            setting: DeviceSetting.firstAsSelected(
              devices: devices,
            ),
          );
          await tester.pumpWidgetWithMaterialApp(
            Builder(
              builder: (context) {
                return addon.buildProvider(
                  context,
                  {
                    'device': phone.name,
                  },
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
              },
            ),
          );

          final context = tester.findContextByKey(key);
          final mediaQuery = MediaQuery.of(context);

          expect(
            mediaQuery.size.width,
            equals(phone.resolution.logicalSize.width),
          );

          expect(
            mediaQuery.size.height,
            equals(phone.resolution.logicalSize.height),
          );

          expect(
            mediaQuery.devicePixelRatio,
            equals(phone.resolution.scaleFactor),
          );
        },
      );
    },
  );
}
