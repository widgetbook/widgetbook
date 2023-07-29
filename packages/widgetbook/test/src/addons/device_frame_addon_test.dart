import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../helper/helper.dart';

void main() {
  group(
    '$DeviceFrameAddon',
    () {
      final devices = [
        Devices.ios.iPhone12,
        Devices.ios.iPhone13,
        Devices.ios.iPhone13Mini,
      ];

      final addon = DeviceFrameAddon(
        devices: devices,
      );

      test(
        'given a query group, '
        'then [valueFromQueryGroup] can parse the value',
        () {
          final device = devices.last;
          final result = addon.valueFromQueryGroup({
            'name': device.name,
            'orientation': 'Landscape',
            'frame': 'Has Frame',
          });

          expect(result.device, equals(device));
          expect(result.orientation, equals(Orientation.landscape));
          expect(result.hasFrame, equals(true));
        },
      );

      test(
        'given a device frame setting, '
        'when device is null, '
        'then [buildUseCase] returns child as-is',
        () {
          const child = Text('child');
          final setting = DeviceFrameSetting(
            device: null,
          );

          final result = addon.buildUseCase(
            MockBuildContext(),
            child,
            setting,
          );

          expect(result, equals(child));
        },
      );

      testWidgets(
        'given a device frame setting, '
        'when device is null, '
        'then [buildUseCase] wraps child with [DeviceFrame] widget',
        (tester) async {
          final device = devices.last;
          await tester.pumpWidgetWithBuilder(
            (context) => addon.buildUseCase(
              context,
              const Text('child'),
              DeviceFrameSetting(
                device: device,
              ),
            ),
          );

          final deviceFrame = tester.widget<DeviceFrame>(
            find.byType(DeviceFrame),
          );

          expect(
            deviceFrame.device,
            equals(device),
          );
        },
      );
    },
  );
}
