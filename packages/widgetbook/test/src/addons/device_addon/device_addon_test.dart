import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utils/addon_test_helper.dart';

void main() {
  group(
    '$DeviceAddon',
    () {
      final devices = [
        Apple.iPhone12,
        Apple.iPhone13,
        Apple.iPhone13Mini,
      ];

      final addon = DeviceAddon(
        devices: devices,
        initialDevice: devices.first,
      );

      final setting = addon.value;

      group('context has', () {
        testWidgets(
          'device',
          (WidgetTester tester) async {
            await testAddon(
              tester: tester,
              addon: addon,
              expect: (context) => expect(
                context.device,
                equals(addon.value.activeDevice),
              ),
            );
          },
        );

        testWidgets(
          'orientation',
          (WidgetTester tester) async {
            await testAddon(
              tester: tester,
              addon: addon,
              expect: (context) => expect(
                context.orientation,
                equals(addon.value.orientation),
              ),
            );
          },
        );
      });

      group('Device can be activated via', () {
        testWidgets(
          'onChanged',
          (WidgetTester tester) async {
            final device = devices.first;

            await testAddon(
              tester: tester,
              addon: addon,
              act: () async => addon.onChanged(
                setting.copyWith(
                  activeDevice: device,
                ),
              ),
              expect: (context) => expect(
                context.device,
                equals(device),
              ),
            );
          },
        );

        testWidgets(
          'widget',
          (WidgetTester tester) async {
            final device = devices.last;

            await testAddon(
              tester: tester,
              addon: addon,
              act: () async {
                final dropdownFinder = find.byType(
                  DropdownMenu<Device?>,
                );

                await tester.tap(dropdownFinder);
                await tester.pumpAndSettle();

                final textFinder = find.byWidgetPredicate(
                  (widget) => widget is Text && widget.data == device.name,
                );

                await tester.tap(textFinder.last);
                await tester.pumpAndSettle();
              },
              expect: (context) => expect(
                context.device,
                equals(device),
              ),
            );
          },
        );
      });

      group(
        '$Orientation can be activated via',
        () {
          testWidgets(
            'onChanged',
            (WidgetTester tester) async {
              await testAddon(
                tester: tester,
                addon: addon,
                act: () async => addon.onChanged(
                  setting.copyWith(
                    orientation: Orientation.landscape,
                  ),
                ),
                expect: (context) => expect(
                  context.orientation,
                  equals(Orientation.landscape),
                ),
              );
            },
          );

          testWidgets(
            'widget',
            (WidgetTester tester) async {
              await testAddon(
                tester: tester,
                addon: addon,
                act: () async {
                  final finder = find.byTooltip('Orientation');
                  await tester.tap(finder);
                  await tester.pumpAndSettle();
                },
                expect: (context) => expect(
                  context.orientation,
                  equals(Orientation.landscape),
                ),
              );
            },
          );
        },
      );

      group(
        'Frame can be activated via',
        () {
          testWidgets(
            'onChanged',
            (WidgetTester tester) async {
              await testAddon(
                tester: tester,
                addon: addon,
                act: () async => addon.onChanged(
                  setting.copyWith(
                    hasFrame: true,
                  ),
                ),
                expect: (context) => expect(
                  addon.value.hasFrame,
                  equals(true),
                ),
              );
            },
          );

          testWidgets(
            'widget',
            (WidgetTester tester) async {
              await testAddon(
                tester: tester,
                addon: addon,
                act: () async {
                  final finder = find.byTooltip('Frame');
                  await tester.tap(finder);
                  await tester.pumpAndSettle();
                },
                expect: (context) => expect(
                  addon.value.hasFrame,
                  equals(false),
                ),
              );
            },
          );
        },
      );
    },
  );
}
