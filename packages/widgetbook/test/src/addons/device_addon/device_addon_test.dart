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

      group('Device can be activated via', () {
        testWidgets(
          'updateSetting',
          (WidgetTester tester) async {
            final device = devices.first;

            await testAddon(
              tester: tester,
              addon: addon,
              act: () async => addon.updateSetting(
                addon.setting.copyWith(
                  activeDevice: device,
                ),
              ),
              expect: (context) => expect(
                addon.setting.activeDevice,
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
                addon.setting.activeDevice,
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
            'updateSetting',
            (WidgetTester tester) async {
              await testAddon(
                tester: tester,
                addon: addon,
                act: () async => addon.updateSetting(
                  addon.setting.copyWith(
                    orientation: Orientation.landscape,
                  ),
                ),
                expect: (context) => expect(
                  addon.setting.orientation,
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
                addon: DeviceAddon(
                  devices: devices,
                  initialDevice: devices.first,
                ),
                act: () async {
                  final finder = find.byTooltip('Orientation');
                  await tester.tap(finder);
                  await tester.pumpAndSettle();
                },
                expect: (context) => expect(
                  addon.setting.orientation,
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
            'updateSetting',
            (WidgetTester tester) async {
              await testAddon(
                tester: tester,
                addon: addon,
                act: () async => addon.updateSetting(
                  addon.setting.copyWith(
                    hasFrame: true,
                  ),
                ),
                expect: (context) => expect(
                  addon.setting.hasFrame,
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
                  addon.setting.hasFrame,
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
