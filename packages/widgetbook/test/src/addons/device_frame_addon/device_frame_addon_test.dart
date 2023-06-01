import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';

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
        initialDevice: devices.first,
      );

      testWidgets(
        'can activate device',
        (WidgetTester tester) async {
          final device = devices.last;

          await testAddon<DeviceFrameSetting>(
            tester: tester,
            addon: addon,
            act: () async {
              final dropdownFinder = find.byType(
                DropdownMenu<DeviceInfo?>,
              );

              await tester.tap(dropdownFinder);
              await tester.pumpAndSettle();

              final textFinder = find.byWidgetPredicate(
                (widget) => widget is Text && widget.data == device.name,
              );

              await tester.tap(textFinder.last);
              await tester.pumpAndSettle();
            },
            expect: (setting) => expect(
              setting.device,
              equals(device),
            ),
          );
        },
      );

      testWidgets(
        'can activate device $Orientation',
        (WidgetTester tester) async {
          await testAddon<DeviceFrameSetting>(
            tester: tester,
            addon: addon,
            act: () async {
              final dropdownFinder = find.byType(
                DropdownMenu<Orientation>,
              );

              await tester.tap(dropdownFinder);
              await tester.pumpAndSettle();

              final textFinder = find.byWidgetPredicate(
                (widget) => widget is Text && widget.data == 'Landscape',
              );

              await tester.tap(textFinder.last);
              await tester.pumpAndSettle();
            },
            expect: (setting) => expect(
              setting.orientation,
              equals(Orientation.landscape),
            ),
          );
        },
      );

      testWidgets(
        'can activate frame',
        (WidgetTester tester) async {
          await testAddon<DeviceFrameSetting>(
            tester: tester,
            addon: addon,
            act: () async {
              final dropdownFinder = find.byType(
                DropdownMenu<bool>,
              );

              await tester.tap(dropdownFinder);
              await tester.pumpAndSettle();

              final textFinder = find.byWidgetPredicate(
                (widget) => widget is Text && widget.data == 'None',
              );

              await tester.tap(textFinder.last);
              await tester.pumpAndSettle();
            },
            expect: (setting) => expect(
              setting.hasFrame,
              equals(false),
            ),
          );
        },
      );
    },
  );
}
