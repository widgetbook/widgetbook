import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/addons/frame_addon/addons/device_addon/device_provider.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../../helper/widget_test_helper.dart';
import '../../../utils/addons.dart';
import '../../../utils/extensions/widget_tester_extension.dart';

void main() {
  group(
    '$DefaultDeviceFrame',
    () {
      testWidgets(
        'overrides $MediaQuery',
        (tester) async {
          const phone = Apple.iPhone13;
          final devices = [phone];
          final frame = DefaultDeviceFrame(
            setting: DeviceSetting.firstAsSelected(
              devices: devices,
            ),
          );
          await tester.pumpWidgetWithMaterialApp(
            ChangeNotifierProvider(
              create: (c) => DeviceProvider(
                DeviceSetting(devices: devices, activeDevice: phone),
              ),
              child: Builder(
                builder: (context) {
                  return frame.builder(
                    context,
                    const Text(
                      'Text',
                      key: textKey,
                    ),
                  );
                },
              ),
            ),
          );

          final context = tester.findContextByKey(textKey);
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
