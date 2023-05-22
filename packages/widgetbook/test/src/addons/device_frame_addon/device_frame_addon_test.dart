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
