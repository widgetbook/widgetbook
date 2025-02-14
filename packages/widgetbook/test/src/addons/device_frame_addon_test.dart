import 'package:flutter/material.dart';
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
        'when device is $NoneDevice, '
        'then [buildUseCase] returns child as-is',
        () {
          const child = Text('child');
          final setting = DeviceFrameSetting(
            device: NoneDevice.instance,
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

      testWidgets(
        'given a use-case that has a dialog, '
        'when the dialog is opened, '
        'then it is show inside the [DeviceFrame]',
        (tester) async {
          final device = devices.last;

          await tester.pumpWidgetWithBuilder(
            (context) => addon.buildUseCase(
              context,
              Builder(
                builder: (context) {
                  return TextButton(
                    onPressed: () {
                      showDialog<void>(
                        useRootNavigator: false,
                        context: context,
                        builder: (context) => const Placeholder(),
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
              DeviceFrameSetting(
                device: device,
              ),
            ),
          );

          await tester.findAndTap(find.byType(TextButton));

          expect(
            find.descendant(
              of: find.byType(DeviceFrame),
              matching: find.byType(Placeholder),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'given a use-case that has a bottom modal sheet, '
        'when the dialog is opened, '
        'then it is show inside the [DeviceFrame]',
        (tester) async {
          final device = devices.last;

          await tester.pumpWidgetWithBuilder(
            (context) => addon.buildUseCase(
              context,
              Builder(
                builder: (context) {
                  return TextButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (context) => const Placeholder(),
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
              DeviceFrameSetting(
                device: device,
              ),
            ),
          );

          await tester.findAndTap(find.byType(TextButton));

          expect(
            find.descendant(
              of: find.byType(DeviceFrame),
              matching: find.byType(Placeholder),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'given a use-case, '
        'then the background is set to [scaffoldBackgroundColor]',
        (tester) async {
          final device = devices.last;
          const color = Color(0xff123456);

          await tester.pumpWidgetWithBuilder(
            (context) => Theme(
              data: Theme.of(context).copyWith(
                scaffoldBackgroundColor: color,
              ),
              child: addon.buildUseCase(
                context,
                const SizedBox(),
                DeviceFrameSetting(
                  device: device,
                ),
              ),
            ),
          );

          expect(find.byType(ColoredBox).last, paints..rect(color: color));
        },
      );
    },
  );
}
