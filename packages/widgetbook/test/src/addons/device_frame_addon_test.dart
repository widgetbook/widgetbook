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
        'given a UseCase with knobs, '
        'when toggling between UseCases with DeviceFrameAddon, '
        'then knobs should be preserved',
        (tester) async {
          // Create a key to find our container widget
          final containerKey = GlobalKey();

          // Create a simple widget that uses a knob
          Widget buildKnobWidget(BuildContext context) {
            final color = context.knobs.color(
              label: 'Color',
              initialValue: Colors.red,
            );
            return Container(
              key: containerKey,
              color: color,
              height: 100,
              width: 100,
            );
          }

          // Create a test widget with WidgetbookState and DeviceFrameAddon
          final addon = DeviceFrameAddon(devices: [Devices.ios.iPhone13]);
          final setting = DeviceFrameSetting(
            device: Devices.ios.iPhone13,
            orientation: Orientation.portrait,
            hasFrame: true,
          );

          // Create a properly formatted knobs query parameter
          final knobsQueryParam =
              FieldCodec.encodeQueryGroup({'Color': 'FFFF0000'});

          // Create a WidgetbookState for testing
          final state = WidgetbookState(
            root: WidgetbookRoot(children: []),
            queryParams: {'knobs': knobsQueryParam},
          );

          // Build the widget tree with WidgetbookScope and DeviceFrameAddon
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: WidgetbookScope(
                  state: state,
                  child: Builder(
                    builder: (context) {
                      return addon.buildUseCase(
                        context,
                        Builder(builder: (context) => buildKnobWidget(context)),
                        setting,
                      );
                    },
                  ),
                ),
              ),
            ),
          );

          // Wait for the widget tree to settle
          await tester.pumpAndSettle();

          // Find our container widget
          final containerFinder = find.byKey(containerKey);

          // Verify that the container exists
          expect(containerFinder, findsOneWidget);

          // Get the Container widget
          final container = tester.widget<Container>(containerFinder);

          // Verify that the container's color is red (from the knob)
          expect(container.color, equals(const Color(0xFFFF0000)));
        },
      );
    },
  );
}
