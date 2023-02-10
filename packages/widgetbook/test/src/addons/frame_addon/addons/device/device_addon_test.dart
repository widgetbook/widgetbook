import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../utils/addon_test_helper.dart';

void main() {
  group(
    '$DeviceAddon',
    () {
      final setting = DeviceSetting(
        activeDevice: Apple.iPhone13,
        devices: [
          Apple.iPhone12,
          Apple.iPhone13,
          Apple.iPhone13Mini,
        ],
      );

      late DeviceAddon addon;

      setUp(() {
        addon = DeviceAddon(
          setting: setting,
        );
      });

      group(
        'can access',
        () {
          testWidgets(
            '$Device via the context',
            (WidgetTester tester) async {
              await testAddon(
                tester: tester,
                addon: addon,
                expect: (context) => expect(
                  context.device,
                  equals(Apple.iPhone13),
                ),
              );
            },
          );

          testWidgets(
            '$Orientation via the context',
            (WidgetTester tester) async {
              await testAddon(
                tester: tester,
                addon: addon,
                expect: (context) => expect(
                  context.orientation,
                  equals(Orientation.portrait),
                ),
              );
            },
          );
        },
      );

      group('can activate another', () {
        testWidgets(
          '$Device',
          (WidgetTester tester) async {
            await testAddon(
              tester: tester,
              addon: addon,
              act: (context) async => addon.onChanged(
                context,
                setting.copyWith(activeDevice: Apple.iPhone13Mini),
              ),
              expect: (context) => expect(
                context.device,
                equals(Apple.iPhone13Mini),
              ),
            );
          },
        );

        testWidgets(
          '$Orientation',
          (WidgetTester tester) async {
            await testAddon(
              tester: tester,
              addon: addon,
              act: (context) async => addon.onChanged(
                context,
                setting.copyWith(orientation: Orientation.landscape),
              ),
              expect: (context) => expect(
                context.orientation,
                equals(Orientation.landscape),
              ),
            );
          },
        );
      });

      group(
        'can activate another',
        () {
          testWidgets(
            '$Device via Widget',
            (WidgetTester tester) async {
              await testAddon(
                tester: tester,
                addon: addon,
                act: (context) async {
                  final dropdownFinder = find.byType(
                    DropdownMenu<Device>,
                  );
                  await tester.tap(dropdownFinder);
                  await tester.pumpAndSettle();

                  final textFinder = find.byWidgetPredicate(
                    (widget) => widget is Text && widget.data == 'iPhone 12',
                  );
                  await tester.tap(textFinder.last);
                  await tester.pumpAndSettle();
                },
                expect: (context) => expect(
                  context.device,
                  equals(Apple.iPhone12),
                ),
              );
            },
          );

          testWidgets(
            '$Orientation via Widget',
            (WidgetTester tester) async {
              await testAddon(
                tester: tester,
                addon: addon,
                act: (context) async {
                  final dropdownFinder = find.byType(
                    DropdownMenu<Orientation>,
                  );
                  await tester.tap(dropdownFinder);
                  await tester.pumpAndSettle();

                  final textFinder = find.byWidgetPredicate(
                    (widget) => widget is Text && widget.data == 'landscape',
                  );
                  await tester.tap(textFinder.last);
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
    },
  );
}
